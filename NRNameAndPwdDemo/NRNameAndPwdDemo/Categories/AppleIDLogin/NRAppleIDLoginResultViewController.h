//
//  NRAppleIDLoginResultViewController.h
//  NRNameAndPwdDemo
//
//  Created by NicoRobine on 2020/8/26.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NRAppleIDLoginResultViewController : UIViewController

- (instancetype)initWithUserIdentifier:(NSString *)userIdentifier fullName:(NSPersonNameComponents *)fullName email:(NSString *)email;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
