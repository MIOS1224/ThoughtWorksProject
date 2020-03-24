//
//  SLMessageHUD.m
//  xfqz_iOS
//
//  Created by SL on 2017/1/14.
//  Copyright © 2017年 Ocean. All rights reserved.
//

#import "SLMessageHUD.h"

@implementation SLMessageHUD

static SLMessageHUD *_messageHUD;

#pragma mark
#pragma mark --- 单例 ---
+ (SLMessageHUD *)shareMessageHUD{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _messageHUD = [[SLMessageHUD alloc] init];
        _messageHUD.frame = (CGRect){CGPointZero,CGSizeMake(kScreenWidth, kScreenHeight)};
        _messageHUD.backgroundColor = [UIColor colorWithWhite:0.5f alpha:0.2f];
    });
    
    return _messageHUD;
}

+ (SLMessageHUD *)showMessage:(NSString *)message{
    
    SLMessageHUD *hud = [SLMessageHUD shareMessageHUD];
    [self messageLabelWith:message];
    
    UIWindow *window = [UIWindow getKeyWindow];
    [window addSubview:hud];

    [hud performSelector:@selector(hudHidde:) withObject:hud afterDelay:1.0f];
    
    return hud;
}

- (void)hudHidde:(UIView *)hud{
    [hud removeFromSuperview];
    [[hud.subviews lastObject] removeFromSuperview];
    [[hud.subviews firstObject] removeFromSuperview];
}

+ (void)messageLabelWith:(NSString *)message{
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = [message boundingRectWithSize:CGSizeMake(240, 60) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    CGSize bSzie;
    if (size.width < 175) {
        bSzie.width = 185;
        bSzie.height = 35;
    }
    else if (size.width < 220){
        bSzie.width = 230;
        bSzie.height = 35;
    }
    else{
        bSzie.width = 260;
        bSzie.height = 60;
    }
    
    UIView *bgview = [[UIView alloc] init];
    bgview.center = CGPointMake(_messageHUD.frameCenterX, _messageHUD.frameCenterY - 100);
    bgview.layer.cornerRadius = 17;
    bgview.backgroundColor = MyColorRGB(121, 121, 121);
    bgview.clipsToBounds = YES;
    bgview.bounds = (CGRect){CGPointZero, bSzie};
    [_messageHUD addSubview:bgview];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.bounds = (CGRect){CGPointZero, size};
    label.center = bgview.center;
    label.backgroundColor = [UIColor clearColor];
    label.text = message;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [_messageHUD addSubview:label];
    
}

@end
