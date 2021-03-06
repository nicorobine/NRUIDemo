//
//  NRKeyChain.m
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/14.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRKeyChain.h"
#import <CoreFoundation/CoreFoundation.h>
#import <Security/Security.h>
#import <LocalAuthentication/LocalAuthentication.h>

@implementation NRKeyChain

#pragma mark - Public

+ (instancetype)shared {
    static NRKeyChain* sharedKeyChain;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedKeyChain = [[NRKeyChain alloc] init];
    });
    return sharedKeyChain;
}

- (BOOL)addAccount:(NSString *)account password:(NSString * _Nullable)password domain:(NSString *)domain secClassValue:(NRSecClassValue)secClassValue  {
    CFMutableDictionaryRef attributes = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, nil, nil);
    
    CFDictionarySetValue(attributes, kSecClass, [self nr_convertSecValue:secClassValue]);
    
    if (account) {
        CFDictionarySetValue(attributes, kSecAttrAccount, (__bridge CFStringRef)account);
    }
    if (password) {
        NSData* passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
        CFDictionarySetValue(attributes, kSecValueData, (__bridge CFDataRef)passwordData);
    }
    if (domain && NRSecClassValueInternetPassword == secClassValue) {
        CFDictionarySetValue(attributes, kSecAttrServer, (__bridge CFStringRef)domain);
    }
    OSStatus status = SecItemAdd(attributes, nil);
    
    CFRelease(attributes);
    
    return errSecSuccess == status;
}

- (NRSecQueryResult *)queryAccountAndPasswordWithDomain:(NSString *)domain secClassValue:(NRSecClassValue)secClassValue {
    CFMutableDictionaryRef attributes = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, nil, nil);
    CFDictionarySetValue(attributes, kSecClass, [self nr_convertSecValue:secClassValue]);
    CFDictionarySetValue(attributes, kSecAttrServer, (__bridge CFStringRef)domain);
    CFDictionarySetValue(attributes, kSecMatchLimit, kSecMatchLimitOne);
    CFDictionarySetValue(attributes, kSecReturnAttributes, kCFBooleanTrue);
    CFDictionarySetValue(attributes, kSecReturnData, kCFBooleanTrue);
    
    CFTypeRef item;
    
    OSStatus status = SecItemCopyMatching(attributes, &item);
    
    NRSecQueryResult *result = [[NRSecQueryResult alloc] initWithStatus:status];
    
    if (!result.hasItem) {
        return result;
    } else {
        if (CFDictionaryGetTypeID() == CFGetTypeID(item)) {
            result.result = (__bridge NSDictionary *)item;
            CFDictionaryRef resultData = item;
            NSData* passwordData = (__bridge NSData *)CFDictionaryGetValue(resultData, kSecValueData);
            NSString* account = (__bridge NSString *)CFDictionaryGetValue(resultData, kSecAttrAccount);
            NSLog(@"passwordData: %@, account: %@", [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding], account);
        }
    }
    
    CFRelease(attributes);
    
    return result;
}

- (BOOL)updateAccountAndPasswordWithDomain:(NSString *)domain secClassValue:(NRSecClassValue)secClassValue withNewAccount:(nonnull NSString *)newAccount andPassword:(nonnull NSString *)password {
    
    CFMutableDictionaryRef query = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, nil, nil);
    CFDictionaryAddValue(query, kSecAttrServer, (__bridge CFStringRef)domain);
    CFDictionaryAddValue(query, kSecClass, [self nr_convertSecValue:secClassValue]);
    
    CFMutableDictionaryRef attributesToUpdate = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 2, nil, nil);
    CFDictionaryAddValue(attributesToUpdate, kSecAttrAccount, (__bridge CFStringRef)newAccount);
    CFDictionaryAddValue(attributesToUpdate, kSecValueData, (__bridge CFDataRef)[password dataUsingEncoding:NSUTF8StringEncoding]);
    
    OSStatus status = SecItemUpdate(query, attributesToUpdate);
    
    CFRelease(query);
    
    return errSecSuccess == status;
}

- (BOOL)deleteAccountAndPasswordWithDomain:(NSString *)domain secClassValue:(NRSecClassValue)secClassValue {
    CFMutableDictionaryRef query = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, nil, nil);
    CFDictionaryAddValue(query, kSecAttrServer, (__bridge CFStringRef)domain);
    CFDictionaryAddValue(query, kSecClass, [self nr_convertSecValue:secClassValue]);
    
    OSStatus status = SecItemDelete(query);
    
    CFRelease(query);
    
    return errSecSuccess == status;
}

#pragma mark - 结合LocalAuthentication

- (BOOL)addAccount:(NSString *)account password:(NSString * _Nullable)password domain:(NSString * _Nullable)domain secClassValue:(NRSecClassValue)secClassValue context:(LAContext *)context {
    
    // 只有设备设置了密码才可以访问
    // 可以使用Touch ID或者Face ID访问
    SecAccessControlRef accessControl = SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, kSecAccessControlUserPresence, nil);
    
    CFMutableDictionaryRef attributes = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, nil, nil);
    CFDictionaryAddValue(attributes, kSecAttrAccessControl, accessControl);
    CFDictionaryAddValue(attributes, kSecUseAuthenticationContext, (__bridge CFTypeRef)context);
    CFDictionarySetValue(attributes, kSecClass, [self nr_convertSecValue:secClassValue]);
    if (account) {
        CFDictionarySetValue(attributes, kSecAttrAccount, (__bridge CFStringRef)account);
    }
    if (password) {
        NSData* passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
        CFDictionarySetValue(attributes, kSecValueData, (__bridge CFDataRef)passwordData);
    }
    if (domain && NRSecClassValueInternetPassword == secClassValue) {
        CFDictionarySetValue(attributes, kSecAttrServer, (__bridge CFStringRef)domain);
    }
    
    OSStatus status = SecItemAdd(attributes, nil);
    
    CFRelease(attributes);
    
    return  errSecSuccess == status;
}

#pragma mark - Private

- (CFStringRef)nr_convertSecValue:(NRSecClassValue)secClassValue {
    switch (secClassValue) {
        case NRSecClassValueInternetPassword:
            return kSecClassInternetPassword;
            break;
        case NRSecClassValueGenericPassword:
            return kSecClassGenericPassword;
            break;
        case NRSecClassValueKey:
            return kSecClassKey;
            break;
        case NRSecClassValueCertificate:
            return kSecClassCertificate;
            break;
        case NRSecClassValueIdentity:
            return kSecClassIdentity;
            break;
        default:
            break;
    }
}

@end

@implementation NRSecQueryResult

- (instancetype)initWithStatus:(OSStatus)status {
    if (self = [super init]) {
        _status = status;
    }
    return self;
}

- (BOOL)hasItem {
    return errSecItemNotFound != self.status;
}

- (BOOL)success {
    return errSecSuccess == self.status;
}

- (NSString *)account {
    if ([_result isKindOfClass:[NSDictionary class]]) {
        return [_result objectForKey:(__bridge NSString *)kSecAttrAccount];
    }
    return nil;
}

- (NSData *)passwordData {
    if ([_result isKindOfClass:[NSDictionary class]]) {
        return [_result objectForKey:(__bridge NSString *)kSecValueData];
    }
    return nil;
}

- (NSString *)password {
    NSData *data = self.passwordData;
    if (data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
