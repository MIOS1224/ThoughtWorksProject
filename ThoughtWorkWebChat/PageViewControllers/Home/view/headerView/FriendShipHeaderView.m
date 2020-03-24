//
//  FriendShipHeaderView.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "FriendShipHeaderView.h"
#import "FriendPhotosView.h"
#import "FriendItemViewModel.h"
#import "LCActionSheet.h"
#import "MomentOperationMoreView.h"
#import "AppDelegate.h"

@interface FriendShipHeaderView()

@property (nonatomic,weak) UIImageView *avatarView; // 头像
@property (nonatomic,weak) YYLabel *screenNameLable; // 昵称
@property (nonatomic,weak) YYLabel *contentLable; // 正文
@property (nonatomic,weak) UIButton *expandBtn; // 全文/收起 按钮
@property (nonatomic,weak) UIButton *operationMoreBtn; // 更多按钮
@property (nonatomic,weak) UIImageView *upArrowView; // upArrow
@property (nonatomic,weak) FriendPhotosView *photosView; // 配图View
@property (nonatomic,weak) MomentOperationMoreView *operationMoreView; // 更多操作view
@property (nonatomic,strong) FriendItemViewModel *viewModel; // viewModel

@end


@implementation FriendShipHeaderView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *ID = @"FriendShipHeaderView";
    FriendShipHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        // 缓存池中没有, 自己创建
        header = [[self alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 初始化
        [self _setup];
        
        // 初始化所有的子控件
        [self _setupSubViews];
        
        // 所有事件处理（PS：为了将UI和事件隔离）
        [self _dealWithAction];
    }
    return self;
}

#pragma mark - 初始化
- (void)_setup{
    self.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 公共方法
- (void)bindViewModel:(FriendItemViewModel *)viewModel{
    self.viewModel = viewModel;
    // 头像
    self.avatarView.frame = viewModel.avatarViewFrame;
    NSURL * url = [NSURL URLWithString:viewModel.moment.sender.avatar];
    [self.avatarView yy_setImageWithURL:url placeholder:[UIImage imageNamed:@"wx_avatar_default"] options:YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionAllowBackgroundTask completion:nil];
    // 昵称
    self.screenNameLable.textLayout = viewModel.screenNameLableLayout;
    self.screenNameLable.frame = viewModel.screenNameLableFrame;
    
    // 正文
    self.contentLable.textLayout = viewModel.contentLableLayout;
    self.contentLable.frame = viewModel.contentLableFrame;
    
    // 全文/收起
    self.expandBtn.frame = viewModel.expandBtnFrame;
    [self.expandBtn setTitle:viewModel.isExpand?@"收起":@"全文" forState:UIControlStateNormal];
    
    // 配图
    self.photosView.frame = viewModel.photosViewFrame;
    [self.photosView bindViewModel:viewModel];
    
    // 更多操作按钮
    self.operationMoreBtn.frame = viewModel.operationMoreBtnFrame;
    
    // 更多View
    self.operationMoreView.right = self.operationMoreBtn.frameX - MHMomentContentInnerMargin;
    self.operationMoreView.frameCenterY = self.operationMoreBtn.frameCenterY;
    self.operationMoreView.frameWidth = 0;
    [self.operationMoreView bindViewModel:viewModel];
    
    // 箭头
    self.upArrowView.frame = viewModel.upArrowViewFrame;
}

#pragma mark - 创建自控制器
- (void)_setupSubViews{
    // 用户头像
    UIImageView *avatarView = [[UIImageView alloc] init];
    avatarView.backgroundColor = self.contentView.backgroundColor;
    // 设置可交互
    avatarView.userInteractionEnabled = YES;
    self.avatarView = avatarView;
    [self.contentView addSubview:avatarView];
    
    // 昵称
    YYLabel *screenNameLable = [[YYLabel alloc] init];
    screenNameLable.backgroundColor = self.contentView.backgroundColor;
    screenNameLable.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    screenNameLable.displaysAsynchronously = NO;
    screenNameLable.ignoreCommonProperties = YES;
    screenNameLable.fadeOnAsynchronouslyDisplay = NO;
    screenNameLable.fadeOnHighlight = NO;
    [self.contentView addSubview:screenNameLable];
    self.screenNameLable = screenNameLable;
    
    // 正文
    YYLabel *contentLable = [[YYLabel alloc] init];
    contentLable.backgroundColor = self.contentView.backgroundColor;
    contentLable.textVerticalAlignment = YYTextVerticalAlignmentTop;
    contentLable.displaysAsynchronously = NO;
    contentLable.ignoreCommonProperties = YES;
    contentLable.fadeOnAsynchronouslyDisplay = NO;
    contentLable.fadeOnHighlight = NO;
    contentLable.preferredMaxLayoutWidth = MHMomentCommentViewWidth();
    [self.contentView addSubview:contentLable];
    self.contentLable = contentLable;
    
    // photosView
    FriendPhotosView *photosView = [[FriendPhotosView alloc] init];
    photosView.clipsToBounds = YES;
    photosView.backgroundColor = self.contentView.backgroundColor;
    self.photosView = photosView;
    [self.contentView addSubview:photosView];

    // 更多操作按钮
    UIButton *operationMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [operationMoreBtn setImage:[UIImage imageNamed:@"icon_operateMore"] forState:UIControlStateNormal];
    [operationMoreBtn setImage:[UIImage imageNamed:@"icon_operateMore_hl"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:operationMoreBtn];
    operationMoreBtn.backgroundColor = self.contentView.backgroundColor;
    self.operationMoreBtn = operationMoreBtn;
    
    // 展开、关闭按钮
    UIButton *expandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [expandBtn setTitle:@"全文" forState:UIControlStateNormal];
    [expandBtn setTitleColor:MyColorFromHexString(@"#5B6A92") forState:UIControlStateNormal];
    [expandBtn.titleLabel setFont:MyFontRegular(16)];
    [expandBtn setBackgroundImage:[UIImage yy_imageWithColor:MyColorFromHexString(@"#C7C7C7") size:CGSizeMake(MHMomentExpandButtonWidth, MHMomentExpandButtonHeight)] forState:UIControlStateHighlighted];
    // 子控件超出部分裁剪
    expandBtn.clipsToBounds = YES;
    [self.contentView addSubview:expandBtn];
    self.expandBtn = expandBtn;
    
    // 向上的箭头
    UIImageView *upArrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_uparrow"]];
    self.upArrowView = upArrowView;
    [self.contentView addSubview:upArrowView];
    
    // 更多操作
    MomentOperationMoreView *operationMoreView = [[MomentOperationMoreView alloc] init];
    [self.contentView addSubview:operationMoreView];
    self.operationMoreView = operationMoreView;

}

#pragma mark
- (void)_dealWithAction{
     // 事件处理
    @weakify(self);
    // 正文点击事件
    [self.contentLable setHighlightTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        // 点击事件
        @strongify(self);
        if (range.location >= text.length) return;
        YYTextHighlight *highlight = [text yy_attribute:YYTextHighlightAttributeName atIndex:range.location];
        NSDictionary *userInfo = highlight.userInfo;
        if (userInfo.count == 0) return;
        // 回调数据
        [self.viewModel.attributedTapCommand execute:userInfo];
    }];

    // 全文/收起
    [[self.expandBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *sender) {
         @strongify(self);
         // 更新子控件的frame
         [self.viewModel.expandOperationCmd execute:@(self.section)];
     }];
    
    // 更多按钮点击
    [[self.operationMoreBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *sender) {
         @strongify(self);
         // 这里实现判断 键盘是否已经抬起
         if (MySharedAppDelegate.isShowKeyboard) {
             [[UIWindow getKeyWindow]  endEditing:YES]; // 关掉键盘
         }else{
             // 固定位置
             self.operationMoreView.right = self.operationMoreBtn.frameX - MHMomentContentInnerMargin;
             self.operationMoreView.isShow?[self.operationMoreView hideWithAnimated:YES]:[self.operationMoreView showWithAnimated:YES];
             [self layoutIfNeeded];
         }
     }];
    // 点赞
    self.operationMoreView.attitudesClickedCallback = ^(MomentOperationMoreView *operationMoreView) {
        @strongify(self);
        [self.viewModel.attitudeOperationCmd execute:@(self.section)];
    };
    
    // 评论
    self.operationMoreView.commentClickedCallback = ^(MomentOperationMoreView *operationMoreView) {
        @strongify(self);
        [self.viewModel.commentSubject sendNext:@(self.section)];
    };

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

@end

