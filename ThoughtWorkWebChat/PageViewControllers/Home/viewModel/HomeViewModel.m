//
//  HomeViewModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/20.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  首页viewmodel

#import "HomeViewModel.h"
#import "BaseSectionGroupViewModel.h"
#import "BaseItemViewModel.h"

@implementation HomeViewModel

- (void)initialize {
    
    self.title = @"首页";
    //加载数据
    BaseSectionGroupViewModel *group = [BaseSectionGroupViewModel groupViewModel];
    BaseItemViewModel *wallet = [BaseItemViewModel itemViewModelWithTitle:@"发现" icon:@"dis_item_icon"];
    group.itemViewModels = @[wallet];
    self.dataSource = @[group];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return nil;
    }];
}

@end
