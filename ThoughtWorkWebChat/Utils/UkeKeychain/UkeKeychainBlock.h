//
//  UkeKeychainBlock.h
//  TreasProject
//
//  Created by YT on 2018/5/14.
//  Copyright © 2018年 YT. All rights reserved.
//

#ifndef UkeKeychainBlock_h
#define UkeKeychainBlock_h

@class UkeKeychain;

NS_ASSUME_NONNULL_BEGIN

/** ZMKeychain */
typedef UkeKeychain * _Nonnull        (^ukkc_saveObjectBlock)( NSString *account, id object);
typedef UkeKeychain * _Nonnull        (^ukkc_savePasswordBlock)( NSString *account, NSString * password);

typedef NSData *_Nullable   (^ukkc_objectBlock)( NSString *account);
typedef NSString *_Nullable (^ukkc_passwordBlock)( NSString *account);

typedef BOOL          (^ukkc_removeBlock)( NSString *account);

NS_ASSUME_NONNULL_END

#endif /* ZMKeychainBlock_h */
