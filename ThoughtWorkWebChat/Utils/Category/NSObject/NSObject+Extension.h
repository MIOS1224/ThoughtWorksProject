//
//  NSObject+Extension.h
//  TreasProject
//
//  Created by YT on 2018/5/14.
//  Copyright © 2018年 YT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Extension)

#pragma mark - 实例方法调换
+ (void)exchangeInstanceMethodWithOriginalSel:(SEL)originalSel swizzledSel:(SEL)swizzledSel;

#pragma mark - 类方法调换
+ (void)exchangeClassMethodWithOriginalSel:(SEL)originalSel swizzledSel:(SEL)swizzledSel;

#pragma mark - 方法交换
+ (void)exchangeMethodWithOriginalClass:(Class)originalClass originalSelector:(SEL)originalSelector swizzledClass:(Class)swizzledClass swizzledSelector:(SEL)swizzledSelector;

@end
