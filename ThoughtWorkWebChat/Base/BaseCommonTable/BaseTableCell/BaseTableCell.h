//
//  BaseTableCell.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseTableCell : UITableViewCell<BaseViewProtocol>

//注册
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSInteger)rows;

@end

NS_ASSUME_NONNULL_END
