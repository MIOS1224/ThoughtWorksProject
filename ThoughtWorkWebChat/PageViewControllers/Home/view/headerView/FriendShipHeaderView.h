//
//  FriendShipHeaderView.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendShipHeaderView : UITableViewHeaderFooterView<BaseViewProtocol>

@property (nonatomic, readwrite, assign) NSInteger section;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
