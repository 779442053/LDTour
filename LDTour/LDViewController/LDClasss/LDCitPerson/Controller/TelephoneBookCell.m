//
//  TelephoneBookCell.m
//  TelephoneBook
//
//  Created by Daredos on 16/6/29.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import "TelephoneBookCell.h"

@interface TelephoneBookCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *smsButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation TelephoneBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.layer.cornerRadius = 15;
    self.titleLabel.clipsToBounds = YES;
}

+ (instancetype)telephoneBookCellWithTableView:(UITableView *)tableView {

    TelephoneBookCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma mark -
#pragma mark - init
#pragma mark - getters setters

- (void)setDict:(NSDictionary *)dict {

    _dict = dict;
    self.nameLabel.text = dict[@"name"];
    self.phoneLabel.text = dict[@"phone"];
    self.titleLabel.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = [dict[@"name"] substringToIndex:1];
}

#pragma mark - 系统delegate
#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应

- (IBAction)smsButtonClick:(id)sender {
    
    self.smsBlock ? self.smsBlock(self.dict[@"phone"]) : nil;
}

- (IBAction)phoneButtonClick:(id)sender {

    self.phoneBlock ? self.phoneBlock(self.dict[@"phone"]) : nil;

}
@end
