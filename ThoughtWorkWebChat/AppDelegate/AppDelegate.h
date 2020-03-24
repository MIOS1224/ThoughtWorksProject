//
//  AppDelegate.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (nonatomic, strong) UIWindow * window;
/// 是否已经弹出键盘 
@property (nonatomic, readwrite, assign , getter = isShowKeyboard) BOOL showKeyboard;

/// 获取AppDelegate
+ (AppDelegate *)sharedDelegate;

@end

