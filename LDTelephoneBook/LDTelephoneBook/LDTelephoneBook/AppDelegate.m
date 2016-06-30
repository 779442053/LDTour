//
//  AppDelegate.m
//  LDTelephoneBook
//
//  Created by Daredos on 16/6/30.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "AppDelegate.h"
#import "LDTelephoneBookVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark -
#pragma mark - init
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
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[LDTelephoneBookVC new]];
    self.window.rootViewController = nc;
    return YES;
}

#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应

@end
