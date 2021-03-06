//
//  NRLoginViewController.m
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/12.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRLoginViewController.h"
#import "NRTextInputViewController.h"
#import "NRRegistViewController.h"
#import "NRTextInputViewController.h"
#import "NRLoginModel.h"
#import "NRKeyChain.h"
#import <AuthenticationServices/AuthenticationServices.h>

@interface NRLoginViewController () <UITextFieldDelegate>
{
    NRLoginModel *_loginModel;
    OnStateChange _onStateChange;
}

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *siginButton;

@end

@implementation NRLoginViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self nr_initial];
    [self nr_setupCredentialStore];
    [self nr_saveWebCredential];
}

#pragma mark - Private

- (void)nr_initial {
    __weak typeof(self) weakSelf = self;
    _onStateChange = ^(NSString * _Nullable userName, NSString * _Nullable pwd, NSString * _Nullable passwordRules, NRLoginState logiState) {
        weakSelf.pwdField.passwordRules = [UITextInputPasswordRules passwordRulesWithDescriptor:passwordRules];
    };
    [self loginModel];
}

// 可能是开发者账号的问题，不支持存储账号
- (void)nr_setupCredentialStore {
    [[ASCredentialIdentityStore sharedStore] getCredentialIdentityStoreStateWithCompletion:^(ASCredentialIdentityStoreState * _Nonnull state) {
        NSLog(@"credential identity store state: %@", state);
    }];
    ASCredentialServiceIdentifier* credentialServiceIdentifier = [[ASCredentialServiceIdentifier alloc] initWithIdentifier:@"com.nicorobine.wwt" type:ASCredentialServiceIdentifierTypeDomain];
    ASPasswordCredentialIdentity* passwordCredentialIdentity = [[ASPasswordCredentialIdentity alloc] initWithServiceIdentifier:credentialServiceIdentifier user:@"nicorobine" recordIdentifier:@"nicorobine_identifier"];
    [[ASCredentialIdentityStore sharedStore] saveCredentialIdentities:@[passwordCredentialIdentity] completion:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"success: %@ error: %@", @(success), error);
    }];
}

// 储存Web共享凭据
- (void)nr_saveWebCredential {
    SecAddSharedWebCredential(CFStringCreateWithCString(NULL, "nicorobine.github.io", kCFStringEncodingUTF8), CFStringCreateWithCString(nil, "nicorobine", kCFStringEncodingUTF8), CFStringCreateWithCString(nil, "123456", kCFStringEncodingUTF8), ^(CFErrorRef  _Nullable error) {
        if (error) {
            NSLog(@"%@", (__bridge NSError *)error);
        } else {
            NSLog(@"Save Web Credential success");
        }
    });
}

// 获取Web共享凭据
- (NSString *)nr_getWebCredential {
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    SecRequestSharedWebCredential(NULL, NULL, ^(CFArrayRef  _Nullable credentials, CFErrorRef  _Nullable error) {
        if (error) {
            NSLog(@"%@", (__bridge NSError *)error);
        } else {
            BOOL success = NO;
            CFStringRef server = NULL;
            CFStringRef userName = NULL;
            CFStringRef password = NULL;
            
            if (CFArrayGetCount(credentials) > 0) {
                CFDictionaryRef credentialDict = CFArrayGetValueAtIndex(credentials, 0);
                server = CFDictionaryGetValue(credentialDict, kSecAttrServer);
                userName = CFDictionaryGetValue(credentialDict, kSecAttrAccount);
                password = CFDictionaryGetValue(credentialDict, kSecSharedPassword);
                
                if (server) {
                    [result appendString:@"域名："];
                    [result appendString:(__bridge NSString *)server];
                }
                
                if (userName) {
                    [result appendString:@" 用户名："];
                    [result appendString:(__bridge NSString *)userName];
                }
                
                if (password) {
                    [result appendString:@" 密码："];
                    [result appendString:(__bridge NSString *)password];
                }
                
                // 接下来执行登录
                success = YES;
                
                if (success) {
                    // 将凭据保存到钥匙串
                } else {
                    // 提示用户输入账号密码
                }
            }
        }
    });
    return result;
}

#pragma mark - Actions

- (IBAction)login:(UIButton *)sender {
    [_loginModel autoLoginWhenNoCredentialsAccount:^NSString * _Nonnull{
        return self.accountField.text;
    } password:^NSString * _Nonnull{
        return self.pwdField.text;
    }];
}

- (IBAction)updatePasswordRule:(id)sender {
    NRTextInputViewController* textInput = [NRTextInputViewController new];
    textInput.initialText = _loginModel.passwordRules;
    textInput.onDone = ^(NRTextInputViewController *controller, NSString *text) {
        self->_loginModel.passwordRules = text;
        [controller dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:textInput animated:YES completion:nil];
}


- (IBAction)regist:(id)sender {
    NRRegistViewController* registVC = [[NRRegistViewController alloc] init];
    registVC.title = @"注册";
    [self.navigationController pushViewController:registVC animated:YES];
}

- (IBAction)clearCache:(id)sender {
    [_loginModel clearKeychainCache];
}

- (IBAction)getCode:(id)sender {
    NRTextInputViewController* textInputVC = [[NRTextInputViewController alloc] init];
    textInputVC.initialText = [self nr_getWebCredential];
    [self.navigationController presentViewController:textInputVC animated:YES completion:nil];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"fullText: %@,\nrange: %@,\nreplacementString: %@", textField.text, NSStringFromRange(range), string);
    NSLog(@"passwordRules: %@", _pwdField.passwordRules.passwordRulesDescriptor);
    [_siginButton setUserInteractionEnabled:_accountField.text.length > 0 && _pwdField.text.length > 0];
    return YES;
}

#pragma mark - Properties

- (NRLoginModel *)loginModel {
    if (!_loginModel) {
        _loginModel = [[NRLoginModel alloc] initWithStateChange:_onStateChange];
    }
    return _loginModel;
}

@end
