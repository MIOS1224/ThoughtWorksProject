//
//  BaseSectionGroupViewModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseSectionGroupViewModel : NSObject

@property (nonatomic,copy) NSString *header; // 组头
@property (nonatomic,copy) NSString *footer; // 组尾

@property (nonatomic,assign) CGFloat headerHeight; // defalult :.001
@property (nonatomic,assign) CGFloat footerHeight; // defalult : 21

@property (nonatomic,strong) NSArray *itemViewModels;

+ (instancetype)groupViewModel;

@end

NS_ASSUME_NONNULL_END
