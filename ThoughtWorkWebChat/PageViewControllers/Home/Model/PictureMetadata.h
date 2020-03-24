//
//  PictureMetadata.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PictureMetadata : NSObject

@property (nonatomic,assign) int width;  //  pixel width
@property (nonatomic,assign) int height; //  pixel height

@property (nonatomic,copy) NSString *url;   //  image url
@property (nonatomic,copy) NSString *type;  //  "WEBP" "JPEG" "GIF"

@property (nonatomic,assign) PictureBadgeType badgeType;  // 图片标记 （正常 GIF 长图）

@end

NS_ASSUME_NONNULL_END
