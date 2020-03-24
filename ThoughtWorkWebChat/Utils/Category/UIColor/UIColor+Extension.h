//
//  UIColor+Extension.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/20.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)

+(UIColor *)colorFromHexString:(NSString *)colorStr;

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
