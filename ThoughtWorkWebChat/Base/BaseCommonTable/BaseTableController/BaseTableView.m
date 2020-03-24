//
//  BaseTableView.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/23.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "BaseTableView.h"
#import "MomentHelper.h"

@implementation BaseTableView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [MomentHelper hideAllPopViewWithAnimated:NO];
    [super touchesBegan:touches withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * hitView = [super hitTest:point withEvent:event];
    return hitView;
}

@end
