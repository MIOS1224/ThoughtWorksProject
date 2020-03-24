//
//  MyBaseRequest.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
    MyRequestMethodGET = 0,
    MyRequestMethodPOST = 1
} MyRequestMethod;

@interface MyBaseRequest : NSObject

//! 请求方式
@property (nonatomic, assign) MyRequestMethod requestMethod;

//! 请求地址：可以是一个完整地址，或是一个相对路径地址
@property (nonatomic, copy) NSString *requestURL;

//! 请求参数
@property (nonatomic, strong, nullable) id parameters;

//! 超时时间，默认10s
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

@property (nonatomic, strong) void(^successBlock) (id response);
@property (nonatomic, strong) void(^failureBlock) (NSError *error);

//! 请求完成后可获取的值
@property (nonatomic, strong) NSURLSessionTask *sessionTask;
@property (nonatomic, strong, readonly) NSURLRequest *currentRequest;
//! 是否正在请求
@property (nonatomic, assign) BOOL isRequesting;

//! 开始请求
- (void)startRequestWithSuccess:(void(^)(id response))successHandler failure:(void(^)(NSError *error))failureHandler;

//! 取消当前请求
- (void)cancelCurrentRequest;

//! 清掉block引用
- (void)clearBlock;

@end


NS_ASSUME_NONNULL_END
