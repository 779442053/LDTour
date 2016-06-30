//
//  LDTelephoneBookManger.m
//  LDTelephoneBook
//
//  Created by Daredos on 16/6/30.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDTelephoneBookManger.h"
#import "YYCache.h"
#define kBookKey    @"book"
#define kYYCacheKey @"TelephoneBookDB"

@interface  LDTelephoneBookManger()

@property (strong, nonatomic) YYCache *yyCache;

@end

@implementation LDTelephoneBookManger


#pragma mark -
#pragma mark - init
- (instancetype)init {
    
    if (self = [super init]) {
        id obj = [self.yyCache objectForKey:kBookKey];
        _telephoneBookArray = (obj && [obj isKindOfClass:[NSArray class]]) ? [(NSArray *)obj mutableCopy] : [@[] mutableCopy];
    }
    return self;
}

#pragma mark - getters setters

- (YYCache *)yyCache {
    
    if (!_yyCache) {
        _yyCache =  [[YYCache alloc] initWithName:kYYCacheKey];
    }
    return _yyCache;
}

#pragma mark - 系统delegate
#pragma mark - 自定义delegate
#pragma mark - 公有方法

+ (instancetype)sharedTelephoneBookManger {
    
    static LDTelephoneBookManger *sharedTelephoneBookManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTelephoneBookManger = [[[self class] alloc] init];
    });
    return sharedTelephoneBookManger;
}

- (BOOL)addTelephoneWithName:(NSString *)name phone:(NSString *)phone {

    if (!phone) {
        return NO;
    }

    id obj = [self.yyCache objectForKey:kBookKey];
    NSMutableArray *muarray = (obj && [obj isKindOfClass:[NSArray class]]) ? [(NSArray *)obj mutableCopy] : [@[] mutableCopy];

    for (NSString *p in muarray) {
        
        if ([p isEqualToString:phone]) {
            return NO;
        }
    }
    [muarray addObject:phone];
    [self.yyCache setObject:muarray forKey:kBookKey];
    _telephoneBookArray = [muarray copy];
    return YES;
}

- (BOOL)removeTelephoneWithName:(NSString *)name phone:(NSString *)phone {
    
    if (!phone) {
        return NO;
    }

    NSMutableArray *muarray = [_telephoneBookArray mutableCopy];
    
    for (NSString *p in muarray) {
        if ([p isEqualToString:phone]) {
            [muarray removeObject:phone];
            [self.yyCache setObject:muarray forKey:kBookKey];
            _telephoneBookArray  = [muarray copy];
            return YES;
        }
    }
    return NO;
}
#pragma mark - 私有方法
#pragma mark - 事件响应

@end
