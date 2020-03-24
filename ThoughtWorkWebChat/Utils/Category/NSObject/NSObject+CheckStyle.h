//
//  NSObject+CheckStyle.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/20.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CheckStyle)

+ (BOOL)objIsNull:(id)obj;
+ (BOOL)objIsNotNull:(id)obj;

- (BOOL)isValidString;
- (BOOL)isPracticalString;

- (BOOL)isValidArray;
- (BOOL)isPracticalArray;

- (BOOL)isValidDict;
- (BOOL)isPracticalDict;

- (BOOL)isValidNumber;
- (BOOL)isValidStringOrNumber;

- (nullable NSString *)getStringValue;

- (void)convertNotification:(NSNotification *)notification completion:(void (^ _Nullable)(CGFloat, UIViewAnimationOptions, CGFloat))completion;

+ (NSRegularExpression *)regexLinkUrl;

@end

NS_ASSUME_NONNULL_END
