//
//  FriendDataModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  

#import "FriendDataModel.h"

@implementation FriendDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"moments" : [FriendModel class]};
}

@end
