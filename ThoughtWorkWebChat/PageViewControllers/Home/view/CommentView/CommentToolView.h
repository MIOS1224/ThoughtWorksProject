//
//  CommentToolView.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentToolView : UIView<BaseViewProtocol>

@property (nonatomic, readonly, assign) CGFloat toHeight;

- (BOOL)canBecomeFirstResponder;
- (BOOL)becomeFirstResponder;
- (BOOL)canResignFirstResponder;
- (BOOL)resignFirstResponder;

@end

NS_ASSUME_NONNULL_END
