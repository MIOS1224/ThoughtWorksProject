//
//  UkeKeychainConfiguration.m
//  TreasProject
//
//  Created by YT on 2018/5/14.
//  Copyright © 2018年 YT. All rights reserved.
//

#import "UkeKeychainConfiguration.h"

@implementation UkeKeychainConfiguration

+ (instancetype)defaultConfiguration {
    UkeKeychainConfiguration *result = [[UkeKeychainConfiguration alloc] init];
    
    result.service = @"com.zmkeychain.zhangmen";
    result.secClass = kKeychainSecClassGenericPassword;
    
    return result;
}

- (NSDictionary *)keychainQuery {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:2];
    //要保存的password类型
    [result setObject:(__bridge id)[self valueOfKeychainSecClass] forKey:(__bridge id)kSecClass];
    if (self.service) {//AttrService 和AttrAccount是两个主要的属性
        [result setObject:self.service forKey:(__bridge id)kSecAttrService];
    }
    
    return result.copy;
}

- (CFStringRef)valueOfKeychainSecClass {
    
    switch (self.secClass) {
        case kKeychainSecClassInternetPassword: {
            return kSecClassInternetPassword;
        }  break;
        case kKeychainSecClassGenericPassword: {
            return kSecClassGenericPassword;
        }  break;
        case kKeychainSecClassCertificate: {
            return kSecClassCertificate;
        }  break;
        case kKeychainSecClassKey: {
            return kSecClassKey;
        }  break;
        case kKeychainSecClassIdentity: {
            return kSecClassIdentity;
        }  break;
    }
}

@end
