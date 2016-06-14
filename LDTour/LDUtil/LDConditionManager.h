//
//  LDConditionManager.h
//  LDTour
//
//  Created by Daredos on 16/6/6.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDConditionManager : NSObject

/*!
 *  @brief 是否已经登陆
 */
@property (assign, nonatomic, readonly) BOOL isLogined;

- (void)saveLoginUserInfoWithToken:(nonnull NSString *)token;

- (void)clearLogoutUserInfo;

@end
