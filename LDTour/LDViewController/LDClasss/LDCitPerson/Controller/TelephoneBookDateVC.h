//
//  TelephoneBookDateVC.h
//  TelephoneBook
//
//  Created by Daredos on 16/6/29.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "LDNoTabBarBaseVC.h"

@interface TelephoneBookDateVC : LDNoTabBarBaseVC

@property (strong, nonatomic) NSDictionary *dict;
@property (copy, nonatomic) dispatch_block_t reloadBlock;
@end
