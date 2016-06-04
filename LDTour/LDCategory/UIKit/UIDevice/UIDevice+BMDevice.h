//
//  UIDevice+BMDevice.h
//  BlueMoonHouse
//
//  Created by elvin on 15/10/15.
//  Copyright © 2015年 bluemoon. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
	iOS设备版本
 */
typedef NS_ENUM(NSInteger, BMDeviceType) {
    BMDeviceTypeUnknow=0,	/** 未知 */
    BMDeviceTypeiPhone1=1,	/** iPhone1 */
    BMDeviceTypeiPhone3,	/** iPhone3 */
    BMDeviceTypeiPhone3GS,	/** iPhone3GS */
    BMDeviceTypeiPhone4,	/** iPhone4 */
    BMDeviceTypeiPhone4S,	/** iPhone4S */
    BMDeviceTypeiPhone5,	/** iPhone5 */
    BMDeviceTypeiPhone5C,	/** iPhone5C */
    BMDeviceTypeiPhone5S,	/** iPhone5S */
    BMDeviceTypeiPhone6,	/** iPhone6 */
    BMDeviceTypeiPhone6Plus,	/** iPhone6Plus */
    BMDeviceTypeiPod1,	/** iPod touch 1 */
    BMDeviceTypeiPod2,	/** iPod touch 2 */
    BMDeviceTypeiPod3,	/** iPod touch 3 */
    BMDeviceTypeiPod4,	/** iPod touch 4 */
    BMDeviceTypeiPod5,	/** iPod touch 5 */
    BMDeviceTypeiPad1,	/** iPad1 */
    BMDeviceTypeiPad2,	/** iPad2 */
    BMDeviceTypeiPad3,	/** iPad3 */
    BMDeviceTypeiPhoneSimulator,	/** iPhone虚拟机 */
    BMDeviceTypeiPadSimulator,	/** iPad虚拟机 */
    BMDeviceTypeUnknowiPhone,	/** 未知iPhone */
    BMDeviceTypeUnknowiPod,	/** 未知iPod touch */
    BMDeviceTypeUnknowiPad	/** 未知iPad */
};

/**
 用于添加获取设备相关的信息
 */
@interface UIDevice (BMDevice)

/**
	获取系统信息
	@param typeSpecifier
	@returns 系统信息
 */
+ (NSString *)getSystemInfoWithNameBM:(char *)typeSpecifier;

/**
	获取系统信息中的hw.machine
	@returns 系统信息中的hw.machine
 */
+ (NSString *)machineBM;

/**
	判断硬件设备类型
	@returns BMDeviceType
 */
+ (BMDeviceType)deviceTypeBM;

/**
	获取MAC地址
	@returns MAC地址
 */
+ (NSString *)macAddress;

//获取系统版本
+ (NSInteger)getOSVersion;

+ (BOOL)hasCamera;

//屏幕分辨率
+ (NSString *)screenSize;

//判断是否是retina屏幕
+ (BOOL)isRetina;

//获取UUID
+ (NSString *)UUID;

//把设备强制转成竖屏
+ (void)resetDeviceInterFaceOrientationPortrait;

//设备是否有相机
+ (BOOL)bm_haveCamera;

/*!
 *  @brief 获取系统版本号
 *
 *  @return 系统版本号 @"8.0" ...
 */
+ (NSString *)bm_systemVersion;


/*!
 *  @brief 获取系统版本号
 *
 *  @return 系统版本 8.0 ...
 */
+ (float)bm_systemVersionFloat;


@end
