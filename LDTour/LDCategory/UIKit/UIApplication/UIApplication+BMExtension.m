//
//  UIApplication+BMExtension.m
//  BlueMoonHouse
//
//  Created by elvin on 15/10/15.
//  Copyright © 2015年 bluemoon. All rights reserved.
//

#import "UIApplication+BMExtension.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
//获取手机运营商
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation UIApplication (BMExtension)

+ (NSString *)bm_appVersion
{
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    return [dic objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)bm_appBuildVersion
{
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    return [dic objectForKey:@"CFBundleVersion"];
}

// 获取 Bundle identifier
+ (NSString *)bm_appIdentifier
{
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    return [dic objectForKey:@"CFBundleIdentifier"];
}

// 是否有相机权限
+ (BOOL)bm_haveCameraPower
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) return NO;
    return YES;
}

// 是否有相册权限
+ (BOOL)bm_haveAlbumPower
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) return NO;
    return YES;
}

+ (void)bm_dialTelephoneWithPhoneNumber:(NSString *)phoneNumber {
    
    if (!phoneNumber) {
        return;
    }
    //获取手机运营商
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *isoCountryCode = [carrier mobileCountryCode];
    if (isoCountryCode.length >0) {
        //打电话
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        [SVProgressHUD showErrorWithStatus:@"未安装SIM卡"];
    }
}

+ (void)bm_directDialTelephoneWithPhoneNumber:(NSString *)phoneNumber {
    
    if (!phoneNumber) {
        return;
    }
    //获取手机运营商
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *isoCountryCode = [carrier mobileCountryCode];
    if (isoCountryCode.length >0) {
        //打电话
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        [SVProgressHUD showErrorWithStatus:@"未安装SIM卡"];
    }
}

/**
 *  获取当前正显示的控制器
 */
+ (UIViewController *)bm_topViewController {
    
    UIViewController *rootViewController = ((UIWindow *)[[[UIApplication sharedApplication] windows] objectAtIndex:0]).rootViewController;
    UIViewController *topViewController = rootViewController;
    while (topViewController.presentedViewController) {
        topViewController = rootViewController.presentedViewController;
    }
    return topViewController;
}
@end

