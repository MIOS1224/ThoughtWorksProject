//
//  MomentReplyItemViewModel.m
//  ThoughtWorkWebChat
//
//  Created by YT on 2020/3/21.
//  Copyright © 2020 ThoughtWorkWebChat. All rights reserved.
//

#import "CommentReplyItemViewModel.h"
#import "FriendItemViewModel.h"
#import "CommentItemViewModel.h"

@interface CommentReplyItemViewModel ()
@property (nonatomic,strong) id itemViewModel;
//@property (nonatomic,copy) NSString *idstr;
@property (nonatomic,copy) NSString *momentIdstr;
@property (nonatomic,strong) UserModel *toUser;
@property (nonatomic,assign , getter = isReply) BOOL reply;
@end


@implementation CommentReplyItemViewModel
- (instancetype)initWithItemViewModel:(id)itemViewModel{
    self = [super init];
    if (self) {
        
        // 记录一下
        self.itemViewModel = itemViewModel;
        
        if ([itemViewModel isKindOfClass:FriendItemViewModel.class]) { // 点击 `评论按钮`  评论该说说
            FriendItemViewModel *viewModel = (FriendItemViewModel *)itemViewModel;
//            self.idstr = viewModel.moment.idstr;
//            self.momentIdstr = viewModel.moment.idstr;
            self.reply = NO; // 这里不是回复
            
            
        }else if([itemViewModel isKindOfClass:CommentItemViewModel.class]){ // 点击 `评论Cell` ， 回复某条说说的某条评论
            CommentItemViewModel *viewModel = (CommentItemViewModel *)itemViewModel;
            self.momentIdstr = viewModel.comment.momentIdstr;
            self.reply = YES; // 回复
            self.toUser = viewModel.comment.sender;
        }
    }
    
    return self;
}
@end

