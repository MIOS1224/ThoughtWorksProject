//
//  ImagesModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  图片模型   图片详细信息

#import <Foundation/Foundation.h>
#import "PictureMetadata.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImagesModel : NSObject

@property (nonatomic,strong)NSString * url;
@property (nonatomic,assign) BOOL keepSize; // < YES:固定为方形 NO:原始宽高比

#pragma mark -预留信息  图片大小转换，压缩处理
@property (nonatomic,strong) PictureMetadata *thumbnail;  // < w:180
@property (nonatomic,strong) PictureMetadata *bmiddle;    // < w:360 (列表中的缩略图)
@property (nonatomic,strong) PictureMetadata *middlePlus; // < w:480
@property (nonatomic,strong) PictureMetadata *large;      // < w:720 (放大查看)
@property (nonatomic,strong) PictureMetadata *largest;   // < (查看原图)
@property (nonatomic,strong) PictureMetadata *original;  // < 原图
@property (nonatomic,assign) PictureBadgeType badgeType; // 图片标记类型

@end

NS_ASSUME_NONNULL_END
