//
//  FriendItemModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//


#import "FriendItemViewModel.h"
#import "LikeItemViewModel.h"
#import "CommentItemViewModel.h"
#import "UserModelManager.h"
#import "NSMutableAttributedString+Matching.h"

@interface FriendItemViewModel ()

@property (nonatomic,strong) RACCommand *attitudeOperationCmd; // 赞cmd
@property (nonatomic,strong) RACCommand *expandOperationCmd; // 展开全文cmd
@property (nonatomic,strong) NSMutableArray *dataSource; // 点赞+评论列表

@end

@implementation FriendItemViewModel

- (instancetype)initWithMoment:(FriendModel *)moment{
    if (self = [super init]) {
        self.moment = moment;
        
        // 内容宽度
        CGFloat limitWidth = MHMomentCommentViewWidth();
        YYTextContainer *singleRowContainer = [YYTextContainer containerWithSize:YYTextContainerMaxSize];
        singleRowContainer.maximumNumberOfRows = 1;
    
        // 高亮背景
        YYTextBorder *border = [YYTextBorder new];
        border.cornerRadius = 0;
        border.insets = UIEdgeInsetsMake(0, -1, 0, -1);
        border.fillColor = MyColorFromHexString(@"#C7C7C7");
        
        // 昵称
        if ([NSString stringIsNotEmpty:moment.sender.username]) {
            // 富文本
            NSMutableAttributedString *screenNameAttr = [[NSMutableAttributedString alloc] initWithString:moment.sender.username];
            screenNameAttr.yy_font = MyFontRegular(15);
            screenNameAttr.yy_color = MyColorFromHexString(@"#5B6A92");
            screenNameAttr.yy_lineBreakMode = NSLineBreakByCharWrapping;
            screenNameAttr.yy_alignment = NSTextAlignmentLeft;
            // 设置高亮
            YYTextHighlight *highlight = [YYTextHighlight new];
            highlight.userInfo = @{MHMomentUserInfoKey:moment.sender};
            [highlight setBackgroundBorder:border];
            [screenNameAttr yy_setTextHighlight:highlight range:screenNameAttr.yy_rangeOfAll];
            YYTextContainer *screenNameLableContainer = [YYTextContainer containerWithSize:CGSizeMake(limitWidth, MAXFLOAT)];
            screenNameLableContainer.maximumNumberOfRows = 1;
            YYTextLayout *screenNameLableLayout = [YYTextLayout layoutWithContainer:screenNameLableContainer text:screenNameAttr.copy];
            self.screenNameLableLayout = screenNameLableLayout;
        }
        
        // 正文有值
        if ([NSString stringIsNotEmpty:moment.content]){
            NSMutableAttributedString *textAttr = [[NSMutableAttributedString alloc] initWithString:moment.content];
            textAttr.yy_font = MyFontRegular(15);
            textAttr.yy_color = MyColorFromHexString(@"#000000");
            textAttr.yy_lineBreakMode = NSLineBreakByCharWrapping;
            textAttr.yy_alignment = NSTextAlignmentLeft;
            
            // 去正则匹配
            [textAttr regexContentWithWithEmojiImageFontSize:15];
            
            // 实现布局好宽高 以及属性
            YYTextContainer *contentLableContainer = [YYTextContainer containerWithSize:CGSizeMake(limitWidth, MAXFLOAT)];
            contentLableContainer.maximumNumberOfRows = 0;
            YYTextLayout *contentLableLayout = [YYTextLayout layoutWithContainer:contentLableContainer text:textAttr.copy];
            self.contentLableLayout = contentLableLayout;
        }
        
        // 配图
        if ([NSObject objIsNotNull:moment.images] && moment.images.count > 0) {
            self.picInfos = [moment.images.rac_sequence map:^ImageItemViewModel *(ImagesModel * picture) {
                ImageItemViewModel *viewModel = [[ImageItemViewModel alloc] initWithPicture:picture];
                return viewModel;
            }].array;
        }

        // 点赞列表
        if(self.moment.attitudesList.count>0){
            // 需要
            LikeItemViewModel *like = [[LikeItemViewModel alloc] initWithMoment:moment];
            [self.dataSource addObject:like];
            
        }
        if (self.moment.comments.count>0) {
            [self.dataSource addObjectsFromArray:[self.moment.comments.rac_sequence map:^CommentItemViewModel *(CommentModel * comment) {
                CommentItemViewModel *viewModel = [[CommentItemViewModel alloc] initWithComment:comment];
                return viewModel;
            }].array];
        }
        
        // ----------- 尺寸属性 -----------
        // 头像
        CGFloat avatarViewX = MHMomentContentLeftOrRightInset;
        CGFloat avatarViewY = MHMomentContentTopInset;
        CGFloat avatarViewW = MHMomentAvatarWH;
        CGFloat avatarViewH = MHMomentAvatarWH;
        self.avatarViewFrame = CGRectMake(avatarViewX, avatarViewY, avatarViewW, avatarViewH);
        
        // 昵称
        CGFloat screenNameLableX = CGRectGetMaxX(self.avatarViewFrame)+MHMomentContentInnerMargin;
        CGFloat screenNameLableY = avatarViewY;
        CGFloat screenNameLableW = self.screenNameLableLayout.textBoundingSize.width;
        CGFloat screenNameLableH = self.screenNameLableLayout.textBoundingSize.height;
        self.screenNameLableFrame = CGRectMake(screenNameLableX, screenNameLableY, screenNameLableW, screenNameLableH);
  
        // 由于要点击 全文/展开 更新子控件的尺寸 , 故抽取出来
        [self _updateSubviewsFrameWithExpand:NO];
        
        [self initialize];
    }
    return self;
}

#pragma mark - 初始化所有后面事件将要执行的命令
- (void)initialize{
    @weakify(self);
    self.attitudeOperationCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber * input) {
        @strongify(self);
        // 处理点赞
        if (self.moment.attitudesStatus<=0) {
            // 未点赞
            self.moment.attitudesStatus = 1;
            self.moment.attitudesCount = self.moment.attitudesCount+1;
            [self.moment.attitudesList addObject:[UserModelManager sharedInstance].currentUser];
        }else{
            // 已点赞，则取消点赞
            self.moment.attitudesStatus = 0;
            self.moment.attitudesCount = self.moment.attitudesCount-1;
            if (self.moment.attitudesCount<0) self.moment.attitudesCount=0;
            [self.moment.attitudesList removeObject:[UserModelManager sharedInstance].currentUser];
        }

        if (self.moment.attitudesList.count>0) {
            // 有数据
            LikeItemViewModel * attitudes = self.dataSource.firstObject;
            if ([attitudes isKindOfClass:[LikeItemViewModel class]]) {
                // 修改数据 （移除/拼接）
                [attitudes.operationCmd execute:self.moment];
            }else{
                // 插入数据到 index = 0 （创建数据）
                LikeItemViewModel *atti = [[LikeItemViewModel alloc] initWithMoment:self.moment];
                atti.attributedTapCommand = self.attributedTapCommand;
                [self.dataSource insertObject:atti atIndex:0];
            }
        }else{
            // 这里没有点赞用户，删除掉第一个，
            [self.dataSource removeFirstObject];
        }
        // 更新布局 向上的箭头
        [self _updateUpArrowViewFrameForOperationMoreChanged];
        // 回调到视图控制器，刷新表格的section，这里特别注意的是：微信这里不论有网，没网，你点赞Or取消点赞都是可以操作的，所以以上都是前端处理
        [self.reloadSectionSubject sendNext:input];
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

            return nil;
        }];
    }];
    
    self.attitudeOperationCmd.allowsConcurrentExecution = YES;
    // 用户点击展开全文
    self.expandOperationCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber * input) {
        @strongify(self);
        self.expand = !self.isExpand;
        // 更新所有布局
        [self _updateSubviewsFrameWithExpand:self.isExpand];
        // 回调控制器
        [self.reloadSectionSubject sendNext:input];
        return [RACSignal empty];
    }];
    self.expandOperationCmd.allowsConcurrentExecution = YES;
}

/**
 更新内部控件尺寸模型 （点击全文or收起）
 @param expand 全文/收起
 */
- (void)_updateSubviewsFrameWithExpand:(BOOL)expand{
    self.expand = expand;
    
    CGFloat limitWidth = MHMomentCommentViewWidth();
    
    // 正文
    CGFloat contentLableX = self.screenNameLableFrame.origin.x;
    CGFloat contentLableY = CGRectGetMaxY(self.screenNameLableFrame)+MHMomentContentInnerMargin-4;
    CGSize contentLableSize = CGSizeZero;
    // 全文/收起按钮
    CGFloat expandBtnX = contentLableX;
    CGFloat expandBtnY = contentLableY;
    CGFloat expandBtnW = MHMomentExpandButtonWidth;
    CGFloat expandBtnH = 0;
    
    // 这里要分情况
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(limitWidth, MAXFLOAT)];
    YYTextLayout *layout = nil;
    if ([NSString stringIsNotEmpty:self.moment.content]) {
        // 显示部分正文 （按钮显示 `全文`）(默认是全部显示)
        contentLableSize = self.contentLableLayout.textBoundingSize;
        if (self.contentLableLayout.rowCount > MHMomentContentTextMaxCriticalRow) {
            // 容错
            self.expand = NO;
            // 就显示单行
            container.maximumNumberOfRows = 1;
            layout = [YYTextLayout layoutWithContainer:container text:self.contentLableLayout.text];
            // 全文/收起 高度为0
            expandBtnH = .0f;
        }else if(self.contentLableLayout.rowCount > MHMomentContentTextExpandCriticalRow){
            // 重新计算
            if(!expand){
                // 点击收起 -- 显示全文
                container.maximumNumberOfRows = MHMomentContentTextExpandCriticalRow;
                layout = [YYTextLayout layoutWithContainer:container text:self.contentLableLayout.text];
                contentLableSize = layout.textBoundingSize;
            }
            expandBtnH = MHMomentExpandButtonHeight;
        }
        expandBtnY = contentLableY + contentLableSize.height +MHMomentContentInnerMargin;
    }

    // 正文
    self.contentLableFrame = CGRectMake(contentLableX, contentLableY, contentLableSize.width, contentLableSize.height);
    // 全文/收起
    self.expandBtnFrame = CGRectMake(expandBtnX, expandBtnY, expandBtnW, expandBtnH);

    CGFloat pictureViewX = contentLableX;
    CGFloat pictureViewTopMargin = (expandBtnH>0)?MHMomentContentInnerMargin:0;
    CGFloat pictureViewY = CGRectGetMaxY(self.expandBtnFrame)+pictureViewTopMargin;
    CGSize pictureViewSize = [self _pictureViewSizeWithPhotosCount:self.moment.images.count];
    
    self.photosViewFrame = (CGRect){{pictureViewX , pictureViewY},pictureViewSize};
    
    CGFloat locationLableX = contentLableX;
    CGFloat locationLabelTopMargin = (pictureViewSize.height>0)?MHMomentContentInnerMargin:0;
    // 计算高度
    CGFloat locationLableTempMaxY = MAX(CGRectGetMaxY(self.photosViewFrame), CGRectGetMaxY(self.shareInfoViewFrame));
    CGFloat locationLableY = MAX(locationLableTempMaxY, CGRectGetMaxY(self.videoViewFrame))+locationLabelTopMargin;
    self.locationLableFrame = CGRectMake(locationLableX, locationLableY, self.locationLableLayout.textBoundingSize.width, self.locationLableLayout.textBoundingSize.height);
    
    // 更多按钮
    CGFloat operationMoreBtnX = MY_SCREEN_WIDTH - MHMomentContentLeftOrRightInset - MHMomentOperationMoreBtnWH +(MHMomentOperationMoreBtnWH - 25)*.5f;
    CGFloat operationMoreBtnTopMargin = (self.locationLableFrame.size.height>0)?(MHMomentContentInnerMargin-5):0;
    CGFloat operationMoreBtnY = CGRectGetMaxY(self.locationLableFrame)+operationMoreBtnTopMargin;
    CGFloat operationMoreBtnW = MHMomentOperationMoreBtnWH;
    CGFloat operationMoreBtnH = MHMomentOperationMoreBtnWH;
    self.operationMoreBtnFrame = CGRectMake(operationMoreBtnX, operationMoreBtnY, operationMoreBtnW, operationMoreBtnH);

    // 评论or点赞 向上箭头
    [self _updateUpArrowViewFrameForOperationMoreChanged];
}

- (void)updateUpArrow{
    [self _updateUpArrowViewFrameForOperationMoreChanged];
}

// 由于更多按钮的事件生效
- (void)_updateUpArrowViewFrameForOperationMoreChanged
{
    BOOL isAllowShowUpArrowView = (self.moment.comments.count>0||self.moment.attitudesList.count>0);
    
    CGFloat upArrowViewX = self.screenNameLableFrame.origin.x;
    // -5是为了适配
    CGFloat upArrowViewTopMargin = isAllowShowUpArrowView?(MHMomentContentInnerMargin-5):0;
    CGFloat upArrowViewY = CGRectGetMaxY(self.operationMoreBtnFrame)+upArrowViewTopMargin;
    CGFloat upArrowViewW = MHMomentUpArrowViewWidth;
    CGFloat upArrowViewH = isAllowShowUpArrowView?MHMomentUpArrowViewHeight:0;
    self.upArrowViewFrame = CGRectMake(upArrowViewX, upArrowViewY, upArrowViewW, upArrowViewH);
    
    // 整个header的高度
    self.height = CGRectGetMaxY(self.upArrowViewFrame);
}

// pictureView的整体size
- (CGSize)_pictureViewSizeWithPhotosCount:(NSUInteger)photosCount{
    // 0张图 CGSizeZero
    if (photosCount==0) return CGSizeZero;
    CGFloat pictureViewItemWH = MHMomentPhotosViewItemWidth();
    
    // 这里需要考虑一张图片等比显示的情况
    if(photosCount==1){
        CGSize picSize = CGSizeZero;
        CGFloat maxWidth  = MHMomentPhotosViewSingleItemMaxWidth();
        CGFloat maxHeight = MHMomentPhotosViewSingleItemMaxHeight;
        ImagesModel *pic  = self.moment.images.firstObject;
        PictureMetadata *bmiddle = pic.bmiddle;
        
        if (pic.keepSize || bmiddle.width < 1 || bmiddle.height < 1) {
            // 固定方形
            picSize = CGSizeMake(maxWidth, maxWidth);
        } else {
            // 等比显示
            if (bmiddle.width < bmiddle.height) {
                picSize.width = (float)bmiddle.width / (float)bmiddle.height * maxHeight;
                picSize.height = maxHeight;
            } else {
                picSize.width = maxWidth;
                picSize.height = (float)bmiddle.height / (float)bmiddle.width * maxWidth;
            }
        }
        return picSize;
    }
    // 大于1的情况 统统显示 九宫格样式
    NSUInteger maxCols = MHMomentMaxCols(photosCount);
    NSUInteger totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    // 总行数
    NSUInteger totalRows = (photosCount + maxCols - 1) / maxCols;
    CGFloat photosW = totalCols * pictureViewItemWH + (totalCols - 1) * MHMomentPhotosViewItemInnerMargin;
    CGFloat photosH = totalRows * pictureViewItemWH + (totalRows - 1) * MHMomentPhotosViewItemInnerMargin;
    return CGSizeMake(photosW, photosH);
}

#pragma mark - Getter & Setter
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)setAttributedTapCommand:(RACCommand *)attributedTapCommand{
    _attributedTapCommand = attributedTapCommand;
    
    // 遍历数据源 dataSource
    for (CommentLikeContentModel *itemViewModel in self.dataSource) {
        itemViewModel.attributedTapCommand = attributedTapCommand;
    }
}

@end

