//
//  NSObject+Extension.m
//  TreasProject
//
//  Created by YT on 2018/5/14.
//  Copyright © 2018年 YT. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

#pragma mark - 实例方法调换
+ (void)exchangeInstanceMethodWithOriginalSel:(SEL)originalSel swizzledSel:(SEL)swizzledSel
{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSel);
    
    BOOL success = class_addMethod(class, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - 类方法调换
+ (void)exchangeClassMethodWithOriginalSel:(SEL)originalSel swizzledSel:(SEL)swizzledSel
{
    Class class = object_getClass((id)self);
    Method originalMethod = class_getClassMethod(class, originalSel);
    Method swizzledMethod = class_getClassMethod(class, swizzledSel);
    
    BOOL success = class_addMethod(class, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if(success) {
        class_replaceMethod(class, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - 方法交换
+ (void)exchangeMethodWithOriginalClass:(Class)originalClass originalSelector:(SEL)originalSelector swizzledClass:(Class)swizzledClass swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getClassMethod(swizzledClass, swizzledSelector);
    
    BOOL success = class_addMethod(originalClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if(success) {
        class_replaceMethod(originalClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - UndefinedKey
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
