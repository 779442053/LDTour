//
//  LDBaseModel.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDBaseModel.h"
#import "MJExtension.h"

@implementation LDBaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSMutableArray *)modelArrayWithKeyValuesArray:(id)keyValuesArray {
    
    return [self mj_objectArrayWithKeyValuesArray:keyValuesArray];
}

+ (instancetype)modelWithKeyValues:(id)keyValues {
    
    return [self mj_objectWithKeyValues:keyValues];
}

//--------
// 对象归档 : 继承于 BMBaseModel的 model均可使用 数据归档Cache
//--------

- (void)encodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder
{
    //NSLog(@"encodeIvarOfClass %@", NSStringFromClass(class));
    unsigned int numIvars = 0;
    Ivar *ivars = class_copyIvarList(class, &numIvars);
    for (int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        id value = [self valueForKey:key];
        if ([key hasPrefix:@"parent"]) {
            [coder encodeConditionalObject:value forKey:key];
        } else {
            [coder encodeObject:value forKey:key];
        }
    }
    if (ivars != NULL) { free(ivars); }
}

- (void)continueEncodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder
{
    if (class_respondsToSelector(class, @selector(encodeWithCoder:))) {
        [self encodeIvarOfClass:class withCoder:coder];
        [self continueEncodeIvarOfClass:class_getSuperclass(class) withCoder:coder];
    }
}

- (void)encodeWithCoder:(NSCoder *)coder {
    @autoreleasepool {
        [self continueEncodeIvarOfClass:[self class] withCoder:coder];
        
    }
}

- (void)decodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder
{
    unsigned int numIvars = 0;
    Ivar * ivars = class_copyIvarList(class, &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        id value = [coder decodeObjectForKey:key];
        [self setValue:value forKey:key];
        //NSLog(@"var name: %@\n", key);
    }
    if (ivars != NULL) { free(ivars); }
}

- (void)continueDecodeIvarOfClass:(Class)class withCoder:(NSCoder *)coder
{
    if (class_respondsToSelector(class, @selector(initWithCoder:))) {
        [self decodeIvarOfClass:class withCoder:coder];
        [self continueDecodeIvarOfClass:class_getSuperclass(class) withCoder:coder];
    }
}


- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    @autoreleasepool {
        [self continueDecodeIvarOfClass:[self class] withCoder:coder];
    }
    return self;
}
@end
