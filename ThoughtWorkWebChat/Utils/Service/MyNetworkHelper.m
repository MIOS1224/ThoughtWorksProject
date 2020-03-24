
//
//  MyNetworkHelper.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "MyNetworkHelper.h"
#import "AFNetworkReachabilityManager.h"
#import "NSString+Extension.h"
#import "MyRequestAgent.h"

@implementation MyNetworkHelper

+ (MyBaseRequest *)GET:(NSString *)url parameters:(nullable id)parameters success:(nullable MySuccessBlock)successHandler failure:(nullable MyFailureBlock)failureHandler {
    return [self requestWithMethod:MyRequestMethodGET URL:url withToken:NO parameters:parameters signWhiteList:nil success:successHandler failure:failureHandler];
}

+ (MyBaseRequest *)POST:(NSString *)url parameters:(nullable id)parameters success:(nullable MySuccessBlock)successHandler failure:(nullable MyFailureBlock)failureHandler {
    return [self requestWithMethod:MyRequestMethodPOST URL:url withToken:NO parameters:parameters signWhiteList:nil success:successHandler failure:failureHandler];
}

+ (MyBaseRequest *)POSTWithToken:(NSString *)url
                      parameters:(nullable id)parameters
                         success:(nullable MySuccessBlock)successHandler
                         failure:(nullable MyFailureBlock)failureHandler {
    return [self requestWithMethod:MyRequestMethodPOST URL:url withToken:YES parameters:parameters signWhiteList:nil success:successHandler failure:failureHandler];
}

+ (MyBaseRequest *)requestWithMethod:(MyRequestMethod)method
                                 URL:(NSString *)url
                           withToken:(BOOL)withToken
                          parameters:(nullable id)parameters
                       signWhiteList:(nullable NSArray<NSString *> *)whiteList
                             success:(MySuccessBlock)successHandler
                             failure:(MyFailureBlock)failureHandler {
    if ([url isPracticalString] == NO) {
        return nil;
    }
    
    NSString *URL = url;
    if ([URL hasPrefix:@"/"]) {
        URL = [URL substringFromIndex:1];
    }
    
    MyBaseRequest *request = [[MyBaseRequest alloc] init];
    request.requestMethod = method;
    request.requestURL = URL;
    request.parameters = parameters;
    [self _startRequestWith:request success:successHandler failure:failureHandler];
    return request;
}

#pragma mark - Private.
+ (void)_startRequestWith:(MyBaseRequest *)request
                  success:(MySuccessBlock)successHandler
                  failure:(MyFailureBlock)failureHandler {
    @weakify(request);
    [request startRequestWithSuccess:^(id  _Nonnull response) {
        @strongify(request);
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSDictionary *validResponse = response;
//            if ([validResponse isValidDict] == NO) {
//                validResponse = [NSDictionary dictionary];
//            }
            if (successHandler) {
                successHandler(request, response);
            }
        });
    } failure:^(NSError * _Nonnull error) {
        @strongify(request);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *errorString = [self _parseRequestError:error];
            if (errorString) {
                NSMutableDictionary *userInfo = error.userInfo.mutableCopy;
                userInfo[NSLocalizedDescriptionKey] = errorString;
                NSError *newError = [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo.copy];
                if (failureHandler) {
                    failureHandler(request, newError);
                }
            }else {
                if (failureHandler) {
                    failureHandler(request, error);
                }
            }
        });
    }];
}

+ (nullable NSString *)_parseRequestError:(NSError *)error {
    NSString *errorString = nil;
    if ([error.domain isEqualToString:NSURLErrorDomain]){
        switch (error.code) {
            case NSURLErrorNotConnectedToInternet:
                errorString = @"(/ω＼)网络好像有问题";
                break;
                
            case NSURLErrorTimedOut:
                errorString = @"请求超时";
                break;
                
            case NSURLErrorCannotConnectToHost:
                errorString = @"无法连接到服务器";
                break;
                
            case NSURLErrorCancelled:
                errorString = @"";
                break;
                
            default:
                break;
        }
    }
    
    return errorString;
}



/*!
 @abstract 基于请求url和参数, 生成一个NSMutableURLRequest对象,用于极验验证第一步和第二步修改request
 @Note 极验第一步和第二步校验,要求回调一个NSMutableURLRequest对象, 该对象需要包含优课已有的公共参数,以及sign、白名单等逻辑
 */
+ (NSMutableURLRequest *)requestWithMethod:(MyRequestMethod)method
                                       url:(NSString *)url
                                parameters:(nullable id)parameters{
    
    NSString *URL = url;
    
    MyBaseRequest *request = [[MyBaseRequest alloc] init];
    request.requestURL = URL;
    request.parameters = parameters;
    
    AFHTTPRequestSerializer *requestSerializer;
    
    NSString *methodStr = @"";
    
    if (method == MyRequestMethodGET) {
        
        requestSerializer = [AFHTTPRequestSerializer serializer];
        methodStr = @"GET";
    }else if (method == MyRequestMethodPOST){
        
        requestSerializer = [AFJSONRequestSerializer serializer];
        methodStr = @"POST";
    }
    
    requestSerializer.timeoutInterval = request.timeoutInterval;
    
    NSURL *baseURL = [NSURL URLWithString:APP_BASIC_URL];
    if ([[baseURL path] length] > 0 && ![[baseURL absoluteString] hasSuffix:@"/"]) {
        baseURL = [baseURL URLByAppendingPathComponent:@""];
    }
    
    NSMutableURLRequest *mutableRequest = [requestSerializer requestWithMethod:methodStr URLString:[[NSURL URLWithString:url relativeToURL:baseURL] absoluteString] parameters:parameters error:nil];
    return mutableRequest;
    
}

@end

