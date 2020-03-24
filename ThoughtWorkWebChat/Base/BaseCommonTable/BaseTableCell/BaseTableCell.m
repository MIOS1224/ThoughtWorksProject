//
//  BaseTableCell.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//  默认 图片 内容 箭头


#import "BaseTableCell.h"
#import "BaseItemViewModel.h"

@interface BaseTableCell ()

// 三条分割线
@property (nonatomic, readwrite, strong) UIImageView * topLine;
@property (nonatomic, readwrite, strong) UIImageView * bottomLine;
@property (nonatomic, readwrite, strong) UIImageView * rightArrow; // 箭头
@property (nonatomic, readwrite, strong) UIImageView * avatarView; // avatar 头像

@property (nonatomic, readwrite, strong) UILabel * contentLabel; // 中间内容
@property (nonatomic, readwrite, strong) BaseItemViewModel * viewModel;

@end


@implementation BaseTableCell

#pragma mark - 公共方法
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    return [self cellWithTableView:tableView style:UITableViewCellStyleValue1];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"BaseTableCell";
    BaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 私有方法
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        // 创建自控制器
        [self setupSubViews];
        
        // 布局子控件
        [self layoutSubviews];
    }
    return self;
}

#pragma mark - 创建自控制器
- (void)setupSubViews{
    
    // 分割线
    self.topLine    = [[UIImageView alloc] init];
    self.bottomLine = [[UIImageView alloc] init];
    self.avatarView = [[UIImageView alloc] init];
    
    self.topLine.backgroundColor    = MyColorFromHexString(@"#D9D8D9");
    self.bottomLine.backgroundColor = MyColorFromHexString(@"#D9D8D9");
    // 内容
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = MyFontRegular_14;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.textColor = MyColorFromHexString(@"#888888");
    
    [self addSubview: self.topLine];
    [self addSubview:self.bottomLine];
    
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.contentLabel];
}


#pragma mark - 布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo([NSNumber numberWithFloat:MYGlobalBottomLineHeight]);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.topLine.mas_width);
        make.height.mas_equalTo(self.topLine.mas_height);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-MYGlobalBottomLineHeight);
    }];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30.0);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.avatarView.mas_centerY);
        
    }];
}

#pragma mark - 事件处理
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSInteger)rows{
    self.topLine.hidden    = NO;
    self.bottomLine.hidden = NO;
}

- (void)bindViewModel:(BaseItemViewModel *)viewModel{
    self.accessoryView  = self.rightArrow;
    self.selectionStyle = viewModel.selectionStyle;
    
    self.viewModel = viewModel;
    self.contentLabel.text = viewModel.title;
    self.avatarView.image  = [UIImage imageNamed:viewModel.icon];}

#pragma mark - lazy
- (UIImageView *)rightArrow{
    if (_rightArrow == nil) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_arrow"]];
    }
    return _rightArrow;
}


@end

