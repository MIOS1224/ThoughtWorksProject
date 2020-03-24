//
//  MomentOperationMoreItemView.m
//  ZMUke
//
//  Created by liqian on 2018/11/1.
//  Copyright © 2018 zmlearn. All rights reserved.
//

#import "MomentOperationMoreItemView.h"

@interface MomentOperationMoreItemView ()
// 动画图片
@property (nonatomic, readwrite, weak) UIImageView *animView;

@end

@implementation MomentOperationMoreItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        // 设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal|UIControlStateHighlighted];
        // 设置文字大小
        self.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        // 设置title内边距
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        
        // 用于动画的imageView (用于点击按钮的动画)
        UIImageView *animView = [[UIImageView alloc] init];
        animView.hidden = YES;
        self.animView = animView;
        [self addSubview:animView];
    }
    return self;
}

// send the action. the first method is called for the event and is a point at which you can observe or override behavior. it is called repeately by the second.
// 监听事件
- (void)sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event
{
    
    if (!self.allowAnimationWhenClick) {
        [super sendAction:action to:target forEvent:event];
        return;
    }
    // 设置动画
    self.animView.hidden = NO;
    self.animView.transform = CGAffineTransformMakeScale(1, 1);
    self.animView.image = [self imageForState:UIControlStateHighlighted];
    [UIView animateWithDuration:.25 animations:^{
        self.animView.transform = CGAffineTransformScale(self.imageView.transform, .4, .4);
    }completion:^(BOOL finished) {
        self.animView.transform  = CGAffineTransformIdentity;
        self.animView.hidden = YES;
        [super sendAction:action to:target forEvent:event];
    }];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.animView.frame = self.imageView.frame;
}
@end
