//
//  LDTabBar.m
//  LDTour
//
//  Created by Daredos on 16/5/24.
//  Copyright © 2016年 LiangDaHong. All rights reserved.
//

#import "LDTabBar.h"

@implementation LDTabBar

- (void)awakeFromNib {
    
    [super awakeFromNib];
    UIButton *button = [self viewWithTag:200];
    button.selected = YES;
}


+ (instancetype)tabBar {
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    NSArray *views = [nib instantiateWithOwner:nil options:nil];
    LDTabBar *tabBar = [views firstObject];
    return tabBar;
}

+ (instancetype)tabBarWithSelectControllerActionBlock:(BMSelectControllerActionBlock)selectControllerActionBlock
                                       tapCenterBlock:(dispatch_block_t)tapCenterBlock {
    
    LDTabBar *tabBar = [self tabBar];
    tabBar.selectControllerActionBlock = selectControllerActionBlock;
    tabBar.tapCenterBlock = tapCenterBlock;
    return tabBar;
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender.selected) {
        return;
    }
    
    for (NSInteger tag = 200; tag < 204; tag++) {
        UIButton *button = [self viewWithTag:tag];
        button.selected = NO;
    }
    
    sender.selected = YES;
    !self.selectControllerActionBlock ? : self.selectControllerActionBlock(sender.tag-200);
}

- (IBAction)tapCenterButtonClick {
    
    self.tapCenterBlock ? self.tapCenterBlock():nil;
}

@end
