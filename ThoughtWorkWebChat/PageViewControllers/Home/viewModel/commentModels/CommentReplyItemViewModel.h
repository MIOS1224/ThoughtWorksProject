//
//  MomentReplyItemViewModel.h
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentReplyItemViewModel : NSObject

@property (nonatomic, readonly, strong) id itemViewModel;
@property (nonatomic, readonly, strong) UserModel *toUser;// 目标
@property (nonatomic, readonly, assign , getter = isReply) BOOL reply; //是否是 回复

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger section;  // 记录Section
@property (nonatomic, strong) RACCommand *commentCommand;  // 发送评论内容


// idStr(评论的id)
//@property (nonatomic, readonly, copy) NSString *idstr;
// momentIdstr(该评论的所处的说说的id)
//@property (nonatomic, readonly, copy) NSString *momentIdstr;

- (instancetype)initWithItemViewModel:(id)itemViewModel;

@end

NS_ASSUME_NONNULL_END
