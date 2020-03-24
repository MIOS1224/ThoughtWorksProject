//
//  FriendShipViewModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewModel.h"
#import "UserInfoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendShipViewModel : BaseTableViewModel

@property (nonatomic, readonly, strong) RACSubject *phoneSubject; // 电话号码回调
@property (nonatomic, readonly, strong) RACSubject *commentSubject; // 评论回调
@property (nonatomic, readonly, strong) RACSubject *reloadSectionSubject; // 刷新某一个section的 事件回调

@property (nonatomic, readonly, strong) UserInfoViewModel *profileViewModel;  // 个人信息头部视图模型

@property (nonatomic, readonly, strong) RACCommand *commentCommand; // 发送评论内容
@property (nonatomic, readonly, strong) RACCommand *delCommentCommand; // 删除当前用户的评论
@property (nonatomic, readonly, strong) RACCommand *delMomentCommand;  // 删除当前用户的发的说说
@property (nonatomic, readonly, strong) RACCommand *attributedTapCommand; // 富文本文字上的事件处理

@end

NS_ASSUME_NONNULL_END
