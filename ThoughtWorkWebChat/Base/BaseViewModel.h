//
//  BaseViewModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModel : NSObject

@property (nonatomic,copy)  NSString *title;    // 导航头
@property (nonatomic,copy)  CallBlock callback; // 反向传值
@property (nonatomic,readonly,strong) RACSubject *errors; //统一错误处理
@property (nonatomic,readonly,strong) RACSubject *willDisappearSignal;

#pragma mark  - 辅助设置
@property (nonatomic,assign) BOOL interactivePopDisabled; //左滑返回功能
@property (nonatomic,assign) CGFloat keyboardDistanceFromTextField;  // keyboardDistanceFromTextField

//加载数据
- (void)initialize;

@end

NS_ASSUME_NONNULL_END
