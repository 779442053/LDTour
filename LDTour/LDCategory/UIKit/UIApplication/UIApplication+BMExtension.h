//
//  UIApplication+BMExtension.h
//  BlueMoonHouse
//
//  Created by elvin on 15/10/15.
//  Copyright © 2015年 bluemoon. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BMAPNSTOKEN @"BMAPNSTOKEN"

@interface UIApplication (BMExtension)

/**
	应用版本
	@returns app版本  e.g  @"1.0.0"
 */
+ (NSString *)bm_appVersion;

/**
	build版本
	@returns build版本
 */
+ (NSString *)bm_appBuildVersion;

/**
	应用id
	@returns 应用id
 */
+ (NSString *)bm_appIdentifier;

//-----------------------------------
//---------------app相关--------------
//-----------------------------------

// 是否有相机权限
+ (BOOL)bm_haveCameraPower;

// 是否有相册权限
+ (BOOL)bm_haveAlbumPower;

/**
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 */
+ (void)bm_dialTelephoneWithPhoneNumber:(NSString *)phoneNumber;
/**
 *  直接拨打电话
 */
+ (void)bm_directDialTelephoneWithPhoneNumber:(NSString *)phoneNumber;

/**
 *  获取当前正显示的控制器
 */
+ (UIViewController *)bm_topViewController;
@end
