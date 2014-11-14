//
//  WebService.m
//  CZFG
//
//  Created by lihong on 14/11/10.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "WebService.h"
#import "SOAPClient.h"
#import "ChapterParser.h"
#import "SectionParser.h"
#import "ContentParser.h"
#import "UserParser.h"

static NSString *const kXmlns = @"http://tempuri.org";
static NSString *const kKey = @"yfr6D+qBPjjliRmZj5ZRd0oH9vmW1FWd";
static NSString *const kMNGetBook = @"TB_Volume_GetList";
static NSString *const kMNGetChapter = @"TB_Catalogue_GetList";
static NSString *const kMNGetSection = @"TB_Chapters_GetList";
static NSString *const kMNGetContent = @"TB_Txt_GetList";
static NSString *const KMNUserLogin = @"TB_ConsumerMessageLogin";

@implementation WebService

+ (void)userLoginWithUser:(User *)user completedBlock:(void(^)(BOOL result))cBlock errorBlock:(ModelParserErrorBlock)eBlock
{
    NSDictionary *params = @{@"Consumeraccount":user.account,@"ConsumerPwd":user.password,@"Key":kKey};
    
    SOAPClient *client = [[SOAPClient alloc] initWithMethod:KMNUserLogin xmlns:kXmlns params:params requestUrl:kRequestUrl completedBlock:^(NSData *result) {
        
        UserParser  *parser = [[UserParser alloc] initWithData:result];
        [parser parseWithCompletedBlock:^(NSArray *modelArray) {
            User *user = [modelArray firstObject];
            cBlock([user.loginResult isEqualToString:@"0"]);
            
        } errorBlock:^(NSError *error) {
            eBlock(error);
        }];
        
    } errorBlock:^(NSError *error) {
        eBlock(error);
    }];
    
    [client startAsyncRequest];
}

+ (void)getBookWithCompletedBlock:(ModelParserCompletedBlock)cBlock errorBlock:(ModelParserErrorBlock)eBlock
{
   SOAPClient *client = [[SOAPClient alloc] initWithMethod:kMNGetBook xmlns:kXmlns params:@{@"Key":kKey} requestUrl:kRequestUrl completedBlock:^(NSData *result) {
       
          BookParser *parser = [[BookParser alloc] initWithData:result];
          [parser parseWithCompletedBlock:^(NSArray *modelArray) {
              cBlock(modelArray);
          } errorBlock:^(NSError *error) {
              eBlock(error);
          }];
       
      } errorBlock:^(NSError *error) {
          eBlock(error);
      }];
    
    [client startAsyncRequest];
}


+ (void)getChapterWithBookId:(NSString *)bookId completedBlock:(ModelParserCompletedBlock)cBlock errorBlock:(ModelParserErrorBlock)eBlock
{
    NSDictionary *params = @{@"Key":kKey,@"VolumeID":bookId};
    
    SOAPClient *client = [[SOAPClient alloc] initWithMethod:kMNGetChapter xmlns:kXmlns params:params requestUrl:kRequestUrl completedBlock:^(NSData *result) {
        
        ChapterParser *parser = [[ChapterParser alloc] initWithData:result];
        [parser parseWithCompletedBlock:^(NSArray *modelArray) {
            cBlock(modelArray);
        } errorBlock:^(NSError *error) {
            eBlock(error);
        }];
        
    } errorBlock:^(NSError *error) {
        eBlock(error);
    }];
    
    [client startAsyncRequest];
}

+ (void)getSectionWithChapterId:(NSString *)chapterId completedBlock:(ModelParserCompletedBlock)cBlock errorBlock:(ModelParserErrorBlock)eBlock
{
    NSDictionary *params = @{@"Key":kKey,@"CatalogueID":chapterId};
    
    SOAPClient *client = [[SOAPClient alloc] initWithMethod:kMNGetSection xmlns:kXmlns params:params requestUrl:kRequestUrl completedBlock:^(NSData *result) {
        
        SectionParser *parser = [[SectionParser alloc] initWithData:result];
        [parser parseWithCompletedBlock:^(NSArray *modelArray) {
            cBlock(modelArray);
        } errorBlock:^(NSError *error) {
            eBlock(error);
        }];
        
    } errorBlock:^(NSError *error) {
        eBlock(error);
    }];
    
    [client startAsyncRequest];
}

+ (void)getContentWithSectionId:(NSString *)sectionId completedBlock:(ModelParserCompletedBlock)cBlock errorBlock:(ModelParserErrorBlock)eBlock
{
    NSDictionary *params = @{@"Key":kKey,@"ChaptersID":sectionId};
    
    SOAPClient *client = [[SOAPClient alloc] initWithMethod:kMNGetContent xmlns:kXmlns params:params requestUrl:kRequestUrl completedBlock:^(NSData *result) {
        
        ContentParser *parser = [[ContentParser alloc] initWithData:result];
        [parser parseWithCompletedBlock:^(NSArray *modelArray) {
            cBlock(modelArray);
        } errorBlock:^(NSError *error) {
            eBlock(error);
        }];
        
    } errorBlock:^(NSError *error) {
        eBlock(error);
    }];
    
    [client startAsyncRequest];
}
@end
