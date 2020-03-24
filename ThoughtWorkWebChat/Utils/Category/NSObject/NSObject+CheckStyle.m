//
//  NSObject+CheckStyle.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/20.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "NSObject+CheckStyle.h"

@implementation NSObject (CheckStyle)

+ (BOOL)objIsNull:(id)obj{
    if (obj == nil || [obj isKindOfClass:[NSNull class]] || obj == NULL ) {
        return YES;
    }
    //避免model转化为空字符串情况
    NSString * str = [NSString stringWithFormat:@"%@",obj];
    if ([str isEqual:@""]) {
        return TRUE;
    }
    return NO;
}

+(BOOL)objIsNotNull:(id)obj{
    BOOL res = [self objIsNull:obj];
    return !res;
    
}

- (BOOL)isValidString {
    return [self isKindOfClass:[NSString class]];
}

- (BOOL)isPracticalString {
    if ([self isValidString] == NO) {
        return NO;
    }
    
    NSString *str = (NSString *)self;
    if (str.length == 0) {
        return NO;
    }
    
    if ([str rangeOfString:@"null"].location != NSNotFound) {
        return NO;
    }
    
    return YES;
}

- (BOOL)isValidArray {
    return [self isKindOfClass:[NSArray class]];
}

- (BOOL)isPracticalArray {
    if (![self isValidArray]) {
        return NO;
    }
    NSArray *array = (NSArray *)self;
    return array.count > 0;
}

- (BOOL)isValidDict {
    return [self isKindOfClass:[NSDictionary class]];
}

- (BOOL)isPracticalDict {
    if (![self isValidDict]) {
        return NO;
    }
    NSDictionary *dict = (NSDictionary *)self;
    return dict.allKeys.count > 0;
}

- (BOOL)isValidNumber {
    return [self isKindOfClass:[NSNumber class]];
}

- (BOOL)isValidStringOrNumber {
    return [self isValidString] || [self isValidNumber];
}

- (nullable NSString *)getStringValue {
    if ([self isValidString]) {
        return (NSString *)self;
    }
    if ([self isValidNumber]) {
        return [NSString stringWithFormat:@"%@", self];
    }
    return nil;
}

- (void)convertNotification:(NSNotification *)notification completion:(void (^ _Nullable)(CGFloat, UIViewAnimationOptions, CGFloat))completion
{
    // 按钮
    NSDictionary *userInfo = notification.userInfo;
    // 最终尺寸
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 开始尺寸
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    // 动画时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    /// options
    UIViewAnimationOptions options = ([userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16 ) | UIViewAnimationOptionBeginFromCurrentState;
   
    /// keyboard height
    CGFloat keyboardH = 0;
    if (beginFrame.origin.y == [[UIScreen mainScreen] bounds].size.height){
        // up
        keyboardH = endFrame.size.height;
    }else if (endFrame.origin.y == [[UIScreen mainScreen] bounds].size.height) {
        // down
        keyboardH = 0;
    }else{
        // up
        keyboardH = endFrame.size.height;
    }
    /// 回调
    !completion?:completion(duration,options,keyboardH);
}

/// 链接正则
+ (NSRegularExpression *)regexLinkUrl{
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:kNilOptions error:NULL];
    });
    return regex;
}

@end

