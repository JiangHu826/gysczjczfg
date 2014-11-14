//
//  ModelParser.h
//  CZFG
//
//  Created by lihong on 14/11/11.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ModelParserCompletedBlock)(NSArray *modelArray);
typedef void (^ModelParserErrorBlock)(NSError *error);

@interface ModelParser : NSObject
{
    @protected
    NSXMLParser *_xmlParser;
    ModelParserCompletedBlock _completedBlock;
    ModelParserErrorBlock _errorBlock;
}

- (id)initWithData:(NSData *)data;
- (void)parseWithCompletedBlock:(ModelParserCompletedBlock)cBlock errorBlock:(ModelParserErrorBlock)eBlock;

@end
