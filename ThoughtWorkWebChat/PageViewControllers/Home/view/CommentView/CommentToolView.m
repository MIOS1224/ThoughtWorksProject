//
//  CommentToolView.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "CommentToolView.h"
#import "CommentReplyItemViewModel.h"

@interface CommentToolView () <YYTextViewDelegate>

@property (nonatomic,assign) CGFloat toHeight;

@property (nonatomic,weak) UIView *topLine;
@property (nonatomic,weak) UIView *bottomLine;

@property (nonatomic,weak) UIButton *emoticonBtn; // emoticonBtn
@property (nonatomic,weak) YYTextView *textView;  // textView
@property (nonatomic,assign) CGFloat previousTextViewContentHeight; //编辑框的高度

@property (nonatomic,strong) CommentReplyItemViewModel *viewModel;

@end


@implementation CommentToolView
#pragma mark - Public Method
- (BOOL)canBecomeFirstResponder{
    return [self.textView canBecomeFirstResponder];
}
- (BOOL)becomeFirstResponder{
    return [self.textView becomeFirstResponder];
}
- (BOOL)canResignFirstResponder{
    return [self.textView canResignFirstResponder];
}
- (BOOL)resignFirstResponder {
    return [self.textView resignFirstResponder];
}


// 绑定数据模型
- (void)bindViewModel:(CommentReplyItemViewModel *)viewModel{
    self.viewModel = viewModel;
    self.textView.placeholderText = self.viewModel.isReply?[NSString stringWithFormat:@"回复%@:",self.viewModel.toUser.username]:@"评论";
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化
        [self _setup];
        // 创建子控件
        [self _setupSubViews];
        [self _makeSubViewsConstraints];
    }
    return self;
}

#pragma mark - 初始化
- (void)_setup{
    self.backgroundColor = MyColorFromHexString(@"#FAFAFA");
    self.previousTextViewContentHeight = MHMomentCommentToolViewMinHeight;
}

#pragma mark - 初始化子空间
- (void)_setupSubViews{
    // textView 以及 表情按钮 和 分割线
    YYTextView *textView = [[YYTextView alloc] init];
    textView.backgroundColor = MyColorFromHexString(@"#FCFCFC");
    textView.font = MyFontRegular(16);
    textView.textAlignment = NSTextAlignmentLeft;
    UIEdgeInsets insets = UIEdgeInsetsMake(9, 9, 6, 9);
    textView.textContainerInset = insets;
    textView.returnKeyType = UIReturnKeySend;
    textView.enablesReturnKeyAutomatically = YES;
    textView.showsVerticalScrollIndicator = NO;
    textView.showsHorizontalScrollIndicator = NO;
    textView.layer.cornerRadius = 6;
    textView.layer.masksToBounds = YES;
    textView.layer.borderColor = MyColorFromHexString(@"#D9D9D9").CGColor;
    textView.layer.borderWidth = .5;
    textView.placeholderText = @"评论";
    textView.placeholderTextColor = MyColorFromHexString(@"#AAAAAA");
    textView.delegate = self;
    self.textView = textView;
    [self addSubview:textView];
    
    // 表情按钮
    UIButton *emoticonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [emoticonBtn setBackgroundImage:[UIImage imageNamed:(@"emotion_icon")] forState:UIControlStateNormal];
    [emoticonBtn setBackgroundImage:[UIImage imageNamed:(@"emotion_icon_hl")] forState:UIControlStateHighlighted];
    self.emoticonBtn = emoticonBtn;
    [self addSubview:emoticonBtn];
    
    // 分割线
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = MyColorFromHexString(@"#D9D9D9");
    [self addSubview:topLine];
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = MyColorFromHexString(@"#D9D9D9");
    [self addSubview:bottomLine];
    self.topLine = topLine;
    self.bottomLine = bottomLine;
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    [self.emoticonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.right.equalTo(self).with.offset(-13);
        make.width.and.height.mas_equalTo(30);
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.and.right.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(16);
        make.top.equalTo(self).with.offset(10);
        make.bottom.equalTo(self).with.offset(-10);
        make.right.equalTo(self.emoticonBtn.mas_left).with.offset(-13);
    }];
}


#pragma mark - YYTextViewDelegate
- (void)textViewDidChange:(YYTextView *)textView{
    // 改变高度
    [self _commentViewWillChangeHeight:[self _getTextViewHeight:textView]];
}

- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        //在这里做你响应return键的代码 （发送）
        // 传递文本内容
        self.viewModel.text = textView.text;
        // 传递数据
        [self.viewModel.commentCommand execute:self.viewModel];
        // 轻空TextView
        textView.text = nil;
        // 键盘掉下
        [textView resignFirstResponder];
        
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        
    }
    return YES;
}

#pragma mark - 辅助方法
- (void)_commentViewWillChangeHeight:(CGFloat)toHeight{
    
    // 需要加上 MHMomentCommentToolViewWithNoTextViewHeight才是commentViewHeight
    toHeight = toHeight + MHMomentCommentToolViewWithNoTextViewHeight;
    // 是否小于最小高度
    if (toHeight < MHMomentCommentToolViewMinHeight || self.textView.attributedText.length == 0){
        toHeight = MHMomentCommentToolViewMinHeight;
    }
    // 是否大于最大高度
    if (toHeight > MHMomentCommentToolViewMaxHeight) { toHeight = MHMomentCommentToolViewMaxHeight ;}
    // 高度是之前的高度  跳过
    if (toHeight == self.previousTextViewContentHeight) return;
    // 记录上一次的高度
    self.previousTextViewContentHeight = toHeight;
    // 记录toheight
    self.toHeight = toHeight;
}

/** 获取编辑框的高度 */
- (CGFloat)_getTextViewHeight:(YYTextView *)textView{
    return textView.textLayout.textBoundingSize.height;
}
@end

