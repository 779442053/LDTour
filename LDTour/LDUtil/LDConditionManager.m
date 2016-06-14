//
//  LDConditionManager.m
//  LDTour
//
//  Created by Daredos on 16/6/6.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDConditionManager.h"
#import "YYCache.h"

@interface LDConditionManager ()

@property (strong, nonatomic) YYCache *yyCache;

@end


@implementation LDConditionManager

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        _isLogined = [_yyCache containsObjectForKey:@"token"];
    }
    return self;
}

+ (instancetype)shareUserInfoManager {

    static LDConditionManager *conditionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        conditionManager = [[[self class] alloc] init];
        conditionManager.yyCache = [[YYCache alloc] initWithName:@"LDTourConditionManagerDB"];
    });
    return conditionManager;
}

- (void)saveLoginUserInfoWithToken:(nonnull NSString *)token {

    [self.yyCache setObject:token forKey:@"token"];
}

- (void)clearLogoutUserInfo {

    _isLogined      = NO;
    [self.yyCache removeObjectForKey:@"token"];

}

@end
