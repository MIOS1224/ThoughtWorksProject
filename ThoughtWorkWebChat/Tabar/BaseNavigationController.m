//
//  BaseNavigationController.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "BaseNavigationController.h"

@interface UINavigationController (Uke_Dlegate) <UINavigationBarDelegate>

@end

@interface BaseNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL transitionAnimating;

@end

@implementation BaseNavigationController
+ (void)initialize
{
    [self setupNavigationBarTheme];
    [self setupBarButtonItemTheme];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationAppearance];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (false == CGRectEqualToRect(self.view.frame, self.tabBarController.view.bounds)) {
        for (UIView *view in self.tabBarController.view.subviews) {
            if ( ![view isKindOfClass:UITabBar.class] && !CGRectEqualToRect(view.frame, self.tabBarController.view.bounds)) {
                view.frame = self.tabBarController.view.bounds;
            }
        }
    }
}
/**
 *  设置UINavigationBarTheme的主题
 */
+ (void) setupNavigationBarTheme{
    UINavigationBar *appearance = [UINavigationBar appearance];
//    [appearance setTranslucent:YES];
    [appearance setBarStyle:UIBarStyleDefault];
    [appearance setTintColor:[UIColor blackColor]];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = MyFontRegular(18.0f);
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset =  CGSizeZero;
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs];
    
    //去除下划线
    [appearance setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    // 设置导航栏的背景渲染色
    [appearance setBarTintColor:MY_MAIN_BACKGROUNDCOLOR];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme{
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];

    CGFloat fontSize = 16.0f;
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = MyFontRegular(fontSize);
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset =  CGSizeZero;
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [[UIColor whiteColor] colorWithAlphaComponent:.5f];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];

    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [[UIColor whiteColor] colorWithAlphaComponent:.5f];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}
#pragma mark - Configure
- (void)setNavigationAppearance {
    UIImage *backImage = [UIImage imageNamed:@"ic_navi_back_black"];
    backImage = [backImage imageWithSpacingExtensionInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    self.navigationBar.backIndicatorImage = backImage;
    self.navigationBar.backIndicatorTransitionMaskImage = backImage;
}
// 去掉返回按钮文字
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.transitionAnimating) {
        return;
    }
    if (animated) {
        self.transitionAnimating = true;
        // 兜底方案-预防未知原因未调用 navigationController:didShowViewController:animated 代理
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.transitionAnimating = false;
        });
    }
    
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [super pushViewController:viewController animated:animated];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [self setViewControllers:viewControllers animated:YES];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    if ([viewControllers isPracticalArray]) {
        UIViewController *lastVc = [viewControllers lastObject];
        lastVc.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    [super setViewControllers:viewControllers animated:animated];
}
@end
