//
//  MomentOperationMoreView.m
//  ZMUke
//
//  Created by liqian on 2018/11/1.
//  Copyright © 2018 zmlearn. All rights reserved.
//

#import "MomentOperationMoreView.h"
#import "MomentOperationMoreItemView.h"
#import "FriendItemViewModel.h"
#import "AppDelegate.h"

// Hide Notification
static NSString * const MomentOperationMoreViewHideNotification = @"MomentOperationMoreViewHideNotification";
static NSString * const MomentOperationMoreViewHideUserInfoKey = @"MomentOperationMoreViewHideUserInfoKey";


@interface MomentOperationMoreView ()
// viewModel
@property (nonatomic,strong) FriendItemViewModel *viewModel;
// 点赞
@property (nonatomic,weak) MomentOperationMoreItemView *attitudesBtn;
// 评论
@property (nonatomic,weak) MomentOperationMoreItemView *commentBtn;
// 分割线
@property (nonatomic,weak) UIImageView *divider;
// 是否已显示
@property (nonatomic,assign) BOOL isShow;

@end

@implementation MomentOperationMoreView

+ (instancetype)operationMoreView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置能交互
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableImage:@"wx_albumOperateMoreViewBkg_40x39"];
        // 当宽度为0的时候 子控件也消失
        self.clipsToBounds = YES;
        // 高亮状态下的背景色
        // 评论
        UIImage * cBackgroundImage = [UIImage resizableImage:@"wx_albumCommentBackgroundHL_15x39"];
        // 赞
        UIImage * aBackgroundImage = [UIImage resizableImage:@"wx_albumLikeBackgroundHL_15x39"];
        // 设置点赞按钮
        MomentOperationMoreItemView *attitudesBtn = [MomentOperationMoreItemView buttonWithType:UIButtonTypeCustom];
        [attitudesBtn setTitle:@"赞" forState:UIControlStateNormal];
        [attitudesBtn setImage:[UIImage imageNamed:@"wx_albumLike_20x20"] forState:UIControlStateNormal];
        [attitudesBtn setImage:[UIImage imageNamed:@"wx_albumLikeHL_20x20"] forState:UIControlStateHighlighted];
        [attitudesBtn setBackgroundImage:aBackgroundImage forState:UIControlStateHighlighted];
        // 开启点击动画
        attitudesBtn.allowAnimationWhenClick = YES;
        self.attitudesBtn = attitudesBtn;
        [self addSubview:attitudesBtn];
        
        // 设置分割线
        UIImageView *divider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wx_albumCommentLine_0x24"]];
        self.divider = divider;
        [self addSubview:divider];
        
        // 设置评论按钮
        MomentOperationMoreItemView *commentBtn = [MomentOperationMoreItemView buttonWithType:UIButtonTypeCustom];
        [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        [commentBtn setImage:[UIImage imageNamed:@"wx_albumCommentSingleA_20x20"] forState:UIControlStateNormal];
        [commentBtn setImage:[UIImage imageNamed:@"wx_albumCommentSingleAHL_20x20"] forState:UIControlStateHighlighted];
        [commentBtn setBackgroundImage:cBackgroundImage forState:UIControlStateHighlighted];
        self.commentBtn = commentBtn;
        [self addSubview:commentBtn];
        
        // 事件处理
        @weakify(self);
        // 点赞点击事件
        [[attitudesBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(UIButton *sender) {
             @strongify(self);
             !self.attitudesClickedCallback?:self.attitudesClickedCallback(self);
             [self hideAnimated:YES afterDelay:0.2f];
             
         }];
        // 评论点击事件
        [[commentBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(UIButton *sender) {
             @strongify(self);
             // 这里实现判断 键盘是否已经抬起
             if (MySharedAppDelegate.isShowKeyboard) {
                 [[UIWindow getKeyWindow] endEditing:YES]; // 关掉键盘
             }else{
                 !self.commentClickedCallback?:self.commentClickedCallback(self);
                 [self hideAnimated:YES afterDelay:0.1];
             }
         }];
        
        // 添加通知
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:MomentOperationMoreViewHideNotification object:nil] subscribeNext:^(NSNotification * note) {
            @strongify(self);
            BOOL animated = [note.userInfo[MomentOperationMoreViewHideUserInfoKey] boolValue];
            [self hideWithAnimated:animated];
        }];
    }
    return self;
}

#pragma mark - Show Or Hide
- (void)showWithAnimated:(BOOL)animated
{
    if (self.isShow) return;
    // 隐藏之前显示的所有的MoreView
    [[self class] hideAllOperationMoreViewWithAnimated:YES];
    self.isShow = YES;
    
    if (!animated) {
        self.frameWidth = 181.0f;
        self.frameX = self.frameX - self.frameWidth;
        return;
    }
    // 动画
    [UIView animateWithDuration:0.2f delay:0 usingSpringWithDamping:.7f initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.frameWidth = 181.0f;
        self.frameX = self.frameX - self.frameWidth;
    } completion:^(BOOL finished) { }];
}

- (void)hideWithAnimated:(BOOL)animated
{
    [self hideAnimated:animated afterDelay:0];
}

- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay
{
    if (!self.isShow) return;
     self.isShow = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!animated) {
            // 无动画
            self.frameX = self.frameX + self.frameWidth;
            self.frameWidth = 0;
            self.isShow = NO;
            return ;
        }
        // 动画
        [UIView animateWithDuration:0.2f delay:0 usingSpringWithDamping:1.0f initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.frameX = self.frameX + self.frameWidth;
            self.frameWidth = 0;
        } completion:^(BOOL finished) {}];
    });
}

// 隐藏所有操作Menu
+ (void)hideAllOperationMoreViewWithAnimated:(BOOL)animated;{
    // 发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:MomentOperationMoreViewHideNotification object:nil userInfo:@{MomentOperationMoreViewHideUserInfoKey:@(animated)}];
}

#pragma mark - BinderData
- (void)bindViewModel:(FriendItemViewModel *)viewModel{
    self.viewModel = viewModel;
    // 直接设置 normal 状态下文字即可
    [self.attitudesBtn setTitle:viewModel.moment.attitudesStatus == 0?@"赞":@"取消" forState:UIControlStateNormal];
}


- (void)setFrame:(CGRect)frame{
    // 固定高度
    frame.size.height = 39.0f;
    [super setFrame:frame];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 布局赞
    CGFloat attitudesBtnW = (self.frameWidth - self.divider.frameWidth)*.5f;
    CGFloat attitudesBtnH = self.frameHeight;
    self.attitudesBtn.frameSize = CGSizeMake(attitudesBtnW, attitudesBtnH);
    
    // 布局分割线
    self.divider.frameX = CGRectGetMaxX(self.attitudesBtn.frame);
    self.divider.frameCenterY = self.frameHeight*.5f;
    
    // 布局评论
    CGFloat commentBtnX = CGRectGetMaxX(self.divider.frame);
    CGFloat commentBtnW = attitudesBtnW;
    CGFloat commentBtnH = attitudesBtnH;
    self.commentBtn.frame = CGRectMake(commentBtnX, 0, commentBtnW, commentBtnH);
}

@end
