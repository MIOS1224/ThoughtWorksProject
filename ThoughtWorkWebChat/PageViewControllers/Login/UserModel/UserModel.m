//
//  UserModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"profileImage":@"profile_image_url"};
}
@end
