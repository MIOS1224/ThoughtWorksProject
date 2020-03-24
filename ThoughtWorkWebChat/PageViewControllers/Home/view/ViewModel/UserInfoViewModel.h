//
//  UserInfoViewModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoViewModel : BaseTableViewModel

@property (nonatomic,assign) NSInteger unread; //消息未读数
@property (nonatomic,strong) UserModel *unreadUser; //未读消息的用户

@property (nonatomic, readonly, assign) CGFloat height;
@property (nonatomic, readonly, strong) UserModel *user; //用户模型
@property (nonatomic, readonly, copy) NSAttributedString *screenNameAttr; //昵称

- (instancetype)initWithUser:(UserModel *)user;

@end

NS_ASSUME_NONNULL_END
