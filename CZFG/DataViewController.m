//
//  DataViewController.m
//  PageView
//
//  Created by lihong on 14/11/12.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@end

@implementation DataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataLabel.font = [UIFont systemFontOfSize:17.0];
    
    CGSize pageSize = [UIScreen mainScreen].applicationFrame.size;
    pageSize.height -= 64;
    
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:17.0]};
    CGRect frame = [self.page.text boundingRectWithSize:pageSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    self.dataLabelContainerView.frame = frame;
    self.dataLabel.text = self.page.text;
    self.percentLabel.text = [NSString stringWithFormat:@"%zd/%zd",self.page.number,self.page.totoalNumber];
    
    self.percentLabel.alpha = 1.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2 animations:^{
            self.percentLabel.alpha = 0.0;
        }];
    });
}

@end
