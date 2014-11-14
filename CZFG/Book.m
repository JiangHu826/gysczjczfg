//
//  Book.m
//  CZFG
//
//  Created by lihong on 14/11/10.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "Book.h"

@implementation Book
- (NSString *)description
{
    return [NSString stringWithFormat:@"Name:%@ id:%@",self.name, self.bookId];
}
@end
