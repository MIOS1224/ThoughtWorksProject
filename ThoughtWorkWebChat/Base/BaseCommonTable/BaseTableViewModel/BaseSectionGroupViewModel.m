//
//  BaseSectionGroupViewModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "BaseSectionGroupViewModel.h"

@implementation BaseSectionGroupViewModel

+ (instancetype)groupViewModel{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _footerHeight = 21;
        _headerHeight = CGFLOAT_MIN;
    }
    return self;
}

@end
