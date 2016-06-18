//
//  LDProgressHUD.m
//  LDTour
//
//  Created by Daredos on 16/6/11.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDProgressHUD.h"
#import "SVProgressHUD.h"

@implementation LDProgressHUD

+ (void)showHUDWithError:(NSError *)error {
    
    NSString *string = nil;
    switch (error.code) {
        case -12002:
            string = @"没有网络,请检测网络!";
            break;
            
        default:
            break;
    }
    if (string) {
        [SVProgressHUD showInfoWithStatus:string maskType:SVProgressHUDMaskTypeNone];
        return;
    }
    
    // 其他业务处理
    
    [SVProgressHUD showInfoWithStatus:@"其他的业务错误!" maskType:SVProgressHUDMaskTypeNone];
}

@end
