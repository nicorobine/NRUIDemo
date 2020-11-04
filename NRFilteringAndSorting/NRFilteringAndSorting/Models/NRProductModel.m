//
//  NRProductModel.m
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/2.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRProductModel.h"

@implementation NRProductModel

+ (instancetype)entityWithName:(NSString *)name subTitle:(NSString *)subTitle price:(float)price date:(NSDate *)date type:(NSUInteger)type typeName:(NSString *)typeName {
    return [[self alloc] initWithName:name subTitle:subTitle price:price date:date type:type typeName:typeName];
}

- (instancetype)initWithName:(NSString *)name subTitle:(NSString *)subTitle price:(float)price date:(NSDate *)date type:(NSUInteger)type typeName:(NSString *)typeName {
    if (self = [super init]) {
        _name = name;
        _subtitle = subTitle;
        _price = price;
        _date = date;
        _type = type;
        _typeName = typeName;
    }
    return self;
}

@end
