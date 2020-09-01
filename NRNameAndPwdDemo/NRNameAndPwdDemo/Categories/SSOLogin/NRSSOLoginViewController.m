//
//  NRSSOLoginViewController.m
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/26.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRSSOLoginViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>

@interface NRSSOLoginViewController () <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@property (weak, nonatomic) IBOutlet UITextField *urlField;

@end

@implementation NRSSOLoginViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Actions

- (IBAction)sign:(id)sender {
    NSString* path = [self.urlField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (path && path.length > 0) {
        NSURL* url = [NSURL URLWithString:path];
        ASAuthorizationSingleSignOnProvider* singleSignOnProvider = [ASAuthorizationSingleSignOnProvider authorizationProviderWithIdentityProviderURL:url];
//        if ([singleSignOnProvider canPerformAuthorization]) {
            ASAuthorizationSingleSignOnRequest* singleSignOnRequest = [singleSignOnProvider createRequest];
//            singleSignOnRequest.authorizationOptions = @[[NSURLQueryItem queryItemWithName:@"client_id" value:@"test"]];
            singleSignOnRequest.requestedScopes = @[ASAuthorizationScopeEmail, ASAuthorizationScopeFullName];
            ASAuthorizationController* authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[singleSignOnRequest]];
            authorizationController.delegate = self;
            authorizationController.presentationContextProvider = self;
            [authorizationController performRequests];
//        } else {
//            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Single Sign-On" message:[NSString stringWithFormat:@"can't authorization url: %@", url] preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
//            [self presentViewController:alertController animated:YES completion:nil];
//        }
    }
}

#pragma mark - ASAuthorizationControllerDelegate

// 完成认证
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization {
#warning 回调不是在主线程执行
    // 单点登录
    if ([authorization.credential isKindOfClass:[ASAuthorizationSingleSignOnCredential class]]) {
        ASAuthorizationSingleSignOnCredential* singleSignOnCredential = authorization.credential;
        
        NSString* state = singleSignOnCredential.state;
        NSData* accessToken = singleSignOnCredential.accessToken;
        NSData* identifyToken = singleSignOnCredential.identityToken;
        NSHTTPURLResponse* response = singleSignOnCredential.authenticatedResponse;
        
        NSString* descriptionString = [NSString stringWithFormat:@"state: %@\naccessToken: %@\nidentifyToken: %@\nresponse: %@", state, [[NSString alloc] initWithData:accessToken encoding:NSUTF8StringEncoding], [[NSString alloc] initWithData:identifyToken encoding:NSUTF8StringEncoding], response];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController* alertControl = [UIAlertController alertControllerWithTitle:@"SSO Result" message:descriptionString preferredStyle:UIAlertControllerStyleAlert];
            [alertControl addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertControl animated:YES completion:nil];
        });
    }
}

// 认证失败
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController* alertControl = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", error] preferredStyle:UIAlertControllerStyleAlert];
        [alertControl addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertControl animated:YES completion:nil];
    });
}

#pragma mark - ASAuthorizationControllerPresentationContextProviding

// 返回最适合呈现授权UI的视图锚点，如果凭据提供需要用户交互，则此视图用作提示
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller {
    return self.view.window;
}

@end
