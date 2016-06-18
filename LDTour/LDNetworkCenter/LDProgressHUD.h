//
//  LDProgressHUD.h
//  LDTour
//
//  Created by Daredos on 16/6/11.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDProgressHUD : NSObject

/*!
 ================================================
加载中HUD
 */
+ (void)showHaveMaskNotTitleHUD;
+ (void)showHaveMaskDefaultTitleHUD;
+ (void)showHaveMaskHUDWithTitle:(NSString *)string;

+ (void)showNotMaskNotTitleHUD;
+ (void)showNotMaskDefaultTitleHUD;
+ (void)showNotMaskHUDWithTitle:(NSString *)string;

/*!
 ================================================
 成功提示HUD
 */

/*!
 ================================================
 警告提示HUD
 */

/*!
 ================================================
 错误提示HUD
 */


/*!
 ================================================
 自定义HUD
 */
+ (void)showHUDWithError:(NSError *)error;

@end
