//
//  NRKeyChain.h
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/14.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <Foundation/Foundation.h>

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

/**
 * @brief 向钥匙串写入账号和密码
 * @param account 账号
 * @param password 密码
 * @param domain 域名，如www.nicorobine.com，可以为空，如果是NRSecClassValueGenericPassword，则域名无效
 * @param secClassValue 存储类型，这个方法支持NRSecClassValueInternetPassword和NRSecClassValueGenericPassword
 * @return 返回添加的状态
 */
- (BOOL)addAccount:(NSString *)account password:(NSString *)password domain:(NSString * _Nullable)domain secClassValue:(NRSecClassValue)secClassValue;

/**
 * @brief 查询已经存储的项目
 */
- (NRSecQueryResult *)queryAccountAndPasswordWithDomain:(NSString *)domain secClassValue:(NRSecClassValue)secClassValue;

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
