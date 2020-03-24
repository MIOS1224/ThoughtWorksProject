//
//  UserInfoViewModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "UserInfoViewModel.h"

@interface UserInfoViewModel ()

@property (nonatomic,strong) UserModel *user;
@property (nonatomic,copy) NSAttributedString *screenNameAttr;


@end

@implementation UserInfoViewModel

- (instancetype)initWithUser:(UserModel *)user
{
    if (self = [super init]) {
        if (user) {
            self.user = user;
            if (user.username) {
                /// 设置昵称的外部阴影
                NSMutableAttributedString *screenNameAttr = [[NSMutableAttributedString alloc] initWithString:user.username];
                screenNameAttr.yy_alignment = NSTextAlignmentRight;
                screenNameAttr.yy_font = MyFontMedium(20.0f);
                screenNameAttr.yy_color = [UIColor whiteColor];
                
                YYTextShadow *textShadow = [YYTextShadow new];
                textShadow.color = MyColorFromHexString(@"#212227");
                textShadow.offset = CGSizeMake(1, 2);
                textShadow.radius = 2;
                screenNameAttr.yy_textShadow = textShadow;
                self.screenNameAttr = screenNameAttr;
            }
        }
    }
    return self;
}

- (CGFloat)height
{
    if (self.unread>0) {
        return (MY_TABLEHEADERHEIGHT + 100);
    }
    return (MY_TABLEHEADERHEIGHT + 30);
}



@end
