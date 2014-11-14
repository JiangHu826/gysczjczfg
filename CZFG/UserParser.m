//
//  UserParser.m
//  CZFG
//
//  Created by lihong on 14/11/11.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "User.h"
#import "UserParser.h"

@interface UserParser()<NSXMLParserDelegate>
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, strong) NSMutableString *nodeValue;
@end

@implementation UserParser

- (void)parseWithCompletedBlock:(ModelParserCompletedBlock)cBlock errorBlock:(ModelParserErrorBlock)eBlock
{
    _completedBlock = cBlock;
    _errorBlock = eBlock;
    _xmlParser.delegate = self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if ([_xmlParser parse] == NO) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                eBlock(_xmlParser.parserError);
            });
        }
    });
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.users = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"TB_ConsumerMessage"]) {
        self.user = [User new];
    }
    
    self.nodeValue = nil;
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(self.nodeValue == nil) {
        self.nodeValue = [NSMutableString stringWithString:string];
    }else {
        [self.nodeValue appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"ConsumerID"]) {
        [self.users addObject:self.user];
    }
    
    if([elementName isEqualToString:@"ConsumerName"]) {
        self.user.userName = [self.nodeValue copy];
    }
    
    if([elementName isEqualToString:@"Consumeraccount"]) {
        self.user.account = [self.nodeValue copy];
    }
    
    if([elementName isEqualToString:@"ConsumerPwd"]) {
        self.user.password = [self.nodeValue copy];
    }
    
    if([elementName isEqualToString:@"ConsumerNum"]) {
        self.user.number = [self.nodeValue copy];
    }
    
    if ([elementName isEqualToString:@"Result"]) {
        self.user.loginResult = [self.nodeValue copy];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _completedBlock(self.users);
    });
}

@end
