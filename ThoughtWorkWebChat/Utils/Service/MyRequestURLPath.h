//
//  MyRequestURLPath.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyRequestURLPath : NSObject
// https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith/tweets
//BASIC URL https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith

FOUNDATION_EXPORT NSString * const APP_BASIC_URL;
// 获取用户信息
FOUNDATION_EXPORT NSString * const GET_USER_INFO;
// 获取tweets资源
FOUNDATION_EXPORT NSString * const GET_TWEETS_INFO;

@end

NS_ASSUME_NONNULL_END
