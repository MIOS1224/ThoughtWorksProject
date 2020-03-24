//
//  MyRequestAgent.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "MyRequestAgent.h"
#import "MyBaseRequest.h"

@interface MyRequestAgent ()
@property (nonatomic, readwrite, strong) AFHTTPSessionManager *manager;
@end

@implementation MyRequestAgent

- (void)addRequest:(MyBaseRequest *)request {
    
    self.manager.requestSerializer.timeoutInterval = request.timeoutInterval;
    
    switch (request.requestMethod) {
        case MyRequestMethodGET: {

            NSURLSessionDataTask *dataTask;
            dataTask = [self.manager GET:request.requestURL parameters:request.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                request.sessionTask = task;
                request.successBlock(responseObject);
                
                [request clearBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                request.sessionTask = task;
                request.failureBlock(error);
                
                [request clearBlock];
            }];
            request.sessionTask = dataTask;
        }break;
            
        case MyRequestMethodPOST: {

            NSURLSessionDataTask *dataTask;
            dataTask = [self.manager POST:request.requestURL parameters:request.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                request.sessionTask = task;
                request.successBlock(responseObject);
                
                [request clearBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                request.sessionTask = task;
                request.failureBlock(error);
                
                [request clearBlock];
            }];
            request.sessionTask = dataTask;
        }break;
            
        default: {
        }break;

            
    }
}

+ (MyRequestAgent *)sharedAgent {
    static MyRequestAgent *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MyRequestAgent alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:APP_BASIC_URL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
        
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.requestSerializer = requestSerializer;
        
    }
    return self;
}

@end

