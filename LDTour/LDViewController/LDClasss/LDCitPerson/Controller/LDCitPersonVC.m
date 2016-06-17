//
//  LDCitPersonVC.m
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDCitPersonVC.h"
#import "BMDatePickAlertView.h"

@interface LDCitPersonVC ()


@end

@implementation LDCitPersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cc1:(id)sender {

    
    BMDatePickAlertView *SS = [BMDatePickAlertView datePickViewWirhCustomChangeForPickerMode:0 date:nil minimumDate:nil maximumDate:nil changeBlock:^(BMDatePickAlertView *datePickView, NSDate *date) {
        
        
    }];
    [ SS show];
    
    
    BMDatePickAlertView *s = [BMDatePickAlertView datePickViewWithConfirmForPickerMode:arc4random()%4 date:nil minimumDate:nil maximumDate:nil confirmBlock:^(BMDatePickAlertView *datePickView, NSDate *date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd--HH:mm:ss"];
        NSLog(@"时间： %@",[dateFormatter stringFromDate:date]);
        [datePickView diss];
    }];
    [s show];
}

- (IBAction)cc2:(id)sender {
    
    BMDatePickAlertView *s = [BMDatePickAlertView datePickViewWithChangeForPickerMode:arc4random()%4 date:nil minimumDate:nil maximumDate:nil changeBlock:^(BMDatePickAlertView *datePickView, NSDate *date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd--HH:mm:ss"];
        NSLog(@"时间： %@",[dateFormatter stringFromDate:date]);
    }];
    [s show];
}

- (IBAction)cc3:(id)sender {

    BMDatePickAlertView *s = [BMDatePickAlertView datePickViewWithCustomConfirmForPickerMode:arc4random()%6 date:nil minimumDate:nil maximumDate:nil confirmBlock:^(BMDatePickAlertView *datePickView, NSDate *date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd--HH:mm:ss"];
        NSLog(@"时间： %@",[dateFormatter stringFromDate:date]);
        [datePickView diss];
    }];
    [s show];
}

- (IBAction)cc4:(id)sender {
    
    BMDatePickAlertView *s = [BMDatePickAlertView datePickViewWirhCustomChangeForPickerMode:arc4random()%6 date:nil minimumDate:nil maximumDate:nil changeBlock:^(BMDatePickAlertView *datePickView, NSDate *date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd--HH:mm:ss"];
        NSLog(@"时间： %@",[dateFormatter stringFromDate:date]);
    }];
    [s show];
}

@end
