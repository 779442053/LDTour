//
//  AppDelegate.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "AppDelegate.h"
#import "LDMainTabBarVC.h"
#import <MobAPI/MobAPI.h>
#import "LDStartViewController.h"

@implementation AppDelegate

#pragma mark -
#pragma mark - init
#pragma mark - 生命周期
#pragma mark - getters setters

- (UIWindow *)window {

    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
        [_window makeKeyAndVisible];
    }
    return _window;
}

#pragma mark - 系统delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initAPP];

    [self interfaceSkip];

    return YES;
    return YES;
    return YES;
}

#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法

- (void)initAPP {
    
    // UI相关
    // 配置项目导航条上标题
    NSMutableDictionary *navBarDict            = [NSMutableDictionary dictionary];
    navBarDict[NSFontAttributeName]            = [UIFont boldSystemFontOfSize:25.0f];
    navBarDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:navBarDict];
    
    //隐藏返回按钮文字，只保留返回箭头
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
    //                                                         forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:73/255.0 green:189/255.0 blue:206/255.0 alpha:1]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    //修改导航栏上的所有 按钮的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    // sdk相关
    [MobAPI registerApp:@"1346f56d837b7"];

}

- (void)interfaceSkip {
    
    LDStartViewController *c = [LDStartViewController startViewControllerWithGifName:@"animate_gif.gif" timingTime:arc4random()%5+2 endBlock:^{
        self.window.rootViewController = [LDMainTabBarVC new];
    }];
    self.window.rootViewController = c;
}
#pragma mark - 事件响应


@end
