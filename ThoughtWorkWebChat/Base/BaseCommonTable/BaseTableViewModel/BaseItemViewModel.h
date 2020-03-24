//
//  BaseItemViewModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  cell model

#import "BaseTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseItemViewModel : NSObject

@property (nonatomic,copy) NSString *icon;  //图标
@property (nonatomic,copy) NSString *title; // 标题

@property (nonatomic,assign) CGFloat rowHeight; //44
@property (nonatomic,assign) UITableViewCellSelectionStyle selectionStyle;

+ (instancetype)itemViewModelWithTitle:(NSString *)title;
+ (instancetype)itemViewModelWithTitle:(NSString *)title icon:(nullable NSString *)icon;

@end

NS_ASSUME_NONNULL_END
