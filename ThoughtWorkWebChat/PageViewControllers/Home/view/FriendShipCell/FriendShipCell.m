//
//  FriendShipCell.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "FriendShipCell.h"
#import "AppDelegate.h"

@interface FriendShipCell ()<UIApplicationDelegate>

@property (nonatomic, readwrite, weak) YYLabel *contentLable;
@property (nonatomic , readwrite , strong) CommentLikeContentModel *viewModel;

@end

@implementation FriendShipCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"FriendShipCell";
    FriendShipCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self _setup];
        // 创建自控制器
        [self _setupSubViews];
    }
    return self;
}

#pragma mark - BindViewModel 子类重写
- (void)bindViewModel:(CommentLikeContentModel *)viewModel{
    self.viewModel = viewModel;
    self.contentLable.textLayout = viewModel.contentLableLayout;
    self.contentLable.frame = viewModel.contentLableFrame;
    
    self.selectionStyle = (viewModel.type == CommentLikeContentTypeComment)?UITableViewCellSelectionStyleDefault:UITableViewCellSelectionStyleNone;
    self.divider.hidden = viewModel.type == CommentLikeContentTypeComment;
}

#pragma mark - 初始化
- (void)_setup
{
    self.contentView.backgroundColor = MyColorFromHexString(@"#F3F3F5");
}

#pragma mark - 创建自控制器
- (void)_setupSubViews{
    // 选中颜色
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = MyColorFromHexString(@"#CED2DE");
    self.selectedBackgroundView = selectedView;
    
    // 正文
    YYLabel *contentLable = [[YYLabel alloc] init];
    contentLable.backgroundColor = self.contentView.backgroundColor;
    contentLable.textVerticalAlignment = YYTextVerticalAlignmentTop;
    contentLable.displaysAsynchronously = NO;
    contentLable.ignoreCommonProperties = YES;
    contentLable.fadeOnAsynchronouslyDisplay = NO;
    contentLable.fadeOnHighlight = NO;
    contentLable.preferredMaxLayoutWidth = MHMomentCommentViewWidth()-2*MHMomentCommentViewContentLeftOrRightInset;
    [self.contentView addSubview:contentLable];
    self.contentLable = contentLable;
    
    // 分割线
    UIImageView *divider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomLine_icon"]];
    divider.backgroundColor = MyColorFromHexString(@"#D9D8D9");
    self.divider = divider;
    [self.contentView addSubview:divider];
    
    // 事件处理
    @weakify(self);
    contentLable.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        @strongify(self);
        if (range.location >= text.length) return;
        YYTextHighlight *highlight = [text yy_attribute:YYTextHighlightAttributeName atIndex:range.location];
        NSDictionary *userInfo = highlight.userInfo;
        if (userInfo.count == 0) return;
        // 回调数据
        [self.viewModel.attributedTapCommand execute:userInfo];
    };
    
//    contentLable.highlightLongPressAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 点击事件
    // 先记录
    AppDelegate * appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BOOL showKeyboard = appdele.isShowKeyboard;
    appdele.showKeyboard = NO;
    [super touchesBegan:touches withEvent:event];
    appdele.showKeyboard = showKeyboard;
}

#pragma mark - Override
- (void)setFrame:(CGRect)frame{
    frame.origin.x = MHMomentContentLeftOrRightInset+MHMomentAvatarWH+MHMomentContentInnerMargin;
    frame.size.width = MHMomentCommentViewWidth();
    [super setFrame:frame];
}

#pragma mark - 布局
- (void)layoutSubviews{
    [super layoutSubviews];
    self.divider.frame =CGRectMake(0, self.frameHeight-0.5, self.frameWidth, 0.5f);
}


@end

