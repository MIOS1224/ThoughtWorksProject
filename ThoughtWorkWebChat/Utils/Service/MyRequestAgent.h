//
//  MyRequestAgent.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@class MyBaseRequest;
@interface MyRequestAgent : NSObject

@property (nonatomic, readonly, strong) AFHTTPSessionManager *manager;

+ (MyRequestAgent *)sharedAgent;

- (void)addRequest:(MyBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
