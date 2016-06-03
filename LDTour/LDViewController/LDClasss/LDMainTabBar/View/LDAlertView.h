//
//  LDAlertView.h
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDAlertView : UIView

+ (instancetype)alertViewWithTravelBlock:(dispatch_block_t)travelBlock lifeBlock:(dispatch_block_t)lifeBlock;

- (void)show;

@end
