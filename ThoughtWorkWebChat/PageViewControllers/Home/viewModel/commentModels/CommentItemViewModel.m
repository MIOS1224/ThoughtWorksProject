//
//  CommentItemViewModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "CommentItemViewModel.h"
#import "CommentModel.h"

@implementation CommentItemViewModel

- (instancetype)initWithComment:(CommentModel *)comment
{
    if (self = [super init]) {
        
        self.comment = comment;
        self.type = CommentLikeContentTypeComment;
        
        NSMutableAttributedString *textAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"：%@",comment.content]];
        textAttr.yy_color = [UIColor blackColor];
        textAttr.yy_font = MyFontRegular_14;
        
        // 点击的高亮的
        YYTextBorder *border = [YYTextBorder new];
        border.cornerRadius = 0;
        border.insets = UIEdgeInsetsMake(0, -1, 0, -1);
        border.fillColor = MyColorFromHexString(@"#C7C7C7");
        
        if ([NSObject objIsNull:comment.sender]) return self;
        // 发送者
        NSString * userStr = [NSString stringIsEmpty:comment.sender.username] ? @"":comment.sender.username;
        NSMutableAttributedString *fromAttr = [[NSMutableAttributedString alloc] initWithString:userStr];
        fromAttr.yy_color = MyColorFromHexString(@"#5B6A92");
        fromAttr.yy_font = MyFontMedium(14);
        // 点击高亮
        YYTextHighlight *fromHighlight = [YYTextHighlight new];
        // 将用户数据带出去
        fromHighlight.userInfo = @{MHMomentUserInfoKey:comment.sender};
        [fromHighlight setBackgroundBorder:border];
        [fromAttr yy_setTextHighlight:fromHighlight range:fromAttr.yy_rangeOfAll];
        
        // 是否有回复
        if (comment.toUser) {
            // 回复
            NSMutableAttributedString *replyAttr = [[NSMutableAttributedString alloc] initWithString:@"回复"];
            replyAttr.yy_color = textAttr.yy_color;
            replyAttr.yy_font = textAttr.yy_font;
            
            // 目标
            NSMutableAttributedString *toAttr = [[NSMutableAttributedString alloc] initWithString:comment.toUser.username];
            toAttr.yy_color = fromAttr.yy_color;
            toAttr.yy_font = fromAttr.yy_font;
            // 高亮
            YYTextHighlight *toHighlight = [[YYTextHighlight alloc] init];
            [toHighlight setBackgroundBorder:border];
            // 将用户数据带出去
            toHighlight.userInfo = @{MHMomentUserInfoKey:comment.toUser};
            [toAttr yy_setTextHighlight:toHighlight range:toAttr.yy_rangeOfAll];
            
            // 拼接数据
            [replyAttr appendAttributedString:toAttr];
            [fromAttr appendAttributedString:replyAttr];
        }
        
        NSMutableAttributedString *contentAttr = [[NSMutableAttributedString alloc] init];
        // 整体拼接
        [contentAttr appendAttributedString:fromAttr];
        [contentAttr appendAttributedString:textAttr];
        
        // 统一配置
        contentAttr.yy_lineBreakMode = NSLineBreakByCharWrapping;
        contentAttr.yy_alignment = NSTextAlignmentLeft;
        
        // 文本布局
        CGFloat limitWidth = MHMomentCommentViewWidth()-2*9;
        YYTextContainer *contentLableContainer = [YYTextContainer containerWithSize:CGSizeMake(limitWidth, MAXFLOAT)];
        contentLableContainer.maximumNumberOfRows = 0;
        YYTextLayout *contentLableLayout = [YYTextLayout layoutWithContainer:contentLableContainer text:contentAttr.copy];
        self.contentLableLayout = contentLableLayout;
        
        // 尺寸属性
        CGFloat contentLableW = contentLableLayout.textBoundingSize.width;
        CGFloat contentLableH = contentLableLayout.textBoundingSize.height;
        self.contentLableFrame = CGRectMake(MHMomentCommentViewContentLeftOrRightInset, MHMomentCommentViewContentTopOrBottomInset, contentLableW, contentLableH);
        self.cellHeight = CGRectGetMaxY(self.contentLableFrame)+MHMomentCommentViewContentTopOrBottomInset;
    }
    
    return self;
}
@end



