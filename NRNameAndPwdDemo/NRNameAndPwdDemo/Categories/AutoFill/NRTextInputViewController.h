//
//  NRTextInputViewController.h
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/13.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NRTextInputViewController;

typedef void (^OnDone)(NRTextInputViewController* controller, NSString *text);

NS_ASSUME_NONNULL_BEGIN

@interface NRTextInputViewController : UIViewController

@property (nonatomic, copy) NSString* initialText;

@property (nonatomic, copy) OnDone onDone;

@end

NS_ASSUME_NONNULL_END
