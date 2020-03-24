//
//  NSMutableAttributedString+Matching.h
//  TreasProject
//
//  Created by YT on 2018/5/20.
//  Copyright © 2018年 YT. All rights reserved.
//  主要用于微博内容的公共处理

#import "NSMutableAttributedString+Matching.h"

@implementation NSMutableAttributedString (Matching)
- (void)regexContentWithWithEmojiImageFontSize:(CGFloat)fontSize{
    // 高亮背景
    YYTextBorder *border = [YYTextBorder new];
    border.cornerRadius = 0;
    border.insets = UIEdgeInsetsMake(0, -1, 0, -1);
    border.fillColor = [UIColor colorFromHexString:@"#C7C7C7"];
    
    // 匹配链接
    NSArray<NSTextCheckingResult *> *linkUrlResults = [[NSObject regexLinkUrl] matchesInString:self.string options:kNilOptions range:self.yy_rangeOfAll];
    for (NSTextCheckingResult *link in linkUrlResults) {
        if (link.range.location == NSNotFound && link.range.length <= 1) continue;
        if ([self yy_attribute:YYTextHighlightAttributeName atIndex:link.range.location] == nil) {
            [self yy_setColor:[UIColor colorFromHexString:@"#4380D1"] range:link.range];
            // 点击高亮
            YYTextHighlight *highlight = [YYTextHighlight new];
            
            highlight.userInfo = @{MHMomentLinkUrlKey:[self.string substringWithRange:link.range]};
            [highlight setBackgroundBorder:border];
            [self yy_setTextHighlight:highlight range:link.range];
        }
    }
}
@end

