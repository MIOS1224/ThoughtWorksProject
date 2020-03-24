//
//  UIBarButtonItem+Extension.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)systemItemWithTitle:(nonnull NSString *)title
                              titleColor:(nonnull UIColor *)titleColor
                               imageName:(nonnull NSString *)imageName
                                  target:(id)target
                                selector:(SEL)selector
                                textType:(BOOL)textType {
    UIBarButtonItem *item = textType ?
    ({
        /// 设置普通状态的文字属性
        item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:selector];
        titleColor = titleColor?titleColor:[UIColor whiteColor];
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = titleColor;
        textAttrs[NSFontAttributeName] = [UIFont fontWithName:@"PingFangSC-Regular" size:16.0f];
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset =  CGSizeZero;
        textAttrs[NSShadowAttributeName] = shadow;
        [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        // 设置高亮状态的文字属性
        NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        highTextAttrs[NSForegroundColorAttributeName] = [titleColor colorWithAlphaComponent:.5f];
        [item setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
        
        // 设置不可用状态(disable)的文字属性
        NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        disableTextAttrs[NSForegroundColorAttributeName] = [titleColor colorWithAlphaComponent:.5f];
        [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
        
        item;
    }) : ({
        item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:selector];
        item;
    });
    return item;
}

+ (UIBarButtonItem *)systemItemWithImageName:(nonnull NSString *)imageName target:(id)target selector:(SEL)selector {
    
    UIBarButtonItem *item = item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:selector];
    return item;
}


@end
