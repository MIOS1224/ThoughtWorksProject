//
//  CommentLikeContentModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  点赞与评论 基类
// 类型
typedef NS_ENUM(NSUInteger, CommentLikeContentType) {
    CommentLikeContentTypeLike = 0,   // 点赞
    CommentLikeContentTypeComment ,   // 评论
};


#import <Foundation/Foundation.h>
#import "YYTextLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentLikeContentModel : NSObject

@property (nonatomic,assign) CGFloat cellHeight;       // cellHeight
@property (nonatomic,assign) CGRect contentLableFrame; // 正文尺寸
@property (nonatomic,assign) CommentLikeContentType type;
@property (nonatomic,strong) YYTextLayout *contentLableLayout; // 正文布局
// 富文本文字上的事件处理
@property (nonatomic,strong) RACCommand *attributedTapCommand;

@end

NS_ASSUME_NONNULL_END
