//
//  HomePageController.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  普通列表tableview

#import "HomePageController.h"
#import "BaseTableCell.h"
#import "BaseItemViewModel.h"
#import "BaseTableViewModel.h"
#import "FriendShipController.h"
#import "BaseSectionGroupViewModel.h"

@interface HomePageController ()

@property (nonatomic, readonly, strong) BaseTableViewModel *viewModel;

@end

@implementation HomePageController
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Override
- (void)bindViewModel{
    [super bindViewModel];
}
#pragma mark - sub class can override it
- (UIEdgeInsets)contentInset{
    return UIEdgeInsetsMake(MY_APPLICATION_TOP_BAR_HEIGHT, 0, 0, 0);
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BaseSectionGroupViewModel *groupViewModel = self.viewModel.dataSource[section];
    return groupViewModel.itemViewModels.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseSectionGroupViewModel *groupViewModel = self.viewModel.dataSource[indexPath.section];
    BaseItemViewModel *itemViewModel = groupViewModel.itemViewModels[indexPath.row];
    return itemViewModel.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableCell *cell =  [BaseTableCell cellWithTableView:tableView];
    BaseSectionGroupViewModel *groupViewModel = self.viewModel.dataSource[indexPath.section];
    [cell setIndexPath:indexPath rowsInSection:groupViewModel.itemViewModels.count];  //cell 配置
    
    id object = groupViewModel.itemViewModels[indexPath.row];
    [cell bindViewModel:object];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //页面跳转
    FriendShipController * ship = [[FriendShipController alloc]initWithViewModel:[[FriendShipViewModel alloc]init]];
    ship.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ship animated:YES];
}
@end
