//
//  NRKeyChain.h
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/14.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LAContext;

//extern const CFStringRef kSecClassInternetPassword
//    API_AVAILABLE(macos(10.6), ios(2.0));
//extern const CFStringRef kSecClassGenericPassword
//    API_AVAILABLE(macos(10.7), ios(2.0));
//extern const CFStringRef kSecClassCertificate
//    API_AVAILABLE(macos(10.7), ios(2.0));
//extern const CFStringRef kSecClassKey
//    API_AVAILABLE(macos(10.7), ios(2.0));
//extern const CFStringRef kSecClassIdentity
//    API_AVAILABLE(macos(10.7), ios(2.0));

typedef NS_ENUM(NSUInteger, NRSecClassValue) {
    NRSecClassValueInternetPassword,  // 表示一个Internet密码项目的值
    NRSecClassValueGenericPassword,   // 表示一个通用密码的项目值，相较于NRSecClassValueInternetPassword，不具有远程访问的属性（kSecAttrServer）
    NRSecClassValueCertificate,       // 表示证书项目的值
    NRSecClassValueKey,               // 表示加密密钥项目的值
    NRSecClassValueIdentity,          // 表示身份项目的值
};

NS_ASSUME_NONNULL_BEGIN

@class NRSecQueryResult;

@interface NRKeyChain : NSObject

+ (instancetype)shared;

#pragma mark - 普通钥匙串存储

/**
 * @brief 向钥匙串写入账号和密码
 * @param account 账号
 * @param password 密码
 * @param domain 域名，如www.nicorobine.com，可以为空，如果是NRSecClassValueGenericPassword，则域名无效
 * @param secClassValue 存储类型，这个方法支持NRSecClassValueInternetPassword和NRSecClassValueGenericPassword
 * @return 返回添加的状态
 */
- (BOOL)addAccount:(NSString *)account password:(NSString * _Nullable)password domain:(NSString * _Nullable)domain secClassValue:(NRSecClassValue)secClassValue;

/**
 * @brief 查询已经存储的项目
 * @param domain 要查询的域名
 * @param secClassValue 储存类型
 */
- (NRSecQueryResult *)queryAccountAndPasswordWithDomain:(NSString *)domain secClassValue:(NRSecClassValue)secClassValue;

/**
 * @brief 更新储存的账号和密码
 * @param domain 对应的域名
 * @param secClassValue 类型
 * @param newAccount 新的账号
 * @param password 新的密码
 * @return 更新成功或者失败，如果原来没有存储对应的项目返回失败，更新成功返回成功
 */
- (BOOL)updateAccountAndPasswordWithDomain:(NSString *)domain secClassValue:(NRSecClassValue)secClassValue  withNewAccount:(NSString *)newAccount andPassword:(NSString *)password;

/**
 * @brief 删除指定的项目
 * @param domain 对应的域名
 * @param secClassValue 类型
 * @return 是否删除成功
 * @discussion 项目删除失败或者没有找到项目都会返回失败
 */
- (BOOL)deleteAccountAndPasswordWithDomain:(NSString *)domain secClassValue:(NRSecClassValue)secClassValue;

#pragma mark - 结合LocalAuthentication，钥匙串保存项目时设置条件，如生物验证

/**
 * @brief 向钥匙串写入账号和密码
 * @param account 账号
 * @param password 密码
 * @param domain 域名，如www.nicorobine.com，可以为空，如果是NRSecClassValueGenericPassword，则域名无效
 * @param secClassValue 存储类型，这个方法支持NRSecClassValueInternetPassword和NRSecClassValueGenericPassword
 * @return 返回添加的状态
 */
- (BOOL)addAccount:(NSString *)account password:(NSString * _Nullable)password domain:(NSString * _Nullable)domain secClassValue:(NRSecClassValue)secClassValue context:(LAContext *)context;

@end

// 搜索结果
@interface NRSecQueryResult : NSObject

// 结果的状态
@property (nonatomic, assign) OSStatus status;

// 结果数据
@property (nonatomic, assign) id result;

/**
 * @brief 是否已经存在对应的item
 * @discussion 如果不存在对应的项目，说明钥匙串中还没有存储过对应的数据，可以作为第一次登录的判断
 */
@property (nonatomic, readonly) BOOL hasItem;

/**
 * @brief 查询是否成功了
 */
@property (nonatomic, readonly) BOOL success;

@property (nonatomic, readonly) NSString* account;

@property (nonatomic, readonly) NSData* passwordData;

@property (nonatomic, readonly) NSString* password;


- (instancetype)initWithStatus:(OSStatus)status;

@end

NS_ASSUME_NONNULL_END
