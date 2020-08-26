//
//  NRAppleIDLoginResultViewController.m
//  NRNameAndPwdDemo
//
//  Created by NicoRobine on 2020/8/26.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRAppleIDLoginResultViewController.h"

@interface NRAppleIDLoginResultViewController () {
    NSString* _userIdentifier;
    NSPersonNameComponents* _personName;
    NSString* _email;
}
@property (weak, nonatomic) IBOutlet UILabel *userIdentifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *givenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *familyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation NRAppleIDLoginResultViewController

#pragma mark - Life Cycle

- (instancetype)initWithUserIdentifier:(NSString *)userIdentifier fullName:(NSPersonNameComponents *)fullName email:(NSString *)email {
    if (self = [super init]) {
        _userIdentifier = userIdentifier;
        _personName = fullName;
        _email = email;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nr_initialUI];
}

#pragma mark - UI

- (void)nr_initialUI {
    [self.userIdentifierLabel setText:_userIdentifier];
    [self.givenNameLabel setText:_personName.givenName];
    [self.familyNameLabel setText:_personName.familyName];
    [self.emailLabel setText:_email];
}

#pragma mark - Actions

- (IBAction)signOut:(id)sender {
    
}

@end
