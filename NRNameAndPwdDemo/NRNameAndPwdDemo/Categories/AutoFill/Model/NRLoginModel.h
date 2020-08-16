//
//  NRLoginModel.h
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/12.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NRLoginState) {
    NRLoginStateDefault,
    NRLoginStateLogginngIn,
    NRLoginStateLogged,
    NRLoginStateError,
};

typedef void (^OnStateChange)(NSString * _Nullable userName, NSString * _Nullable pwd, NSString * _Nullable passwordRules, NRLoginState loginState);

NS_ASSUME_NONNULL_BEGIN

@interface NRLoginModel : NSObject

@property (nonatomic, copy, nullable) NSString *userName;

@property (nonatomic, copy, nullable) NSString *pwd;

@property (nonatomic, copy, nullable) NSString *passwordRules;

@property (nonatomic, readonly) NSString *domain;

@property (nonatomic, readonly) NRLoginState loginState;

@property (nonatomic, copy, nullable) OnStateChange onStateChange;

/**
 * @brief 自动登录
 * @discussion 如果钥匙串存储了登录信息，则直接登录，如果没有则需要在account和password回调中提供密码
 * @param account 要登录的账号
 * @param password 登录密码
 */
- (BOOL)autoLoginWhenNoCredentialsAccount:(NSString* (^) (void))account password:(NSString* (^) (void))password;

/**
 * @brief 使用账号密码登录
 * @param account 账号
 * @param password 密码
 * @param addCredential 是否加入钥匙串
 */
- (void)logInWithAccount:(NSString *)account password:(NSString *)password addCredential:(BOOL)addCredential;

- (instancetype)initWithStateChange:(OnStateChange)change;

@end

NS_ASSUME_NONNULL_END
