//
//  UserModelManager.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  暂时存放用户信息，模仿登录

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModelManager : NSObject

@property (nonatomic,strong)UserModel * currentUser;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
