//
//  BookViewController.m
//  CZFG
//
//  Created by lihong on 14/11/11.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "WebService.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "SCLAlertView/SCLAlertView.h"
#import "BookViewController.h"
#import "ChapterViewController.h"

extern  NSString *const kUserLoginSuccessNotifaction;

@interface BookViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation BookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBookDataAndUpdateView) name:kUserLoginSuccessNotifaction object:nil];
}

- (void)popViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)loadBookDataAndUpdateView
{
    if(self.dataSource.count > 0) {
        [self.dataSource removeAllObjects];
        [self.tableView reloadData];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"获取数据";
    
    [WebService getBookWithCompletedBlock:^(NSArray *modelArray) {
        [hud hide:YES];
        self.dataSource = [NSMutableArray arrayWithArray:modelArray];
        [self.tableView reloadData];
        
    } errorBlock:^(NSError *error) {
        
        hud.hidden = YES;
        NSString *message = [NSString stringWithFormat:@"获取数据失败,%@",[error localizedDescription]];
        [SCLAlertView showErrorMessage:message viewController:self retryBlock:^{
            [self loadBookDataAndUpdateView];
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const kCellReuseId = @"BookCellReuseIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseId];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseId];
    }
    
    Book *book = self.dataSource[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = book.name;
    cell.imageView.image = [UIImage imageNamed:@"book"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Book *book = self.dataSource[indexPath.row];
    
     ChapterViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChapterViewController"];
    //viewController.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController updateViewWithBook:book];
}
@end
