//
//  FriendItemPhotoView.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "FriendItemPhotoView.h"
#import "ImageItemViewModel.h"

@interface FriendItemPhotoView ()

@property (nonatomic, readwrite, strong) ImageItemViewModel *viewModel;

@end

@implementation FriendItemPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds  = YES;
        self.exclusiveTouch = YES;
    }
    return self;
}

- (void)bindViewModel:(ImageItemViewModel *)viewModel
{
    self.viewModel = viewModel;
    /// 移除动画
    [self.layer removeAnimationForKey:@"contents"];
    /// 请求图片
    @weakify(self);
    NSURL * url = [NSURL URLWithString:viewModel.picture.url];
    [self.layer yy_setImageWithURL:url
                       placeholder:[UIImage imageNamed:@"wx_timeline_image_placeholder"]
                           options:YYWebImageOptionAvoidSetImage
                        completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
        @strongify(self);
        
        if (image && stage == YYWebImageStageFinished) {
//            int width = viewModel.picture.bmiddle.width;
//            int height = viewModel.picture.bmiddle.height;
//            CGFloat scale = (height / width) / (self.frameHeight / self.frameWidth);
//            if (scale < 0.99 || isnan(scale)) {
//                // 宽图把左右两边裁掉
//                self.contentMode = UIViewContentModeScaleAspectFill;
//                self.layer.contentsRect = CGRectMake(0, 0, 1, 1);
//            } else {
//                // 高图只保留顶部
//                self.contentMode = UIViewContentModeScaleToFill;
//                self.layer.contentsRect = CGRectMake(0, 0, 1, (float)width / height);
//            }
            self.image = image;
            if (from != YYWebImageFromMemoryCacheFast) {
                CATransition *transition = [CATransition animation];
                transition.duration = 0.15;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                transition.type = kCATransitionFade;
                [self.layer addAnimation:transition forKey:@"contents"];
            }
        }
    }];
}
#pragma mark - Override
- (void)setHidden:(BOOL)hidden{
    //取消请求
    if (hidden) [self.layer yy_cancelCurrentImageRequest];
    [super setHidden:hidden];
}
@end

