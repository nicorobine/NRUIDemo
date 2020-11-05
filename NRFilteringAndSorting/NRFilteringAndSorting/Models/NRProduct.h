//
//  NRProduct.h
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/5.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NRProductType) {
    NRProductType_All,
    NRProductType_Birthdays,
    NRProductType_Weddings,
    NRProductType_Funerals,
};

NS_ASSUME_NONNULL_BEGIN

@interface NRProduct : NSObject <NSCoding>

@property (nonatomic, copy) NSString* title;

@property (nonatomic, assign) NSInteger yearIntroduced;

@property (nonatomic, assign) double introPrice;

@property (nonatomic, assign) NSInteger type;

- (instancetype)initWithTitle:(NSString *)title yearIntroduced:(NSInteger)yearIntroduced
                   introPrice:(double)introPrice type:(NSInteger)type;

- (NSString *)formattedIntroPrice;
@end

NS_ASSUME_NONNULL_END
