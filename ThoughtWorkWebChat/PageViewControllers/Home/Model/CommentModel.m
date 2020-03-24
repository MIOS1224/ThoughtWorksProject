//
//  CommentModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"momentIdstr"      : @"moment_idstr",
             @"toUser"           : @"to_user",
             @"fromUser"         : @"from_user"
             };
}

@end
