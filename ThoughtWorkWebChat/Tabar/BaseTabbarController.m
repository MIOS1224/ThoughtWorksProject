//
//  BaseTabbarController.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"
#import "HomePageController.h"
#import "TabBarItemModel.h"


@interface BaseTabbarController ()<UITabBarControllerDelegate>
@property (nonatomic,strong)NSMutableArray * tabBarItems;
@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];
}

#pragma mark - 初始化子视图控制器
- (void)setupChildControllers{
    TabBarItemModel * homeItem = [TabBarItemModel getTabarItem:@"首页" withImage:@"tab_source_unselect" andSelectImage:@"tab_source_select"];
    HomePageController *homeCtrl  = [[HomePageController alloc]initWithViewModel:[[HomeViewModel alloc]init]];
    [self configViewController:homeCtrl withTabbarItemModel:homeItem];
}

#pragma mark - 配置ViewController
- (void)configViewController:(UIViewController *)childVC withTabbarItemModel:(TabBarItemModel *) tabModel{
    
    // 去除图片系统自带的蓝色
    UIImage * normalImg   = [[UIImage imageNamed:tabModel.image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectedImg = [[UIImage imageNamed:tabModel.selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.title = tabModel.title;
    childVC.navigationItem.title = tabModel.title;
    childVC.tabBarItem.image = normalImg;
    childVC.tabBarItem.selectedImage = selectedImg;
    
    NSDictionary *normalAttr   = @{NSForegroundColorAttributeName:MyColorFromHexString(@"#929292"), NSFontAttributeName:MyFontRegular_12};
    NSDictionary *selectedAttr = @{NSForegroundColorAttributeName:MyColorFromHexString(@"#09AA07"), NSFontAttributeName:MyFontRegular_12};
    [childVC.tabBarItem setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    
    [childVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];
    [childVC.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    BaseNavigationController * navi = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:navi];
}

@end
