//
//  FriendShipController.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "FriendShipController.h"
#import "AppDelegate.h"
#import "LCActionSheet.h"
#import "FriendShipCell.h"
#import "CommentToolView.h"
#import "LikeItemViewModel.h"
#import "CommentHeaderView.h"
#import "FriendItemViewModel.h"
#import "FriendShipHeaderView.h"
#import "FriendShipFooterView.h"
#import "CommentItemViewModel.h"
#import "UIBarButtonItem+Extension.h"
#import "CommentReplyItemViewModel.h"
#import "UINavigationBar+Extension.h"

@interface FriendShipController ()

@property (nonatomic, weak)  CommentHeaderView *tableHeaderView;  // headerView
@property (nonatomic, weak)  CommentToolView *commentToolView;    // commentView
@property (nonatomic, strong) FriendShipViewModel *viewModel;

@property (nonatomic, assign) CGFloat keyboardHeight; //键盘高度
@property (nonatomic, strong) NSIndexPath * selectedIndexPath;   // 选中的索引

@end

@implementation FriendShipController
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控件
    [self _setupSubViews];
    // 导航栏配置-无头
    [self setupNavigationItem];
}
#pragma mark - Override
- (UIEdgeInsets)contentInset{
    return UIEdgeInsetsMake((MY_IS_IPHONE_X || MY_IS_IPHONE_XPro)?-40:-64, 0, 0, 0);
}

#pragma mark - 初始化子控件
- (void)_setupSubViews{
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.sectionFooterHeight =  MHMomentFooterViewHeight;
    
    // header view
    CommentHeaderView *tableHeaderView = [[CommentHeaderView alloc] init];
    [tableHeaderView bindViewModel:self.viewModel.profileViewModel];
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.tableHeaderView.frameHeight = self.viewModel.profileViewModel.height;
    self.tableHeaderView = tableHeaderView;

    //下拉背景图
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:MY_SCREEN_BOUNDS];
    backgroundView.frameSize = MY_SCREEN_BOUNDS.size;
    backgroundView.image = [UIImage imageNamed:@"friends_bg"];
    backgroundView.frameY = -backgroundView.frameHeight;
    [self.tableView addSubview:backgroundView];
    
    // 添加评论View
    CommentToolView *commentToolView = [[CommentToolView alloc] init];
    self.commentToolView = commentToolView;
    [self.view addSubview:commentToolView];
    [commentToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(60);
        make.bottom.equalTo(self.view).with.offset(60);
    }];
}

- (void)bindViewModel{
    [super bindViewModel];
    @weakify(self);
    // 全文/收起
    [[self.viewModel.reloadSectionSubject deliverOnMainThread] subscribeNext:^(NSNumber * section) {
        @strongify(self);
        // 局部刷新
        [UIView performWithoutAnimation:^{
            [self.tableView reloadSection:section.integerValue withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }];
    
    // 评论
    [[self.viewModel.commentSubject deliverOnMainThread] subscribeNext:^(NSNumber * section) {
        @strongify(self);
        // 记录选中的Section 这里设置Row为-1 以此来做判断
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:-1 inSection:section.integerValue];
        // 显示评论
        [self _commentOrReplyWithItemViewModel:self.viewModel.dataSource[section.integerValue] indexPath:indexPath];
    }];
    
    // 监听键盘 高度
    [[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] takeUntil:self.rac_willDeallocSignal ] deliverOnMainThread] subscribeNext:^(NSNotification * notification) {
         @strongify(self);
         @weakify(self);
         [self convertNotification:notification completion:^(CGFloat duration, UIViewAnimationOptions options, CGFloat keyboardH) {
             @strongify(self);
             if (keyboardH <= 0) {
                 keyboardH = -1 * self.commentToolView.frameHeight;
             }
             self.keyboardHeight = keyboardH;
        
             AppDelegate.sharedDelegate.showKeyboard = (keyboardH > 0);
             // bottomToolBar距离底部的高
             [self.commentToolView mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.bottom.equalTo(self.view).with.offset(-1 *keyboardH);
             }];
             // 执行动画
             [UIView animateWithDuration:duration delay:0.0f options:options animations:^{
                 [self.view layoutSubviews];
                 // 滚动表格
                 [self _scrollTheTableViewForComment];
             } completion:nil];
         }];
     }];
    
    
    // 监听commentToolView的高度变化
    [[RACObserve(self.commentToolView, toHeight) distinctUntilChanged] subscribeNext:^(NSNumber * toHeight) {
        @strongify(self);
        if (toHeight.floatValue < MHMomentCommentToolViewMinHeight) return ;
        // 更新的高度
        [self.commentToolView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(toHeight);
        }];
        [UIView animateWithDuration:.25f animations:^{
            // 适当时候更新布局
            [self.view layoutSubviews];
            // 滚动表格
            [self _scrollTheTableViewForComment];
        }];
    }];
}

#pragma mark -overdide
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [FriendShipCell cellWithTableView:tableView];
}

- (void)configureCell:(FriendShipCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    FriendItemViewModel *itemViewModel =  self.viewModel.dataSource[indexPath.section];
    id model = itemViewModel.dataSource[indexPath.row];
    [cell bindViewModel:model];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FriendItemViewModel *itemViewModel =  self.viewModel.dataSource[section];
    return itemViewModel.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendItemViewModel *itemViewModel =  self.viewModel.dataSource[indexPath.section];
    id model = itemViewModel.dataSource[indexPath.row];
    return [model cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];

    FriendItemViewModel *itemViewModel = self.viewModel.dataSource[indexPath.section];
    id object = itemViewModel.dataSource[indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}

// 设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    FriendItemViewModel *itemViewModel = self.viewModel.dataSource[section];
    return itemViewModel.height;
}

//header view
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FriendShipHeaderView *headerView = [FriendShipHeaderView headerViewWithTableView:tableView];
    headerView.section = section;
    [headerView bindViewModel:self.viewModel.dataSource[section]];
    return headerView;
}

//  footer view
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [FriendShipFooterView footerViewWithTableView:tableView];
}


// 点击Cell的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    // 先取出该section的说说
    FriendItemViewModel *itemViweModel = self.viewModel.dataSource[section];
    CommentLikeContentModel *contentItemViewModel = itemViweModel.dataSource[row];
    // 去掉点赞
    if ([contentItemViewModel isKindOfClass:LikeItemViewModel.class]) {
        [self.commentToolView resignFirstResponder];
        return;
    }

    // 判断是否是自己的评论  或者 回复
    CommentItemViewModel *commentItemViewModel = (CommentItemViewModel *)contentItemViewModel;
    if ([commentItemViewModel.comment.sender.username isEqualToString: [UserModelManager sharedInstance].currentUser.username]) {
        // 关掉键盘
        [self.commentToolView  resignFirstResponder];
        // 自己评论的活回复他人
        @weakify(self);
        LCActionSheet *sheet = [LCActionSheet sheetWithTitle:nil cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
            if (buttonIndex == 0) return ;
            @strongify(self);
            // 删除数据源
            [self.viewModel.delCommentCommand execute:indexPath];
    
        } otherButtonTitles:@"删除", nil];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
        sheet.destructiveButtonIndexSet = indexSet;
        [sheet show];
        return;
    }
    
    // 键盘已经显示 你就先关掉键盘
    if (MySharedAppDelegate.isShowKeyboard) {
        [self.commentToolView resignFirstResponder];
        return;
    }
    // 评论
    [self _commentOrReplyWithItemViewModel:contentItemViewModel indexPath:indexPath];
}



#pragma mark - 辅助方法
- (void)_commentOrReplyWithItemViewModel:(id)itemViewModel indexPath:(NSIndexPath *)indexPath{
    // 传递数据
    CommentReplyItemViewModel *viewModel = [[CommentReplyItemViewModel alloc] initWithItemViewModel:itemViewModel];
    viewModel.section = indexPath.section;
    viewModel.commentCommand = self.viewModel.commentCommand;
    // 记录indexPath
    self.selectedIndexPath = indexPath;
    [self.commentToolView bindViewModel:viewModel];
    // 键盘弹起
    [self.commentToolView  becomeFirstResponder];
}

// 评论的时候 滚动tableView
- (void)_scrollTheTableViewForComment{
    CGRect rect = CGRectZero;
    CGRect rectTemp = CGRectZero;
    if (self.selectedIndexPath.row == -1) {
        // 获取整个尾部section对应的尺寸 获取的rect是相当于tableView的尺寸
        rect = [self.tableView rectForFooterInSection:self.selectedIndexPath.section];
        // 将尺寸转化到window的坐标系 （关键点）
        rectTemp = [self.tableView convertRect:rect toViewOrWindow:nil];
    }else{
        // 回复
        // 获取整个尾部section对应的尺寸 获取的rect是相当于tableView的尺寸
        rect = [self.tableView rectForRowAtIndexPath:self.selectedIndexPath];
        // 将尺寸转化到window的坐标系 （关键点）
        rectTemp = [self.tableView convertRect:rect toViewOrWindow:nil];
    }
    
    if (self.keyboardHeight > 0) {
        // 滚动差值
        CGFloat delta = self.commentToolView.frameTop - rectTemp.origin.y - rectTemp.size.height;
        [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y-delta) animated:NO];
    }else{
        // 如果处于最后一个，需要滚动到底部
        if(self.selectedIndexPath.section == self.viewModel.dataSource.count-1){
            // 去掉抖动
            [UIView performWithoutAnimation:^{
                [self.tableView scrollToBottomAnimated:NO];
            }];
        }
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [MomentHelper hideAllPopViewWithAnimated:NO];
}

// 导航栏滑动处理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    UIColor * color = MY_MAIN_BACKGROUNDCOLOR;
    CGFloat height  = MY_TABLEHEADERHEIGHT - 70; //滑动位置
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > height ) {
        [self setupNavigationItemScroModel];
        CGFloat alpha = MIN(1, 1 - ((height + MY_APPLICATION_TOP_BAR_HEIGHT - offsetY) / MY_APPLICATION_TOP_BAR_HEIGHT));
        [self.navigationController.navigationBar yt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self setupNavigationItem];
        [self.navigationController.navigationBar yt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

#pragma mark - 初始化道导航栏
- (void)setupNavigationItem{
    self.viewModel.title = @"";
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem systemItemWithImageName:@"store_return_white" target:self selector:@selector(popViewController)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem systemItemWithImageName:@"icon_Camera" target:self selector:@selector(showActionSheet)];
}

#pragma mark - 滑动是导航栏变化
- (void)setupNavigationItemScroModel
{
    self.viewModel.title = @"朋友圈";
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem systemItemWithImageName:@"ic_navi_back_black" target:self selector:@selector(popViewController)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem systemItemWithImageName:@"camera" target:self selector:@selector(showActionSheet)];
}

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showActionSheet
{
    LCActionSheet *sheet = [LCActionSheet sheetWithTitle:nil cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
        if (buttonIndex == 0) return ;
    } otherButtonTitles:@"拍摄",@"从手机相册选择", nil];
    [sheet show];

}

@end
