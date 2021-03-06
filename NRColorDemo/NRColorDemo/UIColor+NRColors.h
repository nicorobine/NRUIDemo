//
//  UIColor+NRColors.h
//  NRColorDemo
//
//  Created by NicoRobine on 2020/8/19.
//  Copyright © 2020 王文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (NRColors)

+ (BOOL)isDarkMode;

+ (UIColor *)nr_customColor;

@end

NS_ASSUME_NONNULL_END
