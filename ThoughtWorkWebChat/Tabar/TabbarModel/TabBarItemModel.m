//
//  TabBarDataModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "TabBarItemModel.h"

@implementation TabBarItemModel

+(TabBarItemModel *)getTabarItem:(NSString  *)title withImage:(NSString *)image andSelectImage:(NSString *)selectImage
{
    if ([NSString stringIsEmpty:title]) {
        title = @"";
        NSAssert(title, @"tabbar's title is empty");
    }
    if ([NSString stringIsEmpty:image]) {
        image = @"";
         NSAssert(title, @"tabbar's image is empty");
    }
    if ([NSString stringIsEmpty:selectImage]) {
        image = @"";
         NSAssert(title, @"tabbar's selectImage is empty");
    }
    
    TabBarItemModel * model = [[TabBarItemModel alloc]init];
    model.title = title;
    model.image = image;
    model.selectedImage = selectImage;
    
    return model;
}

@end
