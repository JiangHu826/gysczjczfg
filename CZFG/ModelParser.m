//
//  ModelParser.m
//  CZFG
//
//  Created by lihong on 14/11/11.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "ModelParser.h"

@implementation ModelParser

- (id)initWithData:(NSData *)data
{
    self = [super init];
    if(self)
    {
        _xmlParser = [[NSXMLParser alloc] initWithData:data];
        
    }
    return self;
}

- (void)parseWithCompletedBlock:(ModelParserCompletedBlock)cBlock errorBlock:(ModelParserErrorBlock)eBlock
{
    NSAssert(NO, @"请在子类中重写此方法来实现解析功能!包括设置_xmlParser的代理,给_completedBlock,_errorBlock赋值!");
}

@end
