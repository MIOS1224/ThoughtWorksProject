//
//  TabBarDataModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabBarItemModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *selectedImage;
@property (nonatomic,strong)  UIViewController * controller;

+(TabBarItemModel *)getTabarItem:(NSString  *)title withImage:(NSString *)image andSelectImage:(NSString *)selectImage;

@end

NS_ASSUME_NONNULL_END
