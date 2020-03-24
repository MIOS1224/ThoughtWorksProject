//
//  LikeItemViewModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "LikeItemViewModel.h"
#import "UserModelManager.h"

@interface LikeItemViewModel ()

@property (nonatomic,strong) FriendModel *moment;
@property (nonatomic,strong) RACCommand *operationCmd;
@property (nonatomic,strong) YYTextContainer *container;
@property (nonatomic,strong) NSMutableAttributedString *attitudesAttr;

@end

@implementation LikeItemViewModel

- (instancetype)initWithMoment:(FriendModel *)moment
{
    if (self = [super init]) {
        
        self.moment = moment;
        self.type = CommentLikeContentTypeLike;
        
        UIFont *font = MyFontRegular(14);
        //昵称
        for (UserModel *user in self.moment.attitudesList) {
            NSMutableAttributedString *screenNameAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@，",user.username]];
            screenNameAttr.yy_color = [UIColor blackColor];
            screenNameAttr.yy_font = font;
            // 设置昵称高亮
            NSRange range = NSMakeRange(0, user.username.length);
            [screenNameAttr yy_setColor:MyColorFromHexString(@"#5B6A92") range:range];
            [screenNameAttr yy_setFont:font range:range];
            
            // 点击的高亮的
            YYTextBorder *border = [YYTextBorder new];
            border.cornerRadius = 0;
            border.insets = UIEdgeInsetsMake(0, -1, 0, -1);
            border.fillColor = MyColorFromHexString(@"#C7C7C7");
            // 点击高亮
            YYTextHighlight *highlight = [YYTextHighlight new];
            // 将用户数据带出去
            highlight.userInfo = @{MHMomentUserInfoKey:user};
            [highlight setBackgroundBorder:border];
            [screenNameAttr yy_setTextHighlight:highlight range:range];
            
            // 拼接
            [self.attitudesAttr appendAttributedString:screenNameAttr];
        }
        
        // 去掉最后一个 ，
        [self.attitudesAttr deleteCharactersInRange:NSMakeRange(self.attitudesAttr.length-1, 1)];
        
        // 统一配置
        self.attitudesAttr.yy_lineBreakMode = NSLineBreakByCharWrapping;
        self.attitudesAttr.yy_alignment = NSTextAlignmentLeft;
        
        // 文本布局
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:self.container text:self.attitudesAttr.copy];
        self.contentLableLayout = layout;
        self.contentLableFrame = CGRectMake(9, 7, layout.textBoundingSize.width, layout.textBoundingSize.height);
        self.cellHeight = layout.textBoundingSize.height + 2*7;

        // 初始化
        [self initialize];
    }
    
    return self;
}


- (void)initialize
{
    // 更行布局的属性
    @weakify(self);
    self.operationCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(FriendModel * input) {
        @strongify(self);
        BOOL isAppend = input.attitudesStatus>0;
        // 拼接一个，目的是为了后面 删除和添加
        [self.attitudesAttr yy_appendString:@"，"];
        // 需要拼接或删除的用户
        UserModel *user = [UserModelManager sharedInstance].currentUser;
        
        if (isAppend) {
            // 拼接 “吴亦凡”
            NSMutableAttributedString *screenNameAttr = [[NSMutableAttributedString alloc] initWithString:user.username];
            screenNameAttr.yy_color = MyColorFromHexString(@"#5B6A92");
            screenNameAttr.yy_font = MyFontRegular(14);
            // 点击的高亮的
            YYTextBorder *border = [YYTextBorder new];
            border.cornerRadius = 0;
            border.insets = UIEdgeInsetsMake(0, -1, 0, -1);
            border.fillColor = MyColorFromHexString(@"#C7C7C7");
            // 点击高亮
            YYTextHighlight *highlight = [YYTextHighlight new];
            // 将用户数据带出去
            highlight.userInfo = @{MHMomentUserInfoKey:user};
            [highlight setBackgroundBorder:border];
            [screenNameAttr yy_setTextHighlight:highlight range:screenNameAttr.yy_rangeOfAll];
            [self.attitudesAttr appendAttributedString:screenNameAttr];
        }else{
            NSString *screenName = [NSString stringWithFormat:@"%@，",user.username];
            NSRange range = [self.attitudesAttr.string rangeOfString:screenName];
            if (range.location != NSNotFound){
                [self.attitudesAttr deleteCharactersInRange:range];
            }
            
            // 去掉最后一个 ，
            [self.attitudesAttr deleteCharactersInRange:NSMakeRange(self.attitudesAttr.length-1, 1)];
            
        }
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:self.container text:self.attitudesAttr.copy];
        self.contentLableLayout = layout;
        self.contentLableFrame = CGRectMake(9, 7, layout.textBoundingSize.width, layout.textBoundingSize.height);
        self.cellHeight = layout.textBoundingSize.height + 2*7;
        return [RACSignal empty];
    }];
    
    self.operationCmd.allowsConcurrentExecution = YES;
}

#pragma mark - Getter
- (YYTextContainer *)container
{
    if (_container == nil) {
        CGFloat limitWidth = MHMomentCommentViewWidth()-2*9;
        _container = [YYTextContainer containerWithSize:CGSizeMake(limitWidth, MAXFLOAT)];
        _container.maximumNumberOfRows = 0;
    }
    return _container;
}

- (NSMutableAttributedString *)attitudesAttr
{
    if (_attitudesAttr == nil) {
        _attitudesAttr = [[NSMutableAttributedString alloc] init];
        UIFont *font = MyFontRegular(14);
        // 爱心
        UIImage *likeImage = [UIImage imageNamed:@"wx_albumLikeHL_20x20"];
        likeImage = [UIImage imageWithCGImage:likeImage.CGImage scale:[UIScreen screenScale] orientation:UIImageOrientationUp];
        
        NSMutableAttributedString *attachLikeText = [NSMutableAttributedString yy_attachmentStringWithContent:likeImage contentMode:UIViewContentModeCenter attachmentSize:likeImage.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [self.attitudesAttr appendAttributedString:attachLikeText];
        // 拼接一个空格
        NSMutableAttributedString *marginAttr = [[NSMutableAttributedString alloc] initWithString:@"  "];
        [self.attitudesAttr appendAttributedString:marginAttr];
    }
    return _attitudesAttr;
}

@end

