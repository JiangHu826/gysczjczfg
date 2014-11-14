//
//  WebService.h
//  CZFG
//
//  Created by lihong on 14/11/10.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
#import "Chapter.h"
#import "Section.h"
#import "Content.h"
#import "BookParser.h"
#import "User.h"

@interface WebService : NSObject

+ (void)userLoginWithUser:(User *)user completedBlock:(void(^)(BOOL result))cBlock errorBlock:(ModelParserErrorBlock)eBlock;

+ (void)getBookWithCompletedBlock:(ModelParserCompletedBlock)cBlock errorBlock:(ModelParserErrorBlock)eBlock;

+ (void)getChapterWithBookId:(NSString *)bookId completedBlock:(ModelParserCompletedBlock)cBlock errorBlock:(ModelParserErrorBlock)eBlock;

+ (void)getSectionWithChapterId:(NSString *)chapterId completedBlock:(ModelParserCompletedBlock)cBlock errorBlock:(ModelParserErrorBlock)eBlock;

+ (void)getContentWithSectionId:(NSString *)sectionId completedBlock:(ModelParserCompletedBlock)cBlock errorBlock:(ModelParserErrorBlock)eBlock;

@end
