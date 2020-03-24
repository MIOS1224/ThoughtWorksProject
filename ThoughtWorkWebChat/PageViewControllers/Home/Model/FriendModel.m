//
//  FriendModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel

- (NSMutableArray<CommentModel *> *)comments
{
    if (_comments == nil) {
        _comments = [[NSMutableArray alloc] init];
    }
    return _comments;
}

- (NSMutableArray<UserModel *> *)attitudesList
{
    if (_attitudesList == nil) {
        _attitudesList = [NSMutableArray array];
    }
    return _attitudesList;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"images"          : [ImagesModel class],
             @"comments"        : [CommentModel class],
             @"attitudesList"   : [UserModel class]
             };
}

@end
