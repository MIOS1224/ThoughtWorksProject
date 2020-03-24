//
//  SLMessageHUD.h
//  xfqz_iOS
//
//  Created by SL on 2017/1/14.
//  Copyright © 2017年 Ocean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLMessageHUD : UIView

/**
 展示信息

 @param message 信息
 @return 返回HUD
 */
+ (SLMessageHUD *)showMessage:(NSString *)message;

@end
