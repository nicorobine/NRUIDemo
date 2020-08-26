//
//  NRAppleIDLoginHelper.m
//  NRNameAndPwdDemo
//
//  Created by NicoRobine on 2020/8/26.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRAppleIDLoginHelper.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "NRKeyChain.h"
#import "NRAppleIDLoginViewController.h"
#import "NRAppleIDLoginResultViewController.h"


@implementation NRAppleIDLoginHelper

+ (void)showAppleIDControllerWithAnchor:(UIViewController *)anchor {
    NRSecQueryResult* result = [[NRKeyChain shared] queryAccountAndPasswordWithDomain:@"com.nicorobine" secClassValue:NRSecClassValueInternetPassword];
    NSString* resultAccount = result.account;
    ASAuthorizationAppleIDProvider* appleIdProvider = [[ASAuthorizationAppleIDProvider alloc] init];
    [appleIdProvider getCredentialStateForUserID:resultAccount completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error) {
        if (ASAuthorizationAppleIDProviderCredentialRevoked == credentialState || ASAuthorizationAppleIDProviderCredentialNotFound == credentialState) {
            [self showLoginWithAnchor:anchor];
        } else if (ASAuthorizationAppleIDProviderCredentialAuthorized == credentialState) {
//            [self showResultWithAnchor:anchor userIdentifier:resultAccount];
        }
    }];
}

+ (void)showLoginWithAnchor:(UIViewController *)anchor {
    [anchor.navigationController pushViewController:[[NRAppleIDLoginViewController alloc] init] animated:YES];
}

@end
