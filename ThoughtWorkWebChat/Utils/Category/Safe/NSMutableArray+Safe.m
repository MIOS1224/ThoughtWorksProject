//
//  NSMutableArray+Safe.m
//  TreasProject
//
//  Created by YT on 2018/5/14.
//  Copyright © 2018年 YT. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+Extension.h"

@implementation NSMutableArray (Safe)

#pragma mark - 交换方法
+ (void)load
{
    Class __NSArrayM = NSClassFromString(@"__NSArrayM");
    
    [__NSArrayM exchangeInstanceMethodWithOriginalSel:@selector(insertObject:atIndex:)
                                    swizzledSel:@selector(safeInsertObject:atIndex:)];
    
    [__NSArrayM exchangeInstanceMethodWithOriginalSel:@selector(replaceObjectAtIndex:withObject:)
                                    swizzledSel:@selector(safeReplaceObjectAtIndex:withObject:)];
    
    [__NSArrayM exchangeInstanceMethodWithOriginalSel:@selector(objectAtIndex:)
                                    swizzledSel:@selector(safeObjectAtIndex:)];
}

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (index >= 0 && index < self.count) {
        return [self safeObjectAtIndex:index];
    } else {
        //
        NSLog(@"出错啦!!! [NSMutableArray objectAtIndex:]: index %@ beyond bounds [0 .. %@]\n%@", [NSNumber numberWithInteger:index], [NSNumber numberWithInteger:self.count],  self);
        return nil;
    }
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject && index <= self.count) {
        [self safeInsertObject:anObject atIndex:index];
    }else{
        
    }
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (anObject && index < self.count) {
        [self safeReplaceObjectAtIndex:index withObject:anObject];
    }else{
        
    }
}

@end

