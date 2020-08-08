//
//  NRDemoItem.h
//  NRUIDemo
//
//  Created by NicoRobine on 2020/7/6.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NRDemoItem : NSObject

+ (NSString *)testClassWithName:(NSString *)className;

@property (nonatomic, copy) NSString* title;

@property (nonatomic, copy) NSString* subTitle;

// 呈现方式是不是present，如果不是就是使用导航的push
@property (nonatomic, assign) BOOL present;

- (instancetype)initWithTitle:(NSString *)title sutTitle:(NSString *)subTitle;

@end

NS_ASSUME_NONNULL_END
