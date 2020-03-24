
//
//  CommentHeaderView.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "CommentHeaderView.h"
#import "AvatarHeaderView.h"
#import "UserInfoViewModel.h"
#import "AvatarHeaderView.h"
@interface CommentHeaderView ()

@property (nonatomic,weak) UIButton *coverBtn; //封面
@property (nonatomic,weak) UIImageView *divider;  //分割线
@property (nonatomic,weak) YYLabel *screenNameLable; //昵称
@property (nonatomic,weak) AvatarHeaderView *avatarView; //头像
@property (nonatomic,strong) UserInfoViewModel *viewModel;

@end

@implementation CommentHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        // 创建自控制器
        [self setupSubViews];
        // 布局子控件
        [self makeSubViewsConstraints];
    }
    return self;
}

#pragma mark - 创建自控制器
- (void)setupSubViews{
    UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    @weakify(self);
    [[coverBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        @strongify(self);
        self.viewModel.unread = 10;
    }];
    //设备背景
    self.coverBtn = coverBtn;
    [self.coverBtn setImage:[UIImage imageNamed:@"WechatIMG675"] forState:(UIControlStateNormal)];
    [self addSubview:coverBtn];
    
    //昵称
    YYLabel *screenNameLable = [[YYLabel alloc] init];
    screenNameLable.backgroundColor = [UIColor clearColor];
    screenNameLable.textAlignment = NSTextAlignmentRight;
    screenNameLable.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    screenNameLable.displaysAsynchronously = NO;
    screenNameLable.ignoreCommonProperties = NO;
    screenNameLable.fadeOnAsynchronouslyDisplay = NO;
    screenNameLable.fadeOnHighlight = NO;
    self.screenNameLable = screenNameLable;
    [coverBtn addSubview:screenNameLable];
    
    //头像
    AvatarHeaderView *avatarView = [[AvatarHeaderView alloc] init];
    avatarView.layer.borderWidth = 3.0f;
    avatarView.layer.cornerRadius = 10.0f;
    avatarView.layer.borderColor = MyColorFromHexString(@"#F2F2F2").CGColor;
    self.avatarView = avatarView;
    avatarView.touchBlock = ^(AvatarHeaderView *view, YYGestureRecognizerState state, NSSet *touches, UIEvent *event) {
        
        
    };
    [self addSubview:avatarView];
}

#pragma mark - 布局子控件
- (void)makeSubViewsConstraints{
    //布局封面
    [self.coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(self);
        make.height.mas_equalTo(@(MY_TABLEHEADERHEIGHT));
    }];
    
    //布局头像
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(MHMomentProfileViewAvatarViewWH);
        make.right.equalTo(self).with.offset(-MHMomentContentInnerMargin);
        make.top.equalTo(self.coverBtn.mas_bottom).with.offset(24-MHMomentProfileViewAvatarViewWH);
    }];
    //布局昵称
    [self.screenNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.coverBtn).with.offset(-MHMomentContentInnerMargin);
        make.right.equalTo(self.avatarView.mas_left).with.offset(-MHMomentContentLeftOrRightInset);
        make.left.equalTo(self.coverBtn);
    }];
}

#pragma mark - BindData
- (void)bindViewModel:(UserInfoViewModel *)viewModel{
    
    self.viewModel = viewModel;
    
    //封面
    UIImage * image = [UIImage imageNamed:viewModel.user.avatar];
    [self.coverBtn setBackgroundImage:image forState:UIControlStateNormal];
    self.screenNameLable.attributedText = viewModel.screenNameAttr;
    
    //头像
    NSURL * avatar = [NSURL URLWithString:viewModel.user.avatar];
    @weakify(self);
    //    self.avatarView.image
    [self.avatarView.layer yy_setImageWithURL:avatar placeholder:[UIImage imageNamed:@"wx_avatar_default"] options:YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionAllowBackgroundTask|YYWebImageOptionAvoidSetImage completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        @strongify(self);
        if (image && stage == YYWebImageStageFinished) self.avatarView.image = image;
    }];}

@end

