//
//  ImagesModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "ImagesModel.h"
#import "UIImage+Extension.h"

@implementation ImagesModel

//预留信息
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    // 特殊额外处理
    PictureMetadata *meta = _large ? _large : _largest ? _largest : _original;
    _badgeType = meta.badgeType;
    return YES;
}

@end
