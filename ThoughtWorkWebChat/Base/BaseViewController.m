//
//  BaseViewController.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
//#import "IQKeyboardManager.h"

@interface BaseViewController ()

@property (nonatomic,strong) BaseViewModel *viewModel;

@end

@implementation BaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindViewModel];
     }];
    return viewController;
}

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.extendedLayoutIncludesOpaqueBars = YES;
    // pop手势
    self.fd_interactivePopDisabled = self.viewModel.interactivePopDisabled;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.viewModel.willDisappearSignal sendNext:nil];
}

- (void)bindViewModel{
    @weakify(self);
    RAC(self.navigationItem , title) = RACObserve(self, viewModel.title);
    // 绑定错误信息
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        NSLog(@"...错误...");
    }];
    
    // 检测左返状态
    [[[RACObserve(self.viewModel, interactivePopDisabled) distinctUntilChanged] deliverOnMainThread] subscribeNext:^(NSNumber * x) {
        @strongify(self);
        self.fd_interactivePopDisabled = x.boolValue;
    }];
}

@end
