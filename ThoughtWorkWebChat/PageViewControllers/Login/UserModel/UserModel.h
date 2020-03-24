//
//  UserModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface UserModel : NSObject

@property (nonatomic,copy)NSString * nick;
@property (nonatomic,copy)NSString * avatar;
@property (nonatomic,copy)NSString * username;
@property (nonatomic,copy)NSString * profileImage;

@end

NS_ASSUME_NONNULL_END
