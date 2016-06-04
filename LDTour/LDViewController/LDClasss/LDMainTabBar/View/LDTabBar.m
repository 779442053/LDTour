//
//  LDTabBar.m
//  LDTour
//
//  Created by Daredos on 16/5/24.
//  Copyright © 2016年 LiangDaHong. All rights reserved.
//

#import "LDTabBar.h"

@interface LDTabBar ()

@property (weak, nonatomic) IBOutlet UIImageView *addImageView;

@end

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

    [self.addImageView.layer addAnimation:[self getAnim] forKey:nil];
}


- (CABasicAnimation *)getAnim {
    
    // 对Y轴进行旋转（指定Z轴的话，就和UIView的动画一样绕中心旋转）
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 设定动画选项
    animation.duration = 0.3;
    
    animation.repeatCount = 1; // 重复次数

    // 设定旋转角度
    animation.fromValue = @0.0f;
    
    animation.toValue = @(M_PI);
    
//    animation.autoreverses = YES;

//    animation.removedOnCompletion = NO;
    
    return animation;
}


@end
