//
//  LDBaseModel.h
//  LDTour
//
//  Created by Daredos on 16/6/4.
//  Copyright © 2016年 Daredos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDBaseModel : NSObject

+ (NSMutableArray *)modelArrayWithKeyValuesArray:(id)keyValuesArray;

+ (instancetype)modelWithKeyValues:(id)keyValues;

@end
