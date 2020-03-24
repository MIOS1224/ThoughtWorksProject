//
//  LikeItemViewModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentLikeContentModel.h"
#import "FriendModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LikeItemViewModel : CommentLikeContentModel

@property (nonatomic, readonly, strong) FriendModel *moment;
@property (nonatomic, readonly, strong) RACCommand *operationCmd; // 更新数据

- (instancetype)initWithMoment:(FriendModel *)moment;

@end

NS_ASSUME_NONNULL_END
