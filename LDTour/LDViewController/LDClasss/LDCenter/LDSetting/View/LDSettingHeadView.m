//
//  LDSettingHeadView.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDSettingHeadView.h"

@implementation LDSettingHeadView

+ (instancetype)settingHeadView {

    LDSettingHeadView *settingHeadView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    return settingHeadView;
}

@end
