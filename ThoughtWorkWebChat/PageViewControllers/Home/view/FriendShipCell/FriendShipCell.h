//
//  FriendShipCell.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"
#import "CommentLikeContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendShipCell : UITableViewCell<BaseViewProtocol>

@property (nonatomic,weak) UIImageView *divider;
@property (nonatomic, readonly, weak) YYLabel *contentLable;
@property (nonatomic , readonly , strong) CommentLikeContentModel *viewModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
