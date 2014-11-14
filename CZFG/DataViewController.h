//
//  DataViewController.h
//  PageView
//
//  Created by lihong on 14/11/12.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Page.h"

@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UIView *dataLabelContainerView;

@property (strong, nonatomic) Page *page;

@end

