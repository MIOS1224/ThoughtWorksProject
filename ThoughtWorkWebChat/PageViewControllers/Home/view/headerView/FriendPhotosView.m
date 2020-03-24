//
//  FriendPhotosView.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "FriendPhotosView.h"
#import "FriendItemViewModel.h"
#import "FriendItemPhotoView.h"
#import "ImageItemViewModel.h"
#import "YYPhotoGroupView.h"

@interface FriendPhotosView ()

@property (nonatomic,strong) FriendItemViewModel *viewModel;

@end

@implementation FriendPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 预先创建9个图片控件 避免动态创建
        for (int i = 0; i<MHMomentPhotosMaxCount; i++) {
            FriendItemPhotoView *photoView = [[FriendItemPhotoView alloc] init];
            photoView.backgroundColor = self.backgroundColor;
            photoView.hidden = YES;
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(_tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    return self;
}

- (void)bindViewModel:(FriendItemViewModel *)viewModel
{
    self.viewModel = viewModel;
    CGFloat photoViewWH = MHMomentPhotosViewItemWidth();
   // 设置显示or隐藏以及布局
    NSUInteger count = viewModel.picInfos.count;
    if (count==0) [self _hideAllImageViews];
    int maxCols = MHMomentMaxCols(count);
    for (int i = 0; i<MHMomentPhotosMaxCount; i++) {
        FriendItemPhotoView *photoView = self.subviews[i];
        if (i < count) {
           // 显示隐藏
            photoView.hidden = NO;
            if(count == 1) {
                photoView.frame = self.bounds;
            }else{
                photoView.frameWidth = photoViewWH;
                photoView.frameHeight = photoViewWH;
                photoView.frameX = (i % maxCols) * (photoViewWH + MHMomentPhotosViewItemInnerMargin);
                photoView.frameY = (i / maxCols) * (photoViewWH + MHMomentPhotosViewItemInnerMargin);
            }
            // 绑定数据
            [photoView bindViewModel:viewModel.picInfos[i]];
            
        } else {
            // 隐藏
            photoView.hidden = YES;
        }
    }
}

// 隐藏所有图片
- (void)_hideAllImageViews {
    for (FriendItemPhotoView *imageView in self.subviews) {
        imageView.hidden = YES;
    }
}

#pragma mark - 事件处理
- (void)_tapPhoto:(UITapGestureRecognizer *)sender{
   // 图片浏览
    NSMutableArray *items = [NSMutableArray new];
    
    CGFloat count = self.viewModel.picInfos.count;
    for (NSUInteger i = 0; i < count; i++) {
        UIView *imgView = self.subviews[i];
        ImagesModel *picture = [self.viewModel.picInfos[i] picture];
        PictureMetadata *meta = picture.largest.badgeType == PictureBadgeTypeGIF ? picture.largest : picture.large;
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView = imgView;
        item.largeImageURL = [NSURL URLWithString:meta.url];
        item.largeImageSize = CGSizeMake(meta.width, meta.height);
        [items addObject:item];
    }
    
    //关闭弹窗
    [MomentHelper hideAllPopViewWithAnimated:YES];
    
    YYPhotoGroupView *photoBrowser = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    [photoBrowser presentFromImageView:sender.view toContainer:self.window animated:YES completion:NULL];
}


@end

