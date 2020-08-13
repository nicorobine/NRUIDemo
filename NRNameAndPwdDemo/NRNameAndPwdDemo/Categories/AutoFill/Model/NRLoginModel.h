//
//  NRLoginModel.h
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/12.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OnStateChange)(NSString * _Nullable userName, NSString * _Nullable pwd, NSString * _Nullable passwordRules, BOOL startLogin);

NS_ASSUME_NONNULL_BEGIN

@interface NRLoginModel : NSObject

@property (nonatomic, copy, nullable) NSString *userName;

@property (nonatomic, copy, nullable) NSString *pwd;

@property (nonatomic, copy, nullable) NSString *passwordRules;

@property (nonatomic, copy, nullable) OnStateChange onStateChange;

- (void)logIn;

- (instancetype)initWithStateChange:(OnStateChange)change;

@end

NS_ASSUME_NONNULL_END
