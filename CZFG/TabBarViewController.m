//
//  TabBarViewController.m
//  CZFG
//
//  Created by lihong on 14/11/11.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)loadView
{
    [super loadView];
    
    UINib *nib = [UINib nibWithNibName:@"TabBarOverlayView" bundle:nil];
    NSArray *viewArray = [nib instantiateWithOwner:self options:nil];
    UIView *overlayView = [viewArray firstObject];
    overlayView.frame = self.tabBar.bounds;
    [self.tabBar addSubview:overlayView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
