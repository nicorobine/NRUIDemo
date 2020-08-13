//
//  NRLoginModel.m
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/12.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRLoginModel.h"

@implementation NRLoginModel

- (instancetype)init {
    if (self = [super init]) {
        [self nr_setup];
    }
    return self;
}

#pragma mark - Private

- (void)nr_setup {
    _passwordRules = @"required: upper, lower, digit, [-().&@?’#,/&quot;+]; mainlength: 8";
}

#pragma mark - Public

- (void)logIn {
    [self nr_updateState:true];
}

- (void)nr_updateState:(BOOL)startLogin {
    if (self.onStateChange) {
        self.onStateChange(_userName, _pwd, _passwordRules, false);
    }
}

#pragma mark - Properties

- (void)setUserName:(NSString *)userName {
    _userName = userName;
    [self nr_updateState:false];
}

- (void)setPwd:(NSString *)pwd {
    _pwd = pwd;
    [self nr_updateState:false];
}

- (void)setPasswordRules:(NSString *)passwordRules {
    _passwordRules = passwordRules;
    [self nr_updateState:false];
}

@end
