//
//  UIView+MasExtension.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MasExtension)

- (MASViewAttribute *)mas_safeAreaLayoutGuideTopAttribute;

- (MASViewAttribute *)mas_safeAreaLayoutGuideBottomAttribute;

- (MASViewAttribute *)mas_safeAreaLayoutGuideLeftAttribute;

- (MASViewAttribute *)mas_safeAreaLayoutGuideRightAttribute;

@end

NS_ASSUME_NONNULL_END
