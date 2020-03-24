//
//  UkeKeychain.h
//  TreasProject
//
//  Created by YT on 2018/5/14.
//  Copyright © 2018年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UkeKeychainConfiguration.h"
#import "UkeKeychainBlock.h"

NS_ASSUME_NONNULL_BEGIN

@interface UkeKeychain : NSObject

/**
 * 默认ZMKeychainConfiguration defaultConfiguration
 */
+ (instancetype)shareKeychain;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithConfiguration:(UkeKeychainConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

/**
 * 存储object account为key
 */
- (BOOL)uke_saveObject:(NSString *)object forAccount:(NSString *)account;

/**
 * 存储password account为key
 */
- (BOOL)uke_saveString:(NSString *)string forAccount:(NSString *)account;

/**
 * 存储nsdict  account为key
 */
- (BOOL)uke_saveDict:(NSDictionary *)dictObjc forAccount:(NSString *)account;

/**
 * 获取已存储object account为key
 * @return 返回值为 NSData * 或 nil
 */
- (nullable NSData *)uke_objectForAccount:(NSString *)account;

/**
 * 获取已存储password account为key
 * @return 返回值为 NSString * 或 nil
 */
- (NSString *)uke_stringForAccount:(NSString *)account;

/**
* @return 返回值为 NSDictionary * 或 nil
*/
- (NSDictionary *)uke_dictForAccount:(NSString *)account;
/**
 * 移除 account对应的object
 */
- (BOOL)uke_removeForAccount:(NSString *)account;

@end

@interface UkeKeychain (FunctionalProgramming)

- (ukkc_saveObjectBlock)uke_saveObject;

- (ukkc_savePasswordBlock)uke_savePassword;

- (ukkc_objectBlock)uke_objectForAccount;

- (ukkc_passwordBlock)uke_passwordForAccount;

- (ukkc_removeBlock)uke_removeForAccount;

@end

NS_ASSUME_NONNULL_END
