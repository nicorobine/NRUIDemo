//
//  NRPerson.h
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/4.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NRPerson : NSObject

@property (nonatomic, copy) NSString* firstName;

@property (nonatomic, copy) NSString* lastName;

+ (instancetype)entityWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

@end

NS_ASSUME_NONNULL_END
