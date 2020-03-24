//
//  UIView+Frame.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setFrameWidth:(CGFloat)frameWidth
{
    CGRect rect = self.frame;
    rect.size.width = frameWidth;
    self.frame = rect;
}

- (CGFloat)frameWidth
{
    return self.frame.size.width;
}

- (void)setFrameHeight:(CGFloat)frameHeight
{
    CGRect rect = self.frame;
    rect.size.height = frameHeight;
    self.frame = rect;
}

- (CGFloat)frameHeight
{
    return self.frame.size.height;
}

- (void)setFrameX:(CGFloat)frameX
{
    CGRect rect = self.frame;
    rect.origin.x = frameX;
    self.frame = rect;
}

- (void)setFrameCenterX:(CGFloat)frameCenterX
{
    CGPoint center = self.center;
    center.x = frameCenterX;
    self.center = center;
}
- (CGFloat)frameCenterX
{
    return self.center.x;
}

- (void)setFrameCenterY:(CGFloat)frameCenterY
{
    CGPoint center = self.center;
    center.y = frameCenterY;
    self.center = center;
}
- (CGFloat)frameCenterY
{
    return self.center.y;
}

- (CGFloat)frameX
{
    return self.frame.origin.x;
}

- (void)setFrameY:(CGFloat)frameY
{
    CGRect rect = self.frame;
    rect.origin.y = frameY;
    self.frame = rect;
}

- (CGFloat)frameY
{
    return self.frame.origin.y;
}

- (void)setFrameSize:(CGSize)frameZize
{
    CGRect frame = self.frame;
    frame.size = frameZize;
    self.frame = frame;
}
- (CGSize)frameSize
{
    return self.frame.size;
}
- (void)setFrameTop:(CGFloat)frameTop
{
    CGRect frame = self.frame;
    frame.origin.y = frameTop;
    self.frame = frame;
}
- (CGFloat)frameTop
{
    return self.frame.origin.y;
}

@end
