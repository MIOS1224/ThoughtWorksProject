//
//  UIView+Frame.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat frameTop;

@property (nonatomic, assign) CGFloat frameX;

@property (nonatomic, assign) CGFloat frameY;

@property (nonatomic, assign) CGFloat frameWidth;

@property (nonatomic, assign) CGFloat frameHeight;

@property (nonatomic,assign)CGSize  frameSize;

@property (nonatomic,assign)CGFloat  frameCenterY;

@property (nonatomic,assign)CGFloat  frameCenterX;

@end
