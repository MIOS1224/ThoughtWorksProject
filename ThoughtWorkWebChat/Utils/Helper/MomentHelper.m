//
//  MomentHelper.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/23.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "MomentHelper.h"
#import "AppDelegate.h"

@implementation MomentHelper

+ (void)hideAllPopViewWithAnimated:(BOOL)animated{
    /// 关掉更多View
    [MomentOperationMoreView hideAllOperationMoreViewWithAnimated:NO];
    /// 关闭键盘
    if(MySharedAppDelegate.isShowKeyboard){
        [[UIWindow getKeyWindow] endEditing:YES];
    }
}

@end
