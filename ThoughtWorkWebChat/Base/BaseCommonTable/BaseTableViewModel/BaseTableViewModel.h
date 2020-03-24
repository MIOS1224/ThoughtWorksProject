//
//  BaseTableViewModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/20.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewModel : BaseViewModel

@property (nonatomic,copy)   NSArray *dataSource;  // 数据源
@property (nonatomic,assign) UITableViewStyle style;  //defalut UITableViewStylePlain
@property (nonatomic,assign) BOOL shouldPullDownToRefresh; // 下来刷新
@property (nonatomic,assign) BOOL shouldPullUpToLoadMore; // 上拉加载
@property (nonatomic,assign) BOOL shouldMultiSections; // 多section
@property (nonatomic,assign) BOOL shouldEndRefreshingWithNoMoreData; // 是否隐藏mj_footer

@property (nonatomic,assign) NSUInteger page; // 页数1
@property (nonatomic,assign) NSUInteger pageSize;

@property (nonatomic,strong) RACCommand *didSelectCommand; // 选中命令
@property (nonatomic, readonly, strong) RACCommand *requestRemoteDataCommand; // 请求数据命令


// 请求错误信息过滤
- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter;
// 当前页之前的所有数据
- (NSUInteger)offsetForPage:(NSUInteger)page;
 // page - 请求第几页的数据
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;

@end

NS_ASSUME_NONNULL_END
