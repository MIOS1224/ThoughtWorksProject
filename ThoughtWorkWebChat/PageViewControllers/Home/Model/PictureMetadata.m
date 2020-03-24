//
//  PictureMetadata.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "PictureMetadata.h"

@implementation PictureMetadata

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([_type isEqualToString:@"GIF"]) {
        _badgeType = PictureBadgeTypeGIF;
    } else {
        if (_width > 0 && (float)_height / _width > 3) {
            _badgeType = PictureBadgeTypeLong;
        }
    }
    return YES;
}

@end
