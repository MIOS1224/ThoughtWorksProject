//
//  AvatarHeaderView.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYGestureRecognizer.h"

NS_ASSUME_NONNULL_BEGIN

@interface AvatarHeaderView : UIView

@property (nonatomic,strong) UIImage *image;
//长按事件
@property (nonatomic,copy) void (^longPressBlock)(AvatarHeaderView *view, CGPoint point);
//点击事件
@property (nonatomic,copy) void (^touchBlock)(AvatarHeaderView *view, YYGestureRecognizerState state, NSSet *touches, UIEvent *event);

@end

NS_ASSUME_NONNULL_END
