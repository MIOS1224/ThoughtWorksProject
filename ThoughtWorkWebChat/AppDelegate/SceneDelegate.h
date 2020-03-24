//
//  SceneDelegate.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#if defined(DEBUG)||defined(_DEBUG)
#import <JPFPSStatus/JPFPSStatus.h>
#import <MLeaksFinder.h>
#endif

#import <UIKit/UIKit.h>

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (strong, nonatomic) UIWindow * window;

@end

