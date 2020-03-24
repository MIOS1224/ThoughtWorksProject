//
//  UINavigationBar+Extension.h
//  WebChat
//
//  Created by YT on 2017/3/24.
//  Copyright © 2017年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (Extension)
- (void)yt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)yt_setElementsAlpha:(CGFloat)alpha;
- (void)yt_setTranslationY:(CGFloat)translationY;
- (void)yt_reset;
@end

NS_ASSUME_NONNULL_END
