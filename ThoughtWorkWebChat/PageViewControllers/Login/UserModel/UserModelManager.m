//
//  UserModelManager.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "UserModelManager.h"

@implementation UserModelManager

+ (instancetype)sharedInstance {
    
    static UserModelManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UserModelManager alloc] init];
    });
    return sharedInstance;
}
@end
