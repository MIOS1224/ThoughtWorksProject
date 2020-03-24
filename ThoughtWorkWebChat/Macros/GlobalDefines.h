//
//  GlobalDefines.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#ifndef GlobalDefines_h
#define GlobalDefines_h
// IOS版本
#define MyIOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
//获取当前keywindow
#define MySharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

// MARK: - 打印定义 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容])
#ifdef DEBUG
#define NSLog(format, ...)  printf("\n[%s] %s [第%d行] 💕 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else

#define NSLog(format, ...)

#endif
// 打印方法
#define MyLogFunc NSLog(@"%s", __func__)
// 打印请求错误信息
#define MyLogError(error) NSLog(@"Error: %@", error)
// 销毁打印
//#define MyDealloc NSLog(@"\n =========+++ %@  销毁了 +++======== \n",[self class])

#define MyLogLastError(db) NSLog(@"lastError: %@, lastErrorCode: %d, lastErrorMessage: %@", [db lastError], [db lastErrorCode], [db lastErrorMessage]);

//MARK: - UIColor 扩展定义
#ifndef MyColorRGBA
    #define MyColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
    #define MyColorRGB(r, g, b)     MyColorRGBA(r, g, b, 1.f)
    #define TWRandomColor           MyColorRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#endif

#ifndef MyColorHexA
    #define MyColorHexA(_hex_, a) MyColorRGBA((((_hex_) & 0xFF0000) >> 16), (((_hex_) & 0xFF00) >> 8), ((_hex_) & 0xFF), a)
    #define MyColorHex(_hex_)     MyColorHexA(_hex_, 1.0)
#endif

//根据hex 获取颜色
#define MyColorFromHexString(__hexString__) ([UIColor colorFromHexString:__hexString__])


// MARK: UIFont 扩展定义
#define MyFontLight(font)     [UIFont fontWithName:@"PingFangSC-Light" size:font]
#define MyFontRegular(font)   [UIFont fontWithName:@"PingFangSC-Regular" size:font]
#define MyFontSemibold(font)  [UIFont fontWithName:@"PingFangSC-Semibold" size:font]
#define MyFontMedium(font)    [UIFont fontWithName:@"PingFangSC-Medium" size:font]
#define MyFontDINAlternateBold(n) ([UIFont fontWithName:@"DIN Alternate" size:(n)])


//苹方常规字体 12
#define MyFontRegular_12 MyFontRegular(12.0f)
#define MyFontRegular_13 MyFontRegular(13.0f)
#define MyFontRegular_14 MyFontRegular(14.0f)
#define MyFontRegular_15 MyFontRegular(15.0f)
#define MyFontRegular_16 MyFontRegular(16.0f)
#define MyFontRegular_17 MyFontRegular(17.0f)
#define MyFontRegular_18 MyFontRegular(18.0f)


// 类型相关
#define MY_IS_IPAD ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define MY_IS_IPHONE ([UIDevice currentDevice].userInterfaceIdiom  == UIUserInterfaceIdiomPhone)
#define MY_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

// 屏幕尺寸相关
#define MY_SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define MY_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define MY_SCREEN_BOUNDS ([[UIScreen mainScreen] bounds])
#define MY_SCREEN_MAX_LENGTH (MAX(MY_SCREEN_WIDTH, MY_SCREEN_HEIGHT))
#define MY_SCREEN_MIN_LENGTH (MIN(MY_SCREEN_WIDTH, MY_SCREEN_HEIGHT))

// 手机类型相关
#define MY_IS_IPHONE_4_OR_LESS  (MY_IS_IPHONE && MY_SCREEN_MAX_LENGTH  < 568.0)
#define MY_IS_IPHONE_5          (MY_IS_IPHONE && MY_SCREEN_MAX_LENGTH == 568.0)
#define MY_IS_IPHONE_6          (MY_IS_IPHONE && MY_SCREEN_MAX_LENGTH == 667.0)
#define MY_IS_IPHONE_6P         (MY_IS_IPHONE && MY_SCREEN_MAX_LENGTH == 736.0)
#define MY_IS_IPHONE_X          (MY_IS_IPHONE && MY_SCREEN_MAX_LENGTH >= 812.0)
#define MY_IS_IPHONE_XPro       (MY_IS_IPHONE && MY_SCREEN_MAX_LENGTH == 896.0)

//MARK: - 屏幕大小
/// 导航条高度
#define MY_APPLICATION_TOP_BAR_HEIGHT ((MY_IS_IPHONE_X || MY_IS_IPHONE_XPro)?88.0f:64.0f)

//  状态栏
#define kStatusBarHeight      ([[UIApplication sharedApplication] statusBarFrame].size.height)
//  导航栏+状态栏     (不能再UINavigationController中调用)
#define kNavigationHeight     (kStatusBarHeight + self.navigationController.navigationBar.frame.size.height)

#ifndef kScreenSize
    #define kScreenSize [UIScreen mainScreen].bounds.size
#endif
#ifndef kScreenWidth
    #define kScreenWidth kScreenSize.width
#endif
#ifndef kScreenHeight
    #define kScreenHeight kScreenSize.height
#endif

// 适配iPhone X + iOS 11
#define  MYAdjustsScrollViewInsets_Never(__scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([__scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = __scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)



//MARK: - 主线程上安全运行定义
#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

#endif /* GlobalDefines_h */
