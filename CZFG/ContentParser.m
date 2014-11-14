//
//  ContentParser.m
//  CZFG
//
//  Created by lihong on 14/11/11.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//


#import "Content.h"
#import "ContentParser.h"

@interface ContentParser()<NSXMLParserDelegate>
@property (nonatomic, strong) Content *content;
@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) NSMutableString *nodeValue;
@end

@implementation ContentParser

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
    self.contents = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"TB_Txt"]) {
        self.content = [Content new];
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
    if([elementName isEqualToString:@"TB_Txt"]) {
        [self.contents addObject:self.content];
    }
    
    if([elementName isEqualToString:@"TxtID"]) {
        self.content.contentId = [self.nodeValue copy];
    }
    
    if([elementName isEqualToString:@"TxtUrl"]) {
        self.content.url = [self.nodeValue copy];
    }
    
    if([elementName isEqualToString:@"txtContent"]) {
        self.content.content = [self.nodeValue copy];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _completedBlock(self.contents);
    });
}


@end
