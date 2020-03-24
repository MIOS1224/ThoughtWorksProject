//
//  ImageItemViewModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImagesModel.h"
#import "PictureMetadata.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageItemViewModel : NSObject

@property (nonatomic, readwrite, strong) ImagesModel *picture;
- (instancetype)initWithPicture:(ImagesModel *)picture;

@end

NS_ASSUME_NONNULL_END
