//
//  LDForgetVC.m
//  LDTour
//
//  Created by Daredos on 16/6/7.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDForgetVC.h"

@interface LDForgetVC ()

@end

@implementation LDForgetVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:73/255.0 green:189/255.0 blue:206/255.0 alpha:1];

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
- (IBAction)cancelButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)forgetButtonClick:(id)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
}

@end
