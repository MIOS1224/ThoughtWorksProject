//
//  UIImage+Extension.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/20.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

//! 为一张图片加上上下左右padding并返回一张新的图片
- (UIImage *)imageWithSpacingExtensionInsets:(UIEdgeInsets)insets;

//! 为一张图片设置透明度并返回一张新的图片
- (UIImage *)imageWithAlpha:(CGFloat)alpha;


//!  根据图片名返回一张能够自由拉伸的图片 (从中间拉伸)
+ (UIImage *)resizableImage:(NSString *)imgName;

//! 为一张图片tint上一个指定的颜色
- (UIImage *)uke_imageWithTintColor:(UIColor *)tintColor;

//! 通过颜色生成一张图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//! 通过渐变颜色生成一张图片 横向从左到右
+ (UIImage *)imageWithGradientColorFrom:(UIColor *)fromColor toColor:(UIColor *)toColor;
+ (UIImage *)imageWithGradientColorFrom:(UIColor *)fromColor toColor:(UIColor *)toColor size:(CGSize)size;

//! 竖向从上到下
+ (UIImage *)imageWithVerticalGradientColorFrom:(UIColor *)fromColor toColor:(UIColor *)toColor;

+ (UIImage *)imageWithGradientColorFrom:(UIColor *)fromColor
                                toColor:(UIColor *)toColor
                           isHorizontal:(BOOL) isHorizontal
                                   size:(CGSize)size;

+ (UIImage *)imageWithGradientColorFrom:(UIColor *)fromColor
                                toColor:(UIColor *)toColor
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                                   size:(CGSize)size;
///! 根据图片url获取网络图片尺寸
+ (CGSize)getImageSizeWithURL:(id)URL;


+(UIImage *)compressImageWith:(UIImage *)image;

//! 判断图片是否存在alpha通道
- (BOOL)hasAlphaChannel;



/**
 Returns a vertically flipped image. ⥯
 */
- (nullable UIImage *)imageByFlipVertical;

/**
 Returns a horizontally flipped image. ⇋
 */
- (nullable UIImage *)imageByFlipHorizontal;


- (nullable UIImage *)imageByResizeToSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
