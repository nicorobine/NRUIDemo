//
//  NRLoginModel.m
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/12.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRLoginModel.h"
#import "NRKeyChain.h"

@interface NRLoginModel()

@property (nonatomic, assign) NRLoginState loginState;

@end

@implementation NRLoginModel


- (instancetype)init {
    if (self = [super init]) {
        [self nr_setup];
    }
    return self;
}

- (instancetype)initWithStateChange:(OnStateChange)change {
    if (self = [super init]) {
        self.onStateChange = change;
        [self nr_setup];
    }
    return self;
}

#pragma mark - Private

- (void)nr_setup {
    _loginState = NRLoginStateDefault;
    self.passwordRules = @"required: upper, lower, digit, [-().&@?’#,/&quot;+]; mainlength: 8";
}

#pragma mark - Public

- (BOOL)autoLoginWhenNoCredentialsAccount:(NSString * _Nonnull (^)(void))account password:(NSString * _Nonnull (^)(void))password {
    NRSecQueryResult* result = [[NRKeyChain shared] queryAccountAndPasswordWithDomain:self.domain secClassValue:NRSecClassValueInternetPassword];
   
    if (result.hasItem) {
        [self logInWithAccount:account() password:password() addCredential:NO];
    } else {  // 没有查询到数据，证明还没有往钥匙串写入过
        [self logInWithAccount:account() password:password() addCredential:YES];
        return NO;
    }
    return YES;
}

- (void)logInWithAccount:(NSString *)account password:(NSString *)password addCredential:(BOOL)addCredential {
    _loginState = NRLoginStateLogginngIn;
    
    // 这里是实际的登录操作
    // 假设登录成功
    _loginState = NRLoginStateLogged;
    
    // 将账号密码写入钥匙串
    if (addCredential) {
        [[NRKeyChain shared] addAccount:account password:password domain:self.domain secClassValue:NRSecClassValueInternetPassword];
    }
}

- (void)nr_updateState {
    if (self.onStateChange) {
        self.onStateChange(_userName, _pwd, _passwordRules, _loginState);
    }
}

#pragma mark - Properties

- (void)setUserName:(NSString *)userName {
    _userName = userName;
    [self nr_updateState];
}

- (void)setPwd:(NSString *)pwd {
    _pwd = pwd;
    [self nr_updateState];
}

- (void)setPasswordRules:(NSString *)passwordRules {
    _passwordRules = passwordRules;
    [self nr_updateState];
}

- (NSString *)domain {
    return @"www.nicorobine.com";
}

- (void)setLoginState:(NRLoginState)loginState {
    _loginState = loginState;
    [self nr_updateState];
}

@end
