//
//  FriendModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  朋友圈 cell model


#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "CommentModel.h"
#import "ImagesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendModel : NSObject

@property (nonatomic,copy)  NSString *content; // 正文
@property (nonatomic,strong) UserModel *sender;  // 用户模型
@property (nonatomic,assign) int32_t commentsCount;    // 评论数
@property (nonatomic,assign) int32_t attitudesStatus;  // 是否已点赞
@property (nonatomic,assign) int32_t attitudesCount; // 点赞数
@property (nonatomic,strong) NSArray <ImagesModel *> *images; // 图片数组
@property (nonatomic,strong) NSMutableArray <CommentModel *> *comments; // 评论列表
@property (nonatomic,strong) NSMutableArray <UserModel *> * attitudesList;  // 点赞列表

@end


NS_ASSUME_NONNULL_END
