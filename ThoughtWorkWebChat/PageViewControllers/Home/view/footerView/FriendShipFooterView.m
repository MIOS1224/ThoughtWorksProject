//
//  FriendShipFooterView.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/22.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "FriendShipFooterView.h"

@interface FriendShipFooterView ()

@property (nonatomic, readwrite, weak) UIImageView *divider; //分割线

@end

@implementation FriendShipFooterView

+ (instancetype)footerViewWithTableView:(UITableView *)tableView{
    static NSString *ID = @"FriendShipFooterView";
    FriendShipFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (footer == nil) {
        footer = [[self alloc] initWithReuseIdentifier:ID];
    }
    return footer;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self _setupSubViews];
    }
    return self;
}

- (void)_setupSubViews
{
    UIImageView *divider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wx_albumCommentHorizontalLine_33x1"]];
    divider.backgroundColor = MyColorFromHexString(@"#D9D8D9");
    self.divider = divider;
    [self.contentView addSubview:divider];
    
    [self.divider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.and.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
}

@end

