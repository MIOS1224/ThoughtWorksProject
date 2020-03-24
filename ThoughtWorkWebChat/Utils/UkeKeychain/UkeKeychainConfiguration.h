//
//  UkeKeychainConfiguration.h
//  TreasProject
//
//  Created by YT on 2018/5/14.
//  Copyright © 2018年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KeychainSecClass) {
    
    kKeychainSecClassInternetPassword,
    kKeychainSecClassGenericPassword,
    kKeychainSecClassCertificate,
    kKeychainSecClassKey,
    kKeychainSecClassIdentity
};

NS_ASSUME_NONNULL_BEGIN

//SecAccessControlRef kSecAttrAccessible Secure-Enclave  后续
@interface UkeKeychainConfiguration : NSObject

/**
 * 默认 Service is com.zmkeychain.zhangmen
 * 默认 secClass is kKeychaiSecClassGenericPassword
 */
+ (instancetype)defaultConfiguration;

@property (nonatomic, strong) NSString *service;
@property (nonatomic, assign) KeychainSecClass secClass;

- ( NSDictionary *)keychainQuery;

@end

NS_ASSUME_NONNULL_END
