//
//  LoginViewController.m
//  CZFG
//
//  Created by lihong on 14/11/10.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "User.h"
#import "SCLAlertView.h"
#import "WebService.h"
#import "TabBarViewController.h"
#import "LoginViewController.h"

NSString *const kUserLoginSuccessNotifaction = @"UserLoginSuccessNotifaction";

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextView;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end


@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [[UIImage imageNamed:@"login_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 48, 14, 48)];
    [self.loginButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:image forState:UIControlStateHighlighted];
}

- (IBAction)clickOnLoginButton:(UIButton *)sender
{
    if (self.userNameTextView.text.length == 0 ) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert showError:self title:nil subTitle:@"请填写用户名" closeButtonTitle:@"关闭" duration:0.0];
        return;
    }
    
    if (self.userPasswordTextView.text.length == 0) {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert showError:self title:nil subTitle:@"请填写密码" closeButtonTitle:@"关闭" duration:0.0];
        return;
    }
    
    User *user = [User new];
    user.account = self.userNameTextView.text;
    user.password = self.userPasswordTextView.text;
    
    [self modifyControlState:NO];
    [WebService userLoginWithUser:user completedBlock:^(BOOL result) {
        
        [self modifyControlState:YES];
        if(result == NO)
        {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert showError:self title:nil subTitle:@"用户名或密码错误" closeButtonTitle:@"关闭" duration:0.0];
            return;
        }
        
        self.userPasswordTextView.text = @"";
        TabBarViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController.h"];
        [self presentViewController:viewController animated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginSuccessNotifaction object:nil];
        }];
        
    } errorBlock:^(NSError *error) {
        
        [self modifyControlState:YES];
        
        NSString *message = [NSString stringWithFormat:@"登录失败,%@",[error localizedDescription]];
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert showError:self title:nil subTitle:message closeButtonTitle:@"关闭" duration:0.0];
    }];
}

- (void)modifyControlState:(BOOL)yesOrNo
{
    self.userNameTextView.enabled = yesOrNo;
    self.userPasswordTextView.enabled = yesOrNo;
    self.loginButton.enabled = yesOrNo;
    
    if(yesOrNo) {
        [self.activityIndicator stopAnimating];
    }else {
        [self.activityIndicator startAnimating];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
