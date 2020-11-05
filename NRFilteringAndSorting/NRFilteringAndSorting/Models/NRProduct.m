//
//  NRProduct.m
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/5.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRProduct.h"

@implementation NRProduct

- (instancetype)initWithTitle:(NSString *)title yearIntroduced:(NSInteger)yearIntroduced introPrice:(double)introPrice type:(NSInteger)type {
    if (self = [super init]) {
        _title = title;
        _yearIntroduced = yearIntroduced;
        _introPrice = introPrice;
        _type = type;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    NSString* title = [coder decodeObjectForKey:@"title"];
    NSInteger year = ((NSNumber *)[coder decodeObjectForKey:@"yearIntroduced"]).integerValue;
    double price = ((NSNumber *)[coder decodeObjectForKey:@"introPrice"]).doubleValue;
    NSInteger type = ((NSNumber *)[coder decodeObjectForKey:@"type"]).integerValue;
    
    return [self initWithTitle:title yearIntroduced:year introPrice:price type:type];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeInteger:_yearIntroduced forKey:@"yearIntroduced"];
    [coder encodeDouble:_introPrice forKey:@"introPrice"];
    [coder encodeInteger:_type forKey:@"type"];
}

- (NSString *)formattedIntroPrice {
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.formatterBehavior = NSNumberFormatterBehaviorDefault;
    return [formatter stringFromNumber:@(_introPrice)];
}

@end
