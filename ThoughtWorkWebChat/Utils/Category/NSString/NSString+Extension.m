//
//  NSString+Extension.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/20.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)



+(BOOL)stringIsNotEmpty:(NSString *)str{
    BOOL res = [self stringIsEmpty:str];
    return !res;
}

+ (BOOL)stringIsEmpty:(NSString*)str{
    if (str == nil) {
        return TRUE;
    }
    
    if ([str isEqual:[NSNull null]]) {
        return TRUE;
    }
    
    if ([str isKindOfClass:[NSString class]]) {
        
        if (str.length == 0) {
            return TRUE;
        }
        
        NSString *str1 = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([str1 isEqual:@""]) {
            return TRUE;
        }
        if ([str1 containsString:@"null"]) {
            return YES;
        }
        if ([str1 containsString:@"nil"]) {
            return YES;
        }
    }
    return FALSE;
}

+ (void)setUserDefaults:(id)value forKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

+ (id)userDefaultsForKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

@end
