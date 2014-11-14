//
//  RootViewController.h
//  PageView
//
//  Created by lihong on 14/11/12.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class Section;

@interface RootViewController : BaseViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

- (void)updateViewWithSection:(Section *)section;

@end

