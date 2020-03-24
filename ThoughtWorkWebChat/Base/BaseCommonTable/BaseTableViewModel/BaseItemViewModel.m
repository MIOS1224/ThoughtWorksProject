//
//  BaseItemViewModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "BaseItemViewModel.h"

@implementation BaseItemViewModel

+ (instancetype)itemViewModelWithTitle:(NSString *)title icon:(nullable NSString *)icon{
    BaseItemViewModel *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemViewModelWithTitle:(NSString *)title{
    return [self itemViewModelWithTitle:title icon:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _selectionStyle = UITableViewCellSelectionStyleGray;
        _rowHeight = 44.0f;
    }
    return self;
}

@end
