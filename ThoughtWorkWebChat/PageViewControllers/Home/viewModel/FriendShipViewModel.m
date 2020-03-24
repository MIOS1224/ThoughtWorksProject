//
//  FriendShipViewModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "FriendShipViewModel.h"
#import "CommentModel.h"
#import "SLMessageHUD.h"
#import "FriendDataModel.h"
#import "FriendItemViewModel.h"
#import "FriendItemViewModel.h"
#import "CommentItemViewModel.h"
#import "CommentReplyItemViewModel.h"


@interface FriendShipViewModel ()

@property (nonatomic,strong) RACSubject *phoneSubject;   // 电话号码回调
@property (nonatomic,strong) RACSubject *commentSubject; // 评论回调
@property (nonatomic,strong) RACSubject *reloadSectionSubject; // 刷新某一个section的 事件回调

@property (nonatomic,strong) UserInfoViewModel *profileViewModel;  // 个人信息头部视图模型

@property (nonatomic,strong) RACCommand *commentCommand;    // 发送评论内容
@property (nonatomic,strong) RACCommand *delCommentCommand; // 删除当前用户的评论
@property (nonatomic,strong) RACCommand *delMomentCommand;  // 删除当前用户的发的说说
@property (nonatomic,strong) RACCommand *attributedTapCommand; // 富文本文字上的事件处理

@property (nonatomic,strong) RACCommand *profileInfoCommand;  // 跳转用户

@end

@implementation FriendShipViewModel

- (void)initialize{
    [super initialize];
    
    self.pageSize = 5;
    self.shouldPullDownToRefresh = YES;
    self.shouldPullUpToLoadMore = YES;
    // 允许多段显示
    self.shouldMultiSections = YES;
    self.shouldEndRefreshingWithNoMoreData = YES;
    self.style = UITableViewStyleGrouped;
    
    //事件初始化
    self.phoneSubject = [RACSubject subject];
    self.commentSubject = [RACSubject subject];
    self.reloadSectionSubject = [RACSubject subject];
    
    self.profileViewModel = [[UserInfoViewModel alloc] initWithUser:[UserModelManager sharedInstance].currentUser];
    
    @weakify(self);
    // 评论
    self.commentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(CommentReplyItemViewModel * itemViewModel) {
        @strongify(self);
        // 配置评论内容
        CommentModel *comment = [[CommentModel alloc] init];
        comment.content = itemViewModel.text;
        //        comment.momentIdstr = itemViewModel.momentIdstr;
        comment.sender = [UserModelManager sharedInstance].currentUser;
        comment.toUser = itemViewModel.toUser;
        
        CommentItemViewModel *commentItemViewModel = [[CommentItemViewModel alloc] initWithComment:comment];
        commentItemViewModel.attributedTapCommand = self.attributedTapCommand;
        
        // 根据section 获取数据
        FriendItemViewModel *momentItemViewModel = self.dataSource[itemViewModel.section];
        [momentItemViewModel.dataSource addObject:commentItemViewModel];
        [momentItemViewModel.moment.comments addObject:comment];
        momentItemViewModel.moment.commentsCount += 1;
        
        // 更新upArrow
        [momentItemViewModel updateUpArrow];
        
        // 刷新数据源
        [self.reloadSectionSubject sendNext:@(itemViewModel.section)];
        return [RACSignal empty];
    }];
    
    // 删除评论
    self.delCommentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath * indexPath) {
        @strongify(self);
        FriendItemViewModel *momentItemViewModel = self.dataSource[indexPath.section];
        CommentItemViewModel *commentItemViewModel = momentItemViewModel.dataSource[indexPath.row];
        //删除数据
        [momentItemViewModel.dataSource removeObjectAtIndex:indexPath.row];
        //删除
        [momentItemViewModel.moment.comments removeObject:commentItemViewModel.comment];
        momentItemViewModel.moment.commentsCount -= 1;
        // 更新upArrow
        [momentItemViewModel updateUpArrow];
        // 刷新数据源
        [self.reloadSectionSubject sendNext:@(indexPath.section)];
        
        return [RACSignal empty];
    }];
    
    // 跳转到用户信息
//    self.profileInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UserModel * user) {
//        @strongify(self);
//
//        return [RACSignal empty];
//    }];
    
    // 内容文本上高亮点击事件
    self.attributedTapCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary * userInfo) {
        @strongify(self);
        if (userInfo[MHMomentUserInfoKey]) { // 用户
            [self.profileInfoCommand execute:userInfo[MHMomentUserInfoKey]];
            return [RACSignal empty];
        }
        return [RACSignal empty];
    }];
    
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page{
    @weakify(self);
   
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        // 请求数据
        [MyNetworkHelper GET:GET_TWEETS_INFO parameters:nil success:^(MyBaseRequest * _Nonnull request, id  _Nonnull response) {
            if ([NSObject objIsNotNull:response]) {
                NSArray * data = (NSArray *)response;
                NSMutableArray * dataTemp = [NSMutableArray arrayWithArray:response];
                if (data && data.count) { //过滤error 数据
                    for (NSInteger index = data.count - 1; index >= 0; index --) {
                        NSDictionary * dict = data[index];
                        if ([[dict.allKeys componentsJoinedByString:@","] hasSuffix:@"error"]) {
                            [dataTemp removeObjectAtIndex:index];
                        }else if ([NSString stringIsEmpty:[dict objectForKey:@"content"]] && [NSObject objIsNull:[dict objectForKey:@"images"]]) {
                            //删除没有文字图片的说说
                            [dataTemp removeObjectAtIndex:index];
                        }
                    }
                }
                NSDictionary * dict = @{@"moments":dataTemp};
                FriendDataModel *momentsData = [FriendDataModel yy_modelWithJSON:dict];
                NSArray *viewModels = @[];
                if (momentsData && momentsData.moments.count) {
                    viewModels = [momentsData.moments.rac_sequence map:^FriendItemViewModel *(FriendModel * momment) {
                        @strongify(self);
                        FriendItemViewModel *itemViewModel = [[FriendItemViewModel alloc] initWithMoment:momment];
                        // 传递命令
                        itemViewModel.commentSubject  = self.commentSubject;
                        itemViewModel.attributedTapCommand = self.attributedTapCommand;
                        itemViewModel.reloadSectionSubject = self.reloadSectionSubject;
                        return itemViewModel;
                        
                    }].array;
                }
                NSInteger range = 5 * page > viewModels.count? viewModels.count : 5 * page;
                self.dataSource = [viewModels subarrayWithRange:NSMakeRange(0, range)] ?:@[];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
        } failure:^(MyBaseRequest * _Nonnull request, NSError * _Nonnull error) {
             [SLMessageHUD showMessage:@"加载失败，请稍后重试~"];
        }];
        return nil;
    }];
}

@end

