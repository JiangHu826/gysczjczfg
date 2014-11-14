//
//  SectionViewController.m
//  CZFG
//
//  Created by lihong on 14/11/11.
//  Copyright (c) 2014年 李红(410139419@qq.com). All rights reserved.
//

#import "WebService.h"
#import "SectionCell.h"
#import "MBProgressHUD.h"
#import "SCLAlertView.h"
#import "SectionViewController.h"
#import "RootViewController.h"

@interface SectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UILabel *chapterNameLable;
@property (nonatomic, strong) Chapter *chapter;
@end

@implementation SectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.chapterNameLable.text = self.chapter.name;
    self.dictionaryNameLable.text = @"章节";

    UINib *nib = [UINib nibWithNibName:@"SectionCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"SectonCell"];
}

- (void)updateViewWithChapter:(Chapter *)chapter
{
    self.chapter = chapter;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"获取章节";
    
    [WebService getSectionWithChapterId:chapter.chapterId completedBlock:^(NSArray *modelArray) {
        [hud hide:YES];
        self.dataSource = modelArray;
        [self.tableView reloadData];
        
    } errorBlock:^(NSError *error) {
        
        hud.hidden = YES;
        NSString *message = [NSString stringWithFormat:@"获取数据失败,%@",[error localizedDescription]];
        [SCLAlertView showErrorMessage:message viewController:self retryBlock:^{
            [self updateViewWithChapter:self.chapter];
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const kCellReuseId = @"SectonCell";
    SectionCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseId];
    
    Section *section = self.dataSource[indexPath.row];
    cell.titleLable.text = section.name;
    cell.subTitleLable.text = section.number;
    cell.iconView.image = [UIImage imageNamed:@"section"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Section *section = self.dataSource[indexPath.row];
    RootViewController *viewControlelr = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
    //viewControlelr.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:viewControlelr animated:YES];
   [viewControlelr updateViewWithSection:section];
    
}


@end
