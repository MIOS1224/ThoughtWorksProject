//
//  NSString+Extension.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/20.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

//字符串为空判断
+ (BOOL)stringIsEmpty:(NSString*)str;
+ (BOOL)stringIsNotEmpty:(NSString*)str;

@end

NS_ASSUME_NONNULL_END
