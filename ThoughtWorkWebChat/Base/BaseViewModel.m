//
//  BaseViewModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "BaseViewModel.h"
#import "MyNetworkHelper.h"
#import "UserModelManager.h"
#import "UkeKeychain.h"
@interface BaseViewModel ()

@property (nonatomic,copy)   NSDictionary *params;
@property (nonatomic,strong) RACSubject *errors;
@property (nonatomic,strong) RACSubject *willDisappearSignal;

@end

@implementation BaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewModel *viewModel = [super allocWithZone:zone];
    [viewModel initialize];
    [viewModel getUserInfo];
    return viewModel;
}

- (RACSubject *)errors {
    if (!_errors) _errors = [RACSubject subject];
    return _errors;
}

- (RACSubject *)willDisappearSignal {
    if (!_willDisappearSignal) _willDisappearSignal = [RACSubject subject];
    return _willDisappearSignal;
}

//暂时存放  //获取用户信息
- (void)getUserInfo{
    NSDictionary * dict = [UkeKeychain.shareKeychain uke_dictForAccount:@"THOUGHTUSERINFO"];
    if (dict) {
        [UserModelManager sharedInstance].currentUser = [UserModel yy_modelWithJSON:dict];
    }else
    {
        [MyNetworkHelper GET:GET_USER_INFO parameters:nil success:^(MyBaseRequest * _Nonnull request, id  _Nonnull response) {
            if ([NSObject objIsNotNull:response]) {
                NSDictionary * dict = (NSDictionary *)response;
                [UkeKeychain.shareKeychain uke_saveDict:dict forAccount:@"THOUGHTUSERINFO"];
                [UserModelManager sharedInstance].currentUser = [UserModel yy_modelWithJSON:response];
            }
        } failure:^(MyBaseRequest * _Nonnull request, NSError * _Nonnull error) {}];
    }
    
}

//子类重写
- (void)initialize {}

@end

