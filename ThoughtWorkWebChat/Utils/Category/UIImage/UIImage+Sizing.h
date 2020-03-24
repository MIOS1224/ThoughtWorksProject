//
//  UIImage+Sizing.h
//  TreasProject
//
//  Created by YT on 2018/5/20.
//  Copyright © 2018年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Sizing)

@property (nonatomic, strong) NSNumber *compressRate;

- (UIImage *)zke_clipWithFrame:(CGRect )frame linmitedSize:(CGSize)size limitedDataLength:(NSUInteger )dataLength;

/**
 * 获取相对于self rect位置的图片
 */
- (UIImage *)zke_imageClipInRect:(CGRect)rect;

/**
 * 将图片缩小到 @param size 大小
 */
- (UIImage*)zke_imageScaleToSize:(CGSize)size;

/**
 * 图片质量压缩 压缩返回的图片含有一个压缩比率
 */
- (UIImage *)zke_compressQualityWithMaxLength:(NSInteger)maxLength;

- (void)zke_compressQualityWithMaxLength:(NSInteger)maxLength complete:(void(^)(NSData *imageData, NSNumber *compressRate))complete;

@end

NS_ASSUME_NONNULL_END
