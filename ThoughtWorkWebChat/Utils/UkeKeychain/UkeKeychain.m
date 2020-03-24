//
//  UkeKeychain.m
//  TreasProject
//
//  Created by YT on 2018/5/14.
//  Copyright © 2018年 YT. All rights reserved.
//

#import "UkeKeychain.h"

@interface UkeKeychain ()

@property (nonatomic, strong) UkeKeychainConfiguration *configuration;

@end

@implementation UkeKeychain


+ (instancetype)shareKeychain {
    
    static UkeKeychain *result;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        result = [[self alloc] initWithConfiguration:UkeKeychainConfiguration.defaultConfiguration];
    });
    
    return result;
}

- (instancetype)initWithConfiguration:(UkeKeychainConfiguration *)configuration {
    
    if (self = [super init]) {
        _configuration = configuration;
    }
    return self;
}

#pragma mark - Private
- (NSData *)uke_dataWithObject:(id)object {
    
    if ([object isKindOfClass:NSData.class]) {
        
        return object;
    } else if ([object isKindOfClass:NSString.class]) {
        
        return [object dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([object isKindOfClass:NSArray.class] || [object isKindOfClass:NSDictionary.class]) {
        
        NSError *err = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&err];
        
        return err ? nil:data;
    }
    
    return nil;
    
}

#pragma mark - Public
- (BOOL)uke_saveDict:(NSDictionary *)dictObjc forAccount:(NSString *)account{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictObjc options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {}else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return [self uke_saveObject:mutStr forAccount:account];
}

- (BOOL)uke_saveString:(NSString *)string forAccount:(NSString *)account {
    
    return [self uke_saveObject:string forAccount:account];
}

- (NSDictionary *)uke_dictForAccount:(NSString *)account {
    NSData *data = [self uke_objectForAccount:account];
    NSError *err;
    if (data == nil) {
        return nil;
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dict;
}

- (NSString *)uke_stringForAccount:(NSString *)account {
    
    NSData *data = [self uke_objectForAccount:account];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (BOOL)uke_removeForAccount:(NSString *)account {
    
    if (!account || [account isKindOfClass:NSNull.class]) {
        return false;
    }
    
    NSMutableDictionary *query = [self.configuration keychainQuery].mutableCopy;
    
    [query setObject:account forKey:(__bridge id)kSecAttrAccount];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    
    return status == errSecSuccess;
}

#pragma mark - Private
- (BOOL)uke_saveObject:(id)object forAccount:(NSString *)account {
    if (!account || [account isKindOfClass:NSNull.class]) {
        return false;
    }
    NSMutableDictionary *query = [self.configuration keychainQuery].mutableCopy;
    [query setObject:account forKey:(__bridge id)kSecAttrAccount];
    
    //添加前先查找以前添加
    NSData *data = [self uke_dataWithObject:object];
    if (!data) { //如果data为nil 删除数据
        return false;
    }
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, nil);
    if (status == errSecSuccess) {//item 已经存在，更新它
        
        NSMutableDictionary *updateQuery = [[NSMutableDictionary alloc] init];
        [updateQuery setObject:data forKey:(__bridge id)kSecValueData];
        status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)updateQuery);
        
    } else if (status == errSecItemNotFound) {//item未找到，创建它
        
        [query setObject:data forKey:(__bridge id)kSecValueData];
        status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    }
    return status == errSecSuccess;
}

- (NSData *)uke_objectForAccount:(NSString *)account {
    if (!account || [account isKindOfClass:NSNull.class]) {
        return nil;
    }
    
    NSMutableDictionary *query = [self.configuration keychainQuery].mutableCopy;
    [query setObject:account forKey:(__bridge id)kSecAttrAccount];
    
    CFTypeRef result = NULL;
    
    [query setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [query setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    
    return errSecSuccess == status ? (__bridge_transfer NSData *)result : nil;
}

@end

@implementation UkeKeychain (FunctionalProgramming)

- (ukkc_saveObjectBlock)uke_saveObject {
    
    return ^( NSString *account, id object) {
        
        [UkeKeychain.shareKeychain uke_saveObject:object forAccount:account];
        return self;
    };
}

- (ukkc_savePasswordBlock)uke_savePassword {
    
    return ^( NSString *account, NSString *password) {
        
        [UkeKeychain.shareKeychain uke_saveString:password forAccount:account];
        return self;
    };
}

- (ukkc_objectBlock)uke_objectForAccount {
    
    return ^(NSString *account) {
        
        return [UkeKeychain.shareKeychain uke_objectForAccount:account];
    };
}

- (ukkc_passwordBlock)uke_passwordForAccount {
    
    return ^(NSString *account) {
        
        return [UkeKeychain.shareKeychain uke_stringForAccount:account];
    };
}

- (ukkc_removeBlock)uke_removeForAccount {
    
    return ^(NSString *account) {
        
        return [UkeKeychain.shareKeychain uke_removeForAccount:account];
    };
}

@end
