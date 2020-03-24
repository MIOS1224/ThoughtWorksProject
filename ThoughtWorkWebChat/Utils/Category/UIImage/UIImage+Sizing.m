//
//  UIImage+Sizing.m
//  TreasProject
//
//  Created by YT on 2018/5/20.
//  Copyright © 2018年 YT. All rights reserved.
//

#import "UIImage+Sizing.h"

const NSString *Uke_Compress_Rate_Key;

@implementation UIImage (Sizing)

- (void)setCompressRate:(NSNumber *)compressRate {
    
    objc_setAssociatedObject(self, &Uke_Compress_Rate_Key, compressRate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)compressRate {
    
    return objc_getAssociatedObject(self, &Uke_Compress_Rate_Key);
}


- (UIImage *)zke_clipWithFrame:(CGRect )frame linmitedSize:(CGSize)size limitedDataLength:(NSUInteger )dataLength {
    
    UIImage *result = self;
    
    // 如果Size大小和self大小不同 则裁剪图片到 frame
    if ( !CGSizeEqualToSize(self.size, frame.size)) {
        result = [result zke_imageClipInRect:frame];
    }
    
    // 当size传入不为Zero 缩放size
    if ( !CGSizeEqualToSize(CGSizeZero, size)) {
        result = [result zke_imageScaleToSize:size];
    }
    
    if ( 0 != dataLength) {
        result = [result zke_compressQualityWithMaxLength:dataLength];
    }
    
    return result;
}


/**
 * 从图片中按指定的位置大小截取图片的一部分
 */
- (UIImage *)zke_imageClipInRect:(CGRect)rect {
    
    // 使用真实图片尺寸
    CGRect realRect = CGRectMake(rect.origin.x*self.scale, rect.origin.y*self.scale, rect.size.width*self.scale, rect.size.height*self.scale);
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [self CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, realRect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    
    //返回剪裁后的图片
    return newImage;
}

/**
 * 将图片缩放到指定的CGSize大小
 */
- (UIImage*)zke_imageScaleToSize:(CGSize)size {
    
    // 得到图片上下文，指定绘制范围
    UIGraphicsBeginImageContext(size);
    
    // 将图片按照指定大小绘制
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前图片上下文中导出图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 当前图片上下文出栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

/**
 * 将图片压缩到指定大小
 */
- (UIImage *)zke_compressQualityWithMaxLength:(NSInteger)maxLength {
    
    __block UIImage *result;
    
    [self zke_compressQualityWithMaxLength:maxLength complete:^(NSData * _Nonnull imageData, NSNumber * _Nonnull compressRate) {
        
        result = [UIImage imageWithData:imageData];
        result.compressRate = compressRate;
    }];
    
    return result;
}

- (void)zke_compressQualityWithMaxLength:(NSInteger)maxLength complete:(void(^)(NSData *imageData, NSNumber *compressRate))complete {
    
    NSInteger kbMaxLength = 1024 * maxLength;
    
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    
    if (data.length > kbMaxLength) {
        
        CGFloat max = 1;
        CGFloat min = 0;
        
        // 最多循环6次
        for (int i = 0; i < 6; ++i) {
            
            compression = (max + min) / 2;
            data = UIImageJPEGRepresentation(self, compression);
            
            if (data.length < kbMaxLength * 0.9) { // 当压缩完大小小于 maxLength * 0.9的时候 继续压缩
                min = compression;
            } else if (data.length > kbMaxLength) { // 当压缩完大小大于 maxLength 继续压缩
                max = compression;
            } else { // 压缩完大小在 0.9*maxLength 到 maxLength 之间 不再压缩
                break;
            }
        }
    }
    
    !complete ?: complete(data, @(compression));
}

@end
