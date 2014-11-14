//
//  Page.h
//  CZFG
//
//  Created by lihong on 14/11/13.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Page : NSObject

@property (nonatomic, strong) NSString *text;       // 文本
@property (nonatomic, assign) NSInteger number;    // 页号
@property (nonatomic, assign) NSInteger totoalNumber; // 总页数
@property (nonatomic, strong) NSNumber *charCount;  // 字符数

@end
