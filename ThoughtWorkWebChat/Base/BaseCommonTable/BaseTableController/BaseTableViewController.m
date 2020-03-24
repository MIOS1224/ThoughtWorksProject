//
//  BaseTableViewController.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/20.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "BaseTableViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface BaseTableViewController ()

@property (nonatomic,weak)   BaseTableView *tableView;
//内容缩进
@property (nonatomic,assign) UIEdgeInsets contentInset;
@property (nonatomic,readonly,strong) BaseTableViewModel *viewModel;

@end

@implementation BaseTableViewController
@dynamic viewModel;

- (instancetype)initWithViewModel:(BaseTableViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
       @weakify(self)
        [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
            @strongify(self)
            // 请求数据
            [self.viewModel.requestRemoteDataCommand execute:@1];
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置子控件
    [self setupSubViews];
}

// override
- (void)bindViewModel
{
    [super bindViewModel];
    @weakify(self)
    [[RACObserve(self.viewModel, dataSource) deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        [self reloadData];
    }];
}

#pragma mark - 设置子控件
- (void)setupSubViews{
    BaseTableView *tableView = [[BaseTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:self.viewModel.style];
    tableView.backgroundColor = MyColorFromHexString(@"#EFEFF4");
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset  = self.contentInset;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
   
    if (self.viewModel.shouldPullDownToRefresh) {
        // 下拉刷新
        @weakify(self);
        MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
             @strongify(self);
            [self tableViewDidTriggerHeaderRefresh];
        }];
        mj_header.lastUpdatedTimeLabel.hidden = YES;
        self.tableView.mj_header  = mj_header;
        [self.tableView.mj_header beginRefreshing];
    }
    
    if (self.viewModel.shouldPullUpToLoadMore) {
        // 上拉加载
        @weakify(self);
        MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self tableViewDidTriggerFooterRefresh];
        }];
        [mj_footer setTitle:@"人家是有底线的哦..." forState:MJRefreshStateNoMoreData];
        self.tableView.mj_footer = mj_footer;
        
        //是否 隐藏footer
        RAC(self.tableView.mj_footer, hidden) = [[RACObserve(self.viewModel, dataSource) deliverOnMainThread] map:^(NSArray *dataSource) {
            @strongify(self)
            NSUInteger count = dataSource.count;
            //无数据，默认隐藏mj_footer
            if (count == 0) return @1;
            if (self.viewModel.shouldEndRefreshingWithNoMoreData) return @(0);
            return @1;
        }];
    }

    if (@available(iOS 11.0, *)) {
        MYAdjustsScrollViewInsets_Never(tableView);
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
}

#pragma mark - 上下拉刷新事件
- (void)tableViewDidTriggerHeaderRefresh{
    @weakify(self)
    [[[self.viewModel.requestRemoteDataCommand execute:@1] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        self.viewModel.page = 1;
        //重置没有更多的状态
        if (self.viewModel.shouldEndRefreshingWithNoMoreData) [self.tableView.mj_footer resetNoMoreData];
    } error:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
    } completed:^{
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        //请求完成
        [self requestDataCompleted];
    }];
}

//上拉事件
- (void)tableViewDidTriggerFooterRefresh{
    @weakify(self);
    [[[self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.page + 1)] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        self.viewModel.page += 1;
    } error:^(NSError *error) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
    } completed:^{
        @strongify(self)
        [self.tableView.mj_footer endRefreshing];
        //请求完成
        [self requestDataCompleted];
    }];
}

#pragma mark - sub class can override it
- (void)reloadData{
    [self.tableView reloadData];
}

// register cell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

// configure cell
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - 辅助方法
- (void)requestDataCompleted{
    NSUInteger count = self.viewModel.dataSource.count;
    if (self.viewModel.shouldEndRefreshingWithNoMoreData && count%self.viewModel.pageSize)
    {
     [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.viewModel.shouldMultiSections) return self.viewModel.dataSource ? self.viewModel.dataSource.count : 0;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel.shouldMultiSections) return [self.viewModel.dataSource[section] count];
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    id object = nil;
    if (self.viewModel.shouldMultiSections) object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if (!self.viewModel.shouldMultiSections) object = self.viewModel.dataSource[indexPath.row];
    ///!  绑定数据
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectCommand execute:indexPath];
}

- (void)dealloc
{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

@end
