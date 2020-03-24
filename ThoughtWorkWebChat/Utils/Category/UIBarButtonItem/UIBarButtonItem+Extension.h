//
//  UIBarButtonItem+Extension.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)systemItemWithTitle:(nonnull NSString *)title
                              titleColor:(nonnull UIColor *)titleColor
                               imageName:(nonnull NSString *)imageName
                                  target:(id)target
                                selector:(SEL)selector
                                textType:(BOOL)textType;

+ (UIBarButtonItem *)systemItemWithImageName:(nonnull NSString *)imageName target:(id)target selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
