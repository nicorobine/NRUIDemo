//
//  NRAppleIDLoginViewController.m
//  NRNameAndPwdDemo
//
//  Created by NicoRobine on 2020/8/26.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRAppleIDLoginViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "NRAppleIDLoginResultViewController.h"
#import "NRKeyChain.h"

@interface NRAppleIDLoginViewController () <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding, ASWebAuthenticationPresentationContextProviding>

@property (weak, nonatomic) IBOutlet UIStackView *loginProviderStackView;

@end

@implementation NRAppleIDLoginViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nr_setupProviderLoginView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self nr_performExistingAccountSetupFlows];
}



#pragma mark - Private

// 初始化登录
- (void)nr_setupProviderLoginView {
    ASAuthorizationAppleIDButton* authorizationAppleIDButton = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeDefault authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhite];
    [authorizationAppleIDButton addTarget:self action:@selector(nr_handleAuthorizationAppleIDButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.loginProviderStackView addArrangedSubview:authorizationAppleIDButton];
    
    UIButton* passwordButton = [[UIButton alloc] init];
    [passwordButton setTitle:@"使用密码登录" forState:UIControlStateNormal];
    [passwordButton addTarget:self action:@selector(nr_handleAuthorizationPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.loginProviderStackView addArrangedSubview:passwordButton];
    
    UIButton* webAuthorizationButton = [[UIButton alloc] init];
    [webAuthorizationButton setTitle:@"使用Web验证" forState:UIControlStateNormal];
    [webAuthorizationButton addTarget:self action:@selector(nr_handleAuthorizationWeb) forControlEvents:UIControlEventTouchUpInside];
    [self.loginProviderStackView addArrangedSubview:webAuthorizationButton];
}

// 执行现有账户的设置流程
// 如果找到现有的iCloud钥匙串或者Apple ID 凭证，则提示用户
- (void)nr_performExistingAccountSetupFlows {
    NSArray<ASAuthorizationRequest *> *requestes = @[[[[ASAuthorizationAppleIDProvider alloc] init] createRequest], [[[ASAuthorizationPasswordProvider alloc] init] createRequest]];
    ASAuthorizationController* authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:requestes];
    authorizationController.delegate = self;
    authorizationController.presentationContextProvider = self;
    [authorizationController performRequests];
}

// 从钥匙串获取账户信息，验证凭证的状态
- (void)nr_getCachedCredential {
    NRSecQueryResult* result = [[NRKeyChain shared] queryAccountAndPasswordWithDomain:@"com.nicorobine.applid.test" secClassValue:NRSecClassValueInternetPassword];
    NSString* resultAccount = result.account;
    ASAuthorizationAppleIDProvider* appleIdProvider = [[ASAuthorizationAppleIDProvider alloc] init];
    [appleIdProvider getCredentialStateForUserID:resultAccount completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error) {
        if (ASAuthorizationAppleIDProviderCredentialRevoked == credentialState || ASAuthorizationAppleIDProviderCredentialNotFound == credentialState) {
            
        } else if (ASAuthorizationAppleIDProviderCredentialAuthorized == credentialState) {
                
        }
    }];
}

// 将身份id存入钥匙串
- (BOOL)nr_saveToKeychainOfUserIdentifier:(NSString *)userIdentifier {
    return [[NRKeyChain shared] addAccount:userIdentifier password:nil domain:@"com.nicorobine.applid.test" secClassValue:NRSecClassValueInternetPassword];
}

#pragma mark - Actions

// ASAuthorizationAppleIDButton点击Action
- (void)nr_handleAuthorizationAppleIDButtonPress {
    ASAuthorizationAppleIDProvider* appleIdProvider = [[ASAuthorizationAppleIDProvider alloc] init];
    ASAuthorizationAppleIDRequest* appleIdRequest = [appleIdProvider createRequest];
    
    // 验证范围
    NSArray <ASAuthorizationScope>* authorizationScopes = @[ASAuthorizationScopeEmail, ASAuthorizationScopeFullName];
    appleIdRequest.requestedScopes = authorizationScopes;
    
    // 开始验证
    ASAuthorizationController* authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIdRequest]];
    authorizationController.delegate = self;
    authorizationController.presentationContextProvider = self;
    [authorizationController performRequests];
}

// 密码验证
- (void)nr_handleAuthorizationPassword {
    
    ASAuthorizationPasswordProvider* passwordProvider = [[ASAuthorizationPasswordProvider alloc] init];
    ASAuthorizationPasswordRequest* passwordRequest = passwordProvider.createRequest;
    
    ASAuthorizationController* authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[passwordRequest]];
    authorizationController.delegate = self;
    authorizationController.presentationContextProvider = self;
    [authorizationController performRequests];
}

// 使用页面验证
- (void)nr_handleAuthorizationWeb {
    NSURL* testUrl = [NSURL URLWithString:@"https://www.baidu.com"];
    // 验证页面输入，并验证完凭证后，会重定向，这里设定重定向的scheme，用来判断成功与否
    NSString* callBackScheme = @"https:";
    ASWebAuthenticationSession* session = [[ASWebAuthenticationSession alloc] initWithURL:testUrl callbackURLScheme:callBackScheme completionHandler:^(NSURL * _Nullable callbackURL, NSError * _Nullable error) {
        if (error == nil && [callBackScheme isEqualToString:callbackURL.scheme]) {
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController* alertControl = [UIAlertController alertControllerWithTitle:@"Web Authorization Error" message:[NSString stringWithFormat:@"%@", error] preferredStyle:UIAlertControllerStyleAlert];
                [alertControl addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alertControl animated:YES completion:nil];
            });
        }
    }];
    // 是否是临时的，如果是临时的将不使用任何cookie和缓存，比较安全
    session.prefersEphemeralWebBrowserSession = YES;
    
    // 指定展示的页面
    session.presentationContextProvider = self;
    
    // 开始验证
    [session start];
}

#pragma mark - ASAuthorizationControllerDelegate

// 完成认证
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization {
#warning 回调不是在主线程执行
    // Apple ID凭证
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential* appleIdCredential = authorization.credential;
        NSString* userIdentifier = appleIdCredential.user;
        NSPersonNameComponents* fullName = appleIdCredential.fullName;
        NSString* email = appleIdCredential.email;
        
        
        NRAppleIDLoginResultViewController* resultVC = [[NRAppleIDLoginResultViewController alloc] initWithUserIdentifier:userIdentifier fullName:fullName email:email];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showViewController:resultVC sender:self];
        });
    }
    // 账号密码凭证
    else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        ASPasswordCredential* pwdCredential = authorization.credential;
        NSString* userName = pwdCredential.user;
        NSString* password = pwdCredential.password;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController* alertControl = [UIAlertController alertControllerWithTitle:@"Keychain Credential Received" message:[NSString stringWithFormat:@"The app has received your selected credential from the keychain. \n\n Username: %@\n Password: %@", userName, password] preferredStyle:UIAlertControllerStyleAlert];
            [alertControl addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
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

#pragma mark - ASWebAuthenticationPresentationContextProviding

- (ASPresentationAnchor)presentationAnchorForWebAuthenticationSession:(ASWebAuthenticationSession *)session {
    return self.view.window;
}

@end
