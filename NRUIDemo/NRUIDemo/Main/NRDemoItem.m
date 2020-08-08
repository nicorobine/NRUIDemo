//
//  NRDemoItem.m
//  NRUIDemo
//
//  Created by NicoRobine on 2020/7/6.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRDemoItem.h"

@implementation NRDemoItem

+ (NSString *)testClassWithName:(NSString *)className {
    if (className) {
        if ([className hasPrefix:@"UI"]) {
            return [className stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@"NR"];
        }
    }
    return className;
}

- (instancetype)initWithTitle:(NSString *)title sutTitle:(NSString *)subTitle {
    if (self = [super init]) {
        _title = title;
        _subTitle = subTitle;
    }
    return self;
}

@end
