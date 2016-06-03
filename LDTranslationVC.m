//
//  LDTranslationVC.m
//  LDAnimationDemo
//
//  Created by Daredos on 16/5/31.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDTranslationVC.h"

@interface LDTranslationVC ()

@property (strong, nonatomic) UIView *myView;

@property (weak, nonatomic) IBOutlet UITextField *startX;
@property (weak, nonatomic) IBOutlet UITextField *startY;

@property (weak, nonatomic) IBOutlet UITextField *endX;
@property (weak, nonatomic) IBOutlet UITextField *endY;

@property (weak, nonatomic) IBOutlet UITextField *durationText;
@property (weak, nonatomic) IBOutlet UISwitch *autoreversesSwitch;

@end

@implementation LDTranslationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.myView];
}

#pragma mark -
#pragma mark - init
#pragma mark - getters setters

- (UIView *)myView {

    if (!_myView) {
        _myView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 200, 20)];
        _myView.backgroundColor = [UIColor orangeColor];
    }
    return _myView;

}

#pragma mark - 系统delegate
#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法


- (CABasicAnimation *)getAnim {

    // 说明这个动画对象要对CALayer的position属性执行动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];

    // 动画持续1.5s
    anim.duration = self.durationText.text.floatValue > 0.1 ? self.durationText.text.floatValue:1.0;
    
    // position属性值从(50, 80)渐变到(300, 350)
    if (self.startX.text.length && self.startY.text.length) {
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.startX.text.floatValue, self.startY.text.floatValue)];
    }else{
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(110, 110)];
    }

    if (self.endX.text.length && self.endY.text.length) {
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(self.endX.text.floatValue, self.endY.text.floatValue)];
    }else{
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(110, 400)];
    }

    // 设置动画的代理
    anim.delegate = self;
    
    anim.speed = 0.5;
    
    anim.repeatCount = INT_MAX;

    anim.autoreverses = self.autoreversesSwitch.isOn; // 是否自动重复

    // 保持动画执行后的状态
    anim.removedOnCompletion = YES;

    anim.fillMode = kCAFillModeForwards;

    return anim;
}

#pragma mark - 事件响应

- (IBAction)startAnimation:(id)sender {
    
    [self.myView.layer removeAllAnimations];
    
    // 添加动画对象到图层上
    [_myView.layer addAnimation:[self getAnim] forKey:@"translate"];
}

- (IBAction)endAnimation:(id)sender {
    [self.myView.layer removeAllAnimations];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
