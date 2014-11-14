//
//  ModelController.m
//  PageView
//
//  Created by lihong on 14/11/12.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "Page.h"
#import "Content.h"
#import "ModelController.h"
#import "DataViewController.h"
#import <CoreText/CoreText.h>

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


@interface ModelController ()
@property (strong, nonatomic) NSMutableArray *pageData;
@end

@implementation ModelController

// 计算分页
- (void)setContent:(Content *)content
{
    _content = content;
    
    CGSize pageSize = [UIScreen mainScreen].applicationFrame.size;
    pageSize.height -= (64); // 64=状态栏高(20)+导航栏高(44)
    
    NSArray *array = [self findPageSplits:content.content size:pageSize font:[UIFont systemFontOfSize:17.0]];
    self.pageData = [NSMutableArray arrayWithCapacity:array.count];
    
    NSRange range = NSMakeRange(0, 0);
    for(NSInteger i = 0; i < array.count; i++)
    {
        Page *page = [Page new];
        [self.pageData addObject:page];
        
        NSNumber *charCount = [array objectAtIndex:i];
        range.length = charCount.integerValue;
        if(i != 0)
        {
            NSNumber *charCount = [array objectAtIndex:i-1];
            range.location += charCount.integerValue;
        }
        
        page.number = i+1;
        page.totoalNumber = array.count;
        page.charCount =charCount;
        page.text = [content.content substringWithRange:range];
    }
}

- (NSArray*) findPageSplits:(NSString*)string size:(CGSize)size font:(UIFont*)font;
{
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:32];
    CTFontRef fnt = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize,NULL);
    CFAttributedStringRef str = CFAttributedStringCreate(kCFAllocatorDefault,
                                                         (CFStringRef)string,
                                                         (CFDictionaryRef)[NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)fnt,kCTFontAttributeName,nil]);
    CTFramesetterRef fs = CTFramesetterCreateWithAttributedString(str);
    CFRange r = {0,0};
    CFRange res = {0,0};
    NSInteger str_len = [string length];
    do {
        CTFramesetterSuggestFrameSizeWithConstraints(fs,r, NULL, size, &res);
        r.location += res.length;
        [result addObject:[NSNumber numberWithInt:(int)res.length]];
    } while(r.location < str_len);
   
    CFRelease(fs);
    CFRelease(str);
    CFRelease(fnt);
    
    return result;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    
    dataViewController.page = self.pageData[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.page];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
