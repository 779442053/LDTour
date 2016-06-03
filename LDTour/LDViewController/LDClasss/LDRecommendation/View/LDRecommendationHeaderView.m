//
//  LDRecommendationHeaderView.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDRecommendationHeaderView.h"

@implementation LDRecommendationHeaderView

+ (instancetype)recommendationHeaderView {
    
    LDRecommendationHeaderView *recommendationHeaderView = [[self alloc] init];
    recommendationHeaderView.backgroundColor = [UIColor grayColor];
    return recommendationHeaderView;
}

@end
