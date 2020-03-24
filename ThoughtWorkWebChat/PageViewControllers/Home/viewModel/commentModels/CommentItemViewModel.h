//
//  CommentItemViewModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  单条评论viewmodel

#import "CommentLikeContentModel.h"
#import "CommentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentItemViewModel : CommentLikeContentModel

@property (nonatomic, strong) CommentModel *comment;

- (instancetype)initWithComment:(CommentModel *)comment;

@end



NS_ASSUME_NONNULL_END
