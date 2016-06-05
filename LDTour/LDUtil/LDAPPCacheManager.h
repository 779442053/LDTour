//
//  LDAPPCacheManager.h
//  LDTour
//
//  Created by Daredos on 16/6/5.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface LDAPPCacheManager : NSObject

singleton_h(APPCacheManager);

@property (assign, atomic, readonly, getter=isLogin) BOOL login;

- (void)loginSituation:(BOOL)situation;

@end
