//
//  FriendDataModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  朋友圈的全部数据  FriendModel 为单条数据模型

#import <Foundation/Foundation.h>
#import "FriendModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FriendDataModel : NSObject
// 数据源
@property (nonatomic,copy) NSArray <FriendModel *> *moments;

@end

NS_ASSUME_NONNULL_END
