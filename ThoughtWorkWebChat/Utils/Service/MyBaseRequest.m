//
//  MyBaseRequest.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "MyBaseRequest.h"
#import "MyRequestAgent.h"

@implementation MyBaseRequest
- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeoutInterval = 10;
    }
    return self;
}

- (void)startRequestWithSuccess:(void (^)(id _Nonnull))successHandler
                        failure:(void (^)(NSError * _Nonnull))failureHandler {
    self.successBlock = successHandler;
    self.failureBlock = failureHandler;
    [[MyRequestAgent sharedAgent] addRequest:self];
}

- (NSURLRequest *)currentRequest {
    return self.sessionTask.currentRequest;
}

- (BOOL)isRequesting {
    return self.sessionTask.state == NSURLSessionTaskStateRunning;
}

- (void)cancelCurrentRequest {
    [self.sessionTask cancel];
}

- (void)clearBlock {
    
    self.successBlock = nil;
    self.failureBlock = nil;
}

- (void)dealloc {
    
}

@end

