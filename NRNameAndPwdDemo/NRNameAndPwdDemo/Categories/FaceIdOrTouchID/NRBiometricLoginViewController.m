//
//  NRBiometricLoginViewController.m
//  NRNameAndPwdDemo
//
//  Created by NicoRobine on 2020/7/31.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRBiometricLoginViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

typedef NS_ENUM(NSUInteger, LoginState) {
    LoginState_Default,
    LoginState_Logedin,
};

@interface NRBiometricLoginViewController ()
{
    LAContext* _laContact;
}

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *loginStateLabel;

@property (nonatomic, assign) LoginState loginState;

@end

@implementation NRBiometricLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _varifyDevice];
}

- (BOOL)_varifyDevice {
    _laContact = [[LAContext alloc] init];
    NSError* error;
    BOOL result = [_laContact canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    return result;
}

- (IBAction)onTap:(UIButton *)sender {
    [_laContact invalidate];
    if (_loginState == LoginState_Default) {
        _laContact = [[LAContext alloc] init];
        [_laContact evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"登录" reply:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.loginState = success ? LoginState_Logedin : LoginState_Default;
            });
        }];
    } else {
        self.loginState = LoginState_Default;
    }
}

#pragma mark - Properties

- (void)setLoginState:(LoginState)loginState {
    _loginState = loginState;
    [_loginStateLabel setText:_loginState == LoginState_Default ? @"未登录" : @"已登录"];
    [_loginButton setTitle:_loginState == LoginState_Default ? @"登 录" : @"登 出" forState:UIControlStateNormal];
}

@end
