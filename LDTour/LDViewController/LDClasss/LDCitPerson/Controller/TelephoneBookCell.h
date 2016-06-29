//
//  TelephoneBookCell.h
//  TelephoneBook
//
//  Created by Daredos on 16/6/29.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TelephoneBookActionBlock)(NSString *string);

@interface TelephoneBookCell : UITableViewCell

@property (strong, nonatomic) NSDictionary *dict;

@property (copy, nonatomic) TelephoneBookActionBlock smsBlock;
@property (copy, nonatomic) TelephoneBookActionBlock phoneBlock;

+ (instancetype)telephoneBookCellWithTableView:(UITableView *)tableView;

@end
