//
//  UIWindow+Extension.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/23.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "UIWindow+Extension.h"
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation UIWindow (Extension)

+(UIWindow *)getKeyWindow
{
    UIWindow * keywindow = nil;
    if (@available(iOS 13.0, *)) {
        NSSet * scenes = [UIApplication sharedApplication].connectedScenes;
        for (UIWindowScene * scene in scenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                keywindow = scene.windows.firstObject;
                break;
            }
        }
    } else {
        keywindow = [UIApplication sharedApplication].keyWindow;
    }
    return keywindow;
}
@end
