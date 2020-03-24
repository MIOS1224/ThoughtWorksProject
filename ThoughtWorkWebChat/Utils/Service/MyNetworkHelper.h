//
//  MyNetworkHelper.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^MySuccessBlock) (MyBaseRequest *request, id response);
typedef void(^MyFailureBlock) (MyBaseRequest *request, NSError *error);
typedef void(^MyProgressBlock) (NSProgress *progress);

typedef void(^NetworkCallBack)(BOOL isSuccess, NSString *alertString);

@interface MyNetworkHelper : NSObject

+ (MyBaseRequest *)GET:(NSString *)url
            parameters:(nullable id)parameters
               success:(nullable MySuccessBlock)successHandler
               failure:(nullable MyFailureBlock)failureHandler;

+ (MyBaseRequest *)POST:(NSString *)url
             parameters:(nullable id)parameters
                success:(nullable MySuccessBlock)successHandler
                failure:(nullable MyFailureBlock)failureHandler;

/* POST请求URL里面需要拼接Token
 * 拼接后格式为 https://xxxx?access_token=xxxx
 */
+ (MyBaseRequest *)POSTWithToken:(NSString *)url
                      parameters:(nullable id)parameters
                         success:(nullable MySuccessBlock)successHandler
                         failure:(nullable MyFailureBlock)failureHandler;


/**
 @param method 请求方式
 @param withToken 在地址后面是否拼接token
 @param parameters 参数
 @param whiteList 参数签名白名单，在数组中添加参数的key即可不参与sign签名
 */
+ (MyBaseRequest *)requestWithMethod:(MyRequestMethod)method
                                 URL:(NSString *)url
                           withToken:(BOOL)withToken
                          parameters:(nullable id)parameters
                       signWhiteList:(nullable NSArray<NSString *> *)whiteList
                             success:(nullable MySuccessBlock)successHandler
                             failure:(nullable MyFailureBlock)failureHandler;

/*!
 @abstract 基于请求url和参数, 生成一个NSMutableURLRequest对象,用于极验验证第一步和第二步修改request
 @Note 极验第一步和第二步校验,要求回调一个NSMutableURLRequest对象, 该对象需要包含优课已有的公共参数,以及sign、白名单等逻辑
 */
+ (NSMutableURLRequest *)requestWithMethod:(MyRequestMethod)method
                                       url:(NSString *)url
                                parameters:(nullable id)parameters;

@end
NS_ASSUME_NONNULL_END
