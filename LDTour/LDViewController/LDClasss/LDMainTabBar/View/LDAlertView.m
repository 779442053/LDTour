//
//  LDAlertView.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDAlertView.h"

@implementation LDAlertView

- (void)awakeFromNib {

    [super awakeFromNib];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAlertViewClick)]];
}

+ (instancetype)alertViewWithTravelBlock:(dispatch_block_t)travelBlock lifeBlock:(dispatch_block_t)lifeBlock {
    
    LDAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    return alertView;
}

- (void)show {
    
    self.alpha = 0.0f;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.3f;
    }];
}

#pragma mark -
#pragma mark - init
#pragma mark - 生命周期
#pragma mark - getters setters
#pragma mark - 系统delegate
#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应

- (void)tapAlertViewClick {

    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
