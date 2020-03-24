//
//  FriendItemModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendModel.h"
#import "ImageItemViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendItemViewModel : NSObject

@property (nonatomic,strong) FriendModel *moment; // 数据模型
@property (nonatomic,strong) YYTextLayout *screenNameLableLayout; // 昵称
@property (nonatomic,strong) YYTextLayout *contentLableLayout;    // 正文
@property (nonatomic,strong) YYTextLayout *locationLableLayout;   // 位置

@property (nonatomic,copy) NSArray <ImageItemViewModel *> *picInfos; // 配图
@property (nonatomic,assign , getter = isExpand) BOOL expand;     // 是否展开全文
@property (nonatomic, readonly, strong) NSMutableArray *dataSource; // 点赞+评论列表

@property (nonatomic,assign) CGRect avatarViewFrame; // 头像
@property (nonatomic,assign) CGRect contentLableFrame; // 正文
@property (nonatomic,assign) CGRect screenNameLableFrame; // 昵称

@property (nonatomic,assign) CGFloat height; // 整条说说的高度
@property (nonatomic,assign) CGRect videoViewFrame;
@property (nonatomic,assign) CGRect expandBtnFrame; // 全文/收起 按钮
@property (nonatomic,assign) CGRect photosViewFrame; // 配图View
@property (nonatomic,assign) CGRect upArrowViewFrame; // 箭头;
@property (nonatomic,assign) CGRect sourceLableFrame;
@property (nonatomic,assign) CGRect shareInfoViewFrame;
@property (nonatomic,assign) CGRect locationLableFrame;
@property (nonatomic,assign) CGRect operationMoreBtnFrame; // 更多按钮
@property (nonatomic, readonly, assign) CGRect createAtLableFrame;

#pragma mark 命令
// 更新事件回调
@property (nonatomic,strong) RACSubject *reloadSectionSubject;
@property (nonatomic,strong) RACSubject *commentSubject;// 评论回调
@property (nonatomic,strong) RACCommand *attributedTapCommand; // 富文本文字上的事件处理
@property (nonatomic, readonly, strong) RACCommand *attitudeOperationCmd;  // 赞cmd
@property (nonatomic, readonly, strong) RACCommand *expandOperationCmd;  // 展开全文/收起

// 更新 (点赞+评论)
- (void)updateUpArrow;
- (instancetype)initWithMoment:(FriendModel *)moment;

@end


NS_ASSUME_NONNULL_END
