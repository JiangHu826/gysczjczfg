//
//  ModelController.h
//  PageView
//
//  Created by lihong on 14/11/12.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import <UIKit/UIKit.h>

@class Content;
@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

@property (nonatomic, strong) Content *content;

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

