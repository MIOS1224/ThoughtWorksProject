//
//  BaseViewController.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic, strong, readonly) BaseViewModel *viewModel;
@property (nonatomic, strong, readonly) RACSubject *willDisappearSignal;

//绑定数据模型
- (void)bindViewModel;
//统一初始化方法
- (instancetype)initWithViewModel:(BaseViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
