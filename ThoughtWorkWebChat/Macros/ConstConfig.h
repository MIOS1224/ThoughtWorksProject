//
//  ConstConfig.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/19.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#ifndef ConstConfig_h
#define ConstConfig_h

/// pictureView显示图片的最大列数
#define MHMomentMaxCols(__photosCount) ((__photosCount==4)?2:3)

//tableView headview 高度
#define MY_TABLEHEADERHEIGHT   (MY_SCREEN_WIDTH * 3/4)
//MARK: 反向传值BLOCK
typedef void (^CallBlock)(id);

/// 评论内容距离顶部的间距 5
static CGFloat const MHMomentCommentViewContentTopOrBottomInset = 5;
/// 评论内容距离评论View左右屏幕的间距 9
static CGFloat const MHMomentCommentViewContentLeftOrRightInset = 9;

/// 点赞内容距离顶部的间距 7
static CGFloat const MHMomentCommentViewAttitudesTopOrBottomInset = 7;

static CGFloat const MHMomentProfileViewAvatarViewWH = 75.0f;

/// 向上箭头W 45
static CGFloat const MHMomentUpArrowViewWidth = 45.0f;
/// 向上箭头H 6
static CGFloat const MHMomentUpArrowViewHeight = 6.0f;

/// 全文、收起W
static CGFloat const MHMomentExpandButtonWidth = 35.0f;
/// 全文、收起H
static CGFloat const MHMomentExpandButtonHeight = 25.0f;
// cell 分割线高度 .5
static CGFloat const MYGlobalBottomLineHeight = 0.5f;
/// 说说内容距离顶部的间距 16
static CGFloat const MHMomentContentTopInset = 16.0f;
/// 说说内容距离左右屏幕的间距 20
static CGFloat const MHMomentContentLeftOrRightInset = 20.0f;
/// 内容（控件）之间的的间距 10
static CGFloat const MHMomentContentInnerMargin = 10.0f;
/// 用户头像的大小 44x44
static CGFloat const MHMomentAvatarWH = 44.0f;

static NSUInteger const MHMomentContentTextMaxCriticalRow = 12000;
/// 微信正文内容显示（全文/收起）的临界行
static NSUInteger const MHMomentContentTextExpandCriticalRow = 6;
/// pictureView最多显示的图片数
static NSUInteger const MHMomentPhotosMaxCount = 9;

/// 更多按钮宽高 (实际：25x25)
static CGFloat const MHMomentOperationMoreBtnWH = 25;

/// footerViewHeight
static CGFloat const MHMomentFooterViewHeight = 15;


/// pictureView中图片之间的的间距 6
static CGFloat const MHMomentPhotosViewItemInnerMargin = 6.0f;
/// pictureView中图片的大小 86x86 (屏幕尺寸>320)
static CGFloat const MHMomentPhotosViewItemWH1 = 86.0f;
/// pictureView中图片的大小 70x70 (屏幕尺寸<=320)
static CGFloat const MHMomentPhotosViewItemWH2 = 70.0f;

/// 单张图片的最大高度（等比例）180 (ps：别问我为什么，我量出来的)
static CGFloat const MHMomentPhotosViewSingleItemMaxHeight = 160.0f;


/// 评论View
/** 弹出评论框View最小高度 */
static CGFloat const MHMomentCommentToolViewMinHeight = 60;
/** 弹出评论框View最大高度 */
static CGFloat const MHMomentCommentToolViewMaxHeight = 130;
/** 弹出评论框View的除了编辑框的高度 */
static CGFloat const MHMomentCommentToolViewWithNoTextViewHeight = 20;


/// 计算微信说说正文的limitWidth或者评论View的宽度
static inline CGFloat MHMomentCommentViewWidth() {
    return ([UIScreen mainScreen].bounds.size.width - MHMomentContentLeftOrRightInset*2 - MHMomentAvatarWH - MHMomentContentInnerMargin);
}

/// 图片的宽度 （九宫格）
static inline CGFloat MHMomentPhotosViewItemWidth(){
    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width<=320)? MHMomentPhotosViewItemWH2:MHMomentPhotosViewItemWH1;
    return itemW;
}

/// 单张图片的最大宽度（方形or等比例）
static inline CGFloat MHMomentPhotosViewSingleItemMaxWidth(){
    CGFloat itemW = MHMomentPhotosViewItemWidth();
    return MHMomentPhotosViewItemInnerMargin + itemW*2;
}


/// 用户信息key
static NSString * const MHMomentUserInfoKey = @"MHMomentUserInfoKey";

/// 链接key
static NSString * const MHMomentLinkUrlKey = @"MHMomentLinkUrlKey";
/// 电话号码key
static NSString * const MHMomentPhoneNumberKey = @"MHMomentPhoneNumberKey";
/// 位置key
static NSString * const MHMomentLocationNameKey = @"MHMomentLocationNameKey";


typedef NS_ENUM(NSUInteger, FriendExtendType) {
    FriendExtendTypePicture = 0, /// 配图
    FriendExtendTypeVideo,       /// 视频
    FriendExtendTypeShare,       /// 分享
};

/// 图片标记
typedef NS_ENUM(NSUInteger, PictureBadgeType) {
    PictureBadgeTypeNone = 0, ///< 正常图片
    PictureBadgeTypeLong,     ///< 长图
    PictureBadgeTypeGIF,      ///< GIF
};

//全局背景颜色
#define MY_MAIN_BACKGROUNDCOLOR [UIColor colorFromHexString:@"#EFEFF4"]

#endif /* ConstConfig_h */
