//
//  UIColor+NRColors.m
//  NRColorDemo
//
//  Created by NicoRobine on 2020/8/19.
//  Copyright © 2020 王文涛. All rights reserved.
//

#import "UIColor+NRColors.h"

@implementation UIColor (NRColors)

+ (BOOL)isDarkMode {
    return UIUserInterfaceStyleDark == UITraitCollection.currentTraitCollection.userInterfaceStyle;
}

+ (UIColor *)nr_customColor {
    return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
        return UIUserInterfaceStyleDark == traitCollection.userInterfaceStyle ? [UIColor colorWithWhite:0.8 alpha:1] : [UIColor colorWithWhite:0.9 alpha:1] ;
    }];
}

@end
