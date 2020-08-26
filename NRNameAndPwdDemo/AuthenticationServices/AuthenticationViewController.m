//
//  AuthenticationViewController.m
//  AuthenticationServices
//
//  Created by 王文涛 on 2020/8/26.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "AuthenticationViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>

@interface AuthenticationViewController () <ASAuthorizationProviderExtensionAuthorizationRequestHandler>

@property ASAuthorizationProviderExtensionAuthorizationRequest *authorizationRequest;

@end

@implementation AuthenticationViewController

- (void)loadView {
    [super loadView];
    // Do any additional setup after loading the view.
}

- (NSString *)nibName {
    return @"AuthenticationViewController";
}

#pragma mark - ASAuthorizationProviderExtensionAuthorizationRequestDelegate

- (void)beginAuthorizationWithRequest:(ASAuthorizationProviderExtensionAuthorizationRequest *)request {
    self.authorizationRequest = request;

    // Call this to indicate immediate authorization succeeded.
    NSDictionary<NSString *, NSString *> *authorizationHeaders = @{}; // TODO: Fill in appropriate authorization headers.
    [request completeWithHTTPAuthorizationHeaders:authorizationHeaders];

    // Or present authorization view and call [self.authorizationRequest complete*:] later after handling interactive authorization.
    // [request presentAuthorizationViewControllerWithCompletion:^(BOOL success, NSError * _Nullable error) {
    //     if (error) {
    //         [request completeWithError:error];
    //     }
    // }];
}

- (void)cancelAuthorizationWithRequest:(ASAuthorizationProviderExtensionAuthorizationRequest *)request {
    [request completeWithError:[NSError errorWithDomain:@"Authentication extension" code:0 userInfo:nil]];
}

@end
