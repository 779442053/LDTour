//
//  LDAPPCacheManager.m
//  LDTour
//
//  Created by Daredos on 16/6/5.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDAPPCacheManager.h"
#import "YYCache.h"

@interface LDAPPCacheManager ()

@property (strong, nonatomic) YYCache *yyCache;
@property (strong, nonatomic) NSString *A __attribute__((unavailable));

@end

@implementation LDAPPCacheManager

- (instancetype)init {
    
    static dispatch_once_t onceToken;
    static id obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [super init];
        if (obj) {
            // 加载资源
            self.yyCache = [[YYCache alloc] initWithName:@"LDTourConditionManagerDB"];
            _isLogin = [_yyCache containsObjectForKey:@"token"];
        }
    });
    return self;
}
singleton_m(APPCacheManager);

- (NSString *)token {

    NSString *token = (NSString *)[self.yyCache objectForKey:@"token"];
    if ([token isKindOfClass:[NSString class]]) {
        return token;
    }
    return nil;
}

- (void)saveLoginUserInfoWithToken:(NSString *)token {

    [self.yyCache setObject:token forKey:@"token"];
    _isLogin = [_yyCache containsObjectForKey:@"token"];
}

- (void)clearLogoutUserInfo {
    _isLogin = NO;
    [self.yyCache removeObjectForKey:@"token"];
}

@end
