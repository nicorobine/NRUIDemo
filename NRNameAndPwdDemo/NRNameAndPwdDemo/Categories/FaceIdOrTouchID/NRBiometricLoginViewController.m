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

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _varifyDevice];
}

#pragma mark - Private

- (BOOL)_varifyDevice {
    _laContact = [[LAContext alloc] init];
    NSError* error;
    BOOL result = [_laContact canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    return result;
}

#pragma mark - Credential

- (void)test {
    SecAccessControlRef secRef = NULL;
    
    [_laContact evaluateAccessControl:secRef operation:LAAccessControlOperationUseKeySign localizedReason:@"localizeReason" reply:^(BOOL success, NSError * _Nullable error) {
        
    }];
}

- (void)setCredential {
    [_laContact setCredential:[[NSData alloc] init] type:LACredentialTypeApplicationPassword];
}


#pragma mark - Actions

- (IBAction)onTap:(UIButton *)sender {
    [_laContact invalidate];
    if (_loginState == LoginState_Default) {
        _laContact = [[LAContext alloc] init];
        [_laContact evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"登录" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"success");
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.loginState = success ? LoginState_Logedin : LoginState_Default;
                });
            } else {
                // 6.根据用户授权状态进行下一步操作
                switch (error.code) {
                    case LAErrorUserCancel:
                        NSLog(@"用户取消了授权 - %@", error.localizedDescription);
                        break;
                    case LAErrorUserFallback:
                        NSLog(@"用户点击了“输入密码”按钮 - %@", error.localizedDescription);
                        break;
                    case LAErrorAuthenticationFailed:
                        NSLog(@"您已授权失败3次 - %@", error.localizedDescription);
                        break;
                    case LAErrorSystemCancel:
                        NSLog(@"应用程序进入后台 - %@", error.localizedDescription);
                        break;
                    default:
                        NSLog(@"++%@--%zd", error.localizedDescription, error.code);
                        break;
                }
            }
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
