//
//  UIView+LDExtension.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "UIView+LDExtension.h"

@implementation UIView (LDExtension)

- (void)ld_setX:(CGFloat)ld_x
{
    CGRect frame = self.frame;
    frame.origin.x = ld_x;
    self.frame = frame;
}
- (CGFloat)ld_x
{
    return self.frame.origin.x;
}

- (void)ld_setY:(CGFloat)ld_y
{
    CGRect frame = self.frame;
    frame.origin.y = ld_y;
    self.frame = frame;
}
- (CGFloat)ld_y
{
    return self.frame.origin.y;
}

- (void)ld_setWidth:(CGFloat)ld_width
{
    CGRect frame = self.frame;
    frame.size.width = ld_width;
    self.frame = frame;
}
- (CGFloat)ld_width
{
    return self.frame.size.width;
}

- (void)ld_setHeight:(CGFloat)ld_height
{
    CGRect frame = self.frame;
    frame.size.height = ld_height;
    self.frame = frame;
}
- (CGFloat)ld_height
{
    return self.frame.size.height;
}

- (void)ld_setSize:(CGSize)ld_size
{
    CGRect frame = self.frame;
    frame.size = ld_size;
    self.frame = frame;
}
- (CGSize)ld_size
{
    return self.frame.size;
}
- (void)ld_setOrigin:(CGPoint)ld_origin
{
    CGRect frame = self.frame;
    frame.origin = ld_origin;
    self.frame = frame;
}
- (CGPoint)ld_origin
{
    return self.frame.origin;
}

- (void)ld_setCenterX:(CGFloat)ld_centerX
{
    CGPoint center = self.center;
    center.x = ld_centerX;
    self.center = center;
}

- (CGFloat)ld_centerX
{
    return self.center.x;
}

- (void)ld_setCenterY:(CGFloat)ld_centerY
{
    CGPoint center = self.center;
    center.y = ld_centerY;
    self.center = center;
}
- (CGFloat)ld_centerY
{
    return self.center.y;
}

- (CGFloat)ld_layerCornerRadius
{
    return self.layer.cornerRadius;
}
- (void)ld_setLayerCornerRadius:(CGFloat)ld_layerCornerRadius
{
    self.layer.cornerRadius = ld_layerCornerRadius;
    self.clipsToBounds = YES;
}

@end
