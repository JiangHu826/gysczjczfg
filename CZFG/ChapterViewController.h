//
//  ChapterViewController.h
//  CZFG
//
//  Created by lihong on 14/11/11.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class Book;

@interface ChapterViewController : BaseViewController

- (void)updateViewWithBook:(Book *)book;

@end
