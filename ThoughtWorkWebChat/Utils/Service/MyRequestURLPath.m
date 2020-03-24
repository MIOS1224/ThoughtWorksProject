//
//  MyRequestURLPath.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "MyRequestURLPath.h"
//https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith/tweets
//BASIC URL
@implementation MyRequestURLPath
// BASIC URL
NSString * const APP_BASIC_URL   = @"https://thoughtworks-mobile-2018.herokuapp.com";
// 获取用户信息
NSString * const GET_USER_INFO   = @"/user/jsmith";
// 获取tweets资源
NSString * const GET_TWEETS_INFO = @"/user/jsmith/tweets";

@end
