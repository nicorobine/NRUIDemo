//
//  NRLoginViewController.h
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/12.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NRLoginModel;


NS_ASSUME_NONNULL_BEGIN

@interface NRLoginViewController : UIViewController

@property (nonatomic, readonly) NRLoginModel *loginModel;

@end

NS_ASSUME_NONNULL_END
