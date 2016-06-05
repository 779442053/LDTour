//
//  LDAPPCacheManager.m
//  LDTour
//
//  Created by Daredos on 16/6/5.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDAPPCacheManager.h"

@implementation LDAPPCacheManager

- (instancetype)init {
    
    static dispatch_once_t onceToken;
    static id obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [super init];
        if (obj) {
            // 加载资源
        }
    });
    return self;
}
singleton_m(APPCacheManager);

- (void)loginSituation:(BOOL)situation {
    
    _login = situation;
}

@end
