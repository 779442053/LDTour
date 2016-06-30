//
//  LDTelephoneBookManger.h
//  LDTelephoneBook
//
//  Created by Daredos on 16/6/30.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDTelephoneBookManger : NSObject

@property (strong, nonatomic, readonly) NSArray *telephoneBookArray;

+ (instancetype)sharedTelephoneBookManger;

- (BOOL)addTelephoneWithName:(NSString *)name phone:(NSString *)phone;

- (BOOL)removeTelephoneWithName:(NSString *)name phone:(NSString *)phone;

@end
