//
//  UIView+LDExtension.h
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LDExtension)

@property (assign, nonatomic, setter=ld_setX:)        CGFloat ld_x;
@property (assign, nonatomic, setter=ld_setY:)        CGFloat ld_y;
@property (assign, nonatomic, setter=ld_setWidth:)    CGFloat ld_width;
@property (assign, nonatomic, setter=ld_setHeight:)   CGFloat ld_height;
@property (assign, nonatomic, setter=ld_setSize:)     CGSize  ld_size;
@property (assign, nonatomic, setter=ld_setOrigin:)   CGPoint ld_origin;
@property (assign, nonatomic, setter=ld_setCenterX:)  CGFloat ld_centerX;
@property (assign, nonatomic, setter=ld_setCenterY:)  CGFloat ld_centerY;

@property (assign, nonatomic, setter=ld_setLayerCornerRadius:) CGFloat ld_layerCornerRadius;

@end
