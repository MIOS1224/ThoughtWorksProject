//
//  MomentOperationMoreView.h
//  ZMUke
//
//  Created by liqian on 2018/11/1.
//  Copyright © 2018 zmlearn. All rights reserved.
//  微信朋友圈 更多按钮（评论|点赞）

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"

@class MomentOperationMoreView;

@interface MomentOperationMoreView : UIImageView<BaseViewProtocol>

// 是否已显示
@property (nonatomic, readonly, assign) BOOL isShow;

// 点赞按钮点击回调 （PS: 这类将事件 封装出去 目的是为了 最终回调视图控制器 将section 回调上去）
@property (nonatomic,copy) void (^attitudesClickedCallback)(MomentOperationMoreView *operationMoreView);
// 评论按钮点击回调 （PS: 这类将事件 封装出去 目的是为了 最终回调视图控制器 将section 回调上去）
@property (nonatomic,copy) void (^commentClickedCallback)(MomentOperationMoreView *operationMoreView);

// 显示 -- 默认有动画
- (void)showWithAnimated:(BOOL)animated;
// 隐藏 (动画)
- (void)hideWithAnimated:(BOOL)animated;
// 延迟 隐藏动画
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

// 隐藏所有操作Menu
+ (void)hideAllOperationMoreViewWithAnimated:(BOOL)animated;

+ (instancetype)operationMoreView;
@end
