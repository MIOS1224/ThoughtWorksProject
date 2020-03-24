//
//  ImageItemViewModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "ImageItemViewModel.h"

@implementation ImageItemViewModel

- (instancetype)initWithPicture:(ImagesModel *)picture
{
    if(self = [super init])
    {
        self.picture = picture;
    }
    return self;
}

@end
