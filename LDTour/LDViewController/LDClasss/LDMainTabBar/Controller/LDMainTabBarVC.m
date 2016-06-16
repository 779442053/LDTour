//
//  LDMainTabBarVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDMainTabBarVC.h"
#import "LDTabBar.h"
#import "LDRecommendationVC.h"
#import "LDCitPersonVC.h"
#import "LDBespokeVC.h"
#import "LDCenterVC.h"
#import "LDAlertView.h"
#import "BMDatePickView.h"

@interface LDMainTabBarVC ()

@end

@implementation LDMainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.hidden = NO;
    self.tabBar.translucent = NO;

    [self addVC:[LDRecommendationVC class] title:@"推荐"];
    [self addVC:[LDCitPersonVC class] title:@"城市达人"];
    [self addVC:[LDBespokeVC class] title:@"面包订制"];
    [self addVC:[LDCenterVC class] title:@"个人中心"];
    
    NSMutableDictionary *navBarDict            = [NSMutableDictionary dictionary];
    navBarDict[NSFontAttributeName]            = [UIFont boldSystemFontOfSize:19.0f];
    navBarDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:navBarDict];
    
    
    LDTabBar *tabBar = [LDTabBar tabBar];
    tabBar.frame = self.tabBar.bounds;
    
    tabBar.selectControllerActionBlock = ^(NSInteger selectIndex) {
        self.selectedIndex = selectIndex;
    };
    [self.tabBar addSubview:tabBar];
    
    tabBar.tapCenterBlock = ^{
        
        NSArray *array  = @[@"UIDatePickerModeTime",@"UIDatePickerModeDate",@"UIDatePickerModeDateAndTime",@"UIDatePickerModeCountDownTimer"];
        int arc = arc4random()%4;
        [SVProgressHUD showInfoWithStatus:array[arc]];
        
        if (arc4random()%2 == 0) {
            [BMDatePickView showChangeDatePickViewPickerMode:arc date:nil minimumDate:nil maximumDate:nil changeBlock:^(NSDate *date) {
                [SVProgressHUD showInfoWithStatus:date.description];
            }];
        }else{
        
            [BMDatePickView showConfirmDatePickViewPickerMode:arc date:nil minimumDate:nil maximumDate:nil confirmBlock:^(NSDate *date) {
                [SVProgressHUD showInfoWithStatus:date.description];
            }];
        }
    };
}

- (void)addVC:(Class )class title:(NSString *)title {
    NSMutableArray *views = [self.viewControllers ? self.viewControllers : @[] mutableCopy];
    UIViewController *c = [[[class class] alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    c.navigationItem.title = title;
    [views addObject:nc];
    nc.navigationBar.translucent = NO;
    nc.navigationBar.hidden = NO;
    self.viewControllers = [views copy];  
}

@end
