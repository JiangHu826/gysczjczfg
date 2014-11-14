//
//  ChapterViewController.m
//  CZFG
//
//  Created by lihong on 14/11/11.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "WebService.h"
#import "MBProgressHUD.h"
#import "SCLAlertView.h"
#import "ChapterViewController.h"
#import "SectionViewController.h"

@interface ChapterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLabel;
@property (nonatomic, strong) Book *book;
@end

@implementation ChapterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bookNameLabel.text = self.book.name;
    self.dictionaryNameLable.text = @"目录";
}

// updateViewWith可能会先于viewDidLoad
- (void)updateViewWithBook:(Book *)book
{
    self.book = book;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"获取目录";
    
    [WebService getChapterWithBookId:book.bookId completedBlock:^(NSArray *modelArray) {
        hud.hidden = YES;
        self.dataSource = modelArray;
        [self.tableView reloadData];
        
    } errorBlock:^(NSError *error) {
        
        hud.hidden = YES;
        NSString *message = [NSString stringWithFormat:@"获取数据失败,%@",[error localizedDescription]];
        [SCLAlertView showErrorMessage:message viewController:self retryBlock:^{
            [self updateViewWithBook:self.book];
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const kCellReuseId = @"ChapterCellReuseIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseId];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseId];
    }
    
    Chapter *chapter = self.dataSource[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = chapter.name;
    cell.imageView.image = [UIImage imageNamed:@"chapter"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Chapter *chapter = self.dataSource[indexPath.row];
    
    SectionViewController *viewControlelr = [self.storyboard instantiateViewControllerWithIdentifier:@"SectionViewController"];
   //viewControlelr.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:viewControlelr animated:YES];
    [viewControlelr updateViewWithChapter:chapter];
}

@end
