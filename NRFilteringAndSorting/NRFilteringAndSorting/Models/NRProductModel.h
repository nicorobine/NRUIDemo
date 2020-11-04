//
//  NRProductModel.h
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/2.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NRProductModel : NSObject

@property (nonatomic, copy) NSString* name;

@property (nonatomic, copy) NSString* subtitle;

@property (nonatomic, assign) float price;

@property (nonatomic, strong) NSDate* date;

@property (nonatomic, assign) NSUInteger type;

@property (nonatomic, copy) NSString* typeName;

+ (instancetype)entityWithName:(NSString *)name subTitle:(NSString *)subTitle price:(float)price date:(NSDate *)date type:(NSUInteger)type typeName:(NSString *)typeName;

- (instancetype)initWithName:(NSString *)name subTitle:(NSString *)subTitle price:(float)price date:(NSDate *)date type:(NSUInteger)type typeName:(NSString *)typeName;

@end

NS_ASSUME_NONNULL_END
