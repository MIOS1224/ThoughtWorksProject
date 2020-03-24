//
//  BaseTableViewController.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/20.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableViewModel.h"
#import "BaseTableCell.h"
#import "BaseSectionGroupViewModel.h"
#import "BaseItemViewModel.h"
#import "BaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic,readonly,weak) BaseTableView *tableView;
//内容缩进
@property (nonatomic,readonly,assign) UIEdgeInsets contentInset;

- (void)reloadData;
// 子类需要重写
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end

NS_ASSUME_NONNULL_END
