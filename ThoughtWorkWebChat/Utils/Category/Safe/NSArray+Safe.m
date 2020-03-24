//
//  NSArray+Safe.m
//  TreasProject
//
//  Created by YT on 2018/5/14.
//  Copyright © 2018年 YT. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+Extension.h"

@implementation NSArray (Safe)
+ (void)load
{
    Class __NSArrayI = NSClassFromString(@"__NSArrayI");
    [__NSArrayI exchangeInstanceMethodWithOriginalSel:@selector(objectAtIndex:)
                                    swizzledSel:@selector(safeObjectAtIndex:)];
    [__NSArrayI exchangeInstanceMethodWithOriginalSel:@selector(objectAtIndexedSubscript:)
                                     swizzledSel:@selector(safeObjectAtIndexedSubscript:)];
}

- (id)safeObjectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= 0 && idx < self.count) {
        return [self safeObjectAtIndexedSubscript:idx];
    } else {
        NSLog(@"出错啦!!! [NSArray safeObjectAtIndexedSubscript:]: index %@ beyond bounds [0 .. %@]\n%@", [NSNumber numberWithInteger:idx], [NSNumber numberWithInteger:self.count],  self);
        return nil;
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (index >= 0 && index < self.count) {
        return [self safeObjectAtIndex:index];
    } else {
        //
        NSLog(@"出错啦!!! [NSArray objectAtIndex:]: index %@ beyond bounds [0 .. %@]\n%@", [NSNumber numberWithInteger:index], [NSNumber numberWithInteger:self.count],  self);
        return nil;
    }
}

@end

@implementation NSMutableDictionary (Safe)

#pragma mark - 交换setObject和safeSetObject方法
+ (void)load
{
    Class class = NSClassFromString(@"__NSDictionaryM");
    
    [class exchangeInstanceMethodWithOriginalSel:@selector(setObject:forKey:)
                                    swizzledSel:@selector(safeSetObject:forKey:)];
}

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject && ![anObject isKindOfClass:[NSNull class]] && aKey) {
        [self safeSetObject:anObject forKey:aKey];
    }else{
        NSLog(@"出错啦!!! [safeSetObject: forKey:] %@",self);
    }
}

@end



