//
//  LDRecommendationOriginalityCell.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDRecommendationOriginalityCell.h"
#import "UIImageView+WebCache.h"

@interface LDRecommendationOriginalityCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation LDRecommendationOriginalityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

@end
