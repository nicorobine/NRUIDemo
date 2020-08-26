//
//  NRAppleIDLoginHelper.h
//  NRNameAndPwdDemo
//
//  Created by NicoRobine on 2020/8/26.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NRAppleIDLoginHelper : NSObject

+ (void)showAppleIDControllerWithAnchor:(UIViewController *)anchor;

@end

NS_ASSUME_NONNULL_END
