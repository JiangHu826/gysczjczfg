//
//  BaseViewController.m
//  CZFG
//
//  Created by lihong on 14/11/13.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TabBarOverlayView" bundle:nil];
    NSArray *viewArray = [nib instantiateWithOwner:self options:nil];
    UIView *customView1 = [viewArray objectAtIndex:1];
    UIView *customView2 = [viewArray lastObject];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView1];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView2];
    
    UIButton *backButton = (UIButton *)[customView2 viewWithTag:1];
    self.dictionaryNameLable = (UILabel *)[customView2 viewWithTag:2];
    [backButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
