//
//  CommentModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  评论model

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : NSObject

@property (nonatomic,copy) NSString *content;     // 正文
@property (nonatomic,copy) NSString *momentIdstr; //回复内容
@property (nonatomic,strong) UserModel *sender;   //评论者
@property (nonatomic,strong) UserModel *toUser;   // 回复:xxx

@end

NS_ASSUME_NONNULL_END
