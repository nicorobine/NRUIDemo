//
//  NRRegistViewController.m
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/13.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRRegistViewController.h"

@interface NRRegistViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@end

@implementation NRRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Actions

- (IBAction)register:(id)sender {
    NSString* fixUserName = [self.userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* fixPassword = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* fixConfirm = [self.confirmPasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLog(@"register:\n userName:%@, password:%@, comfirm:%@", fixUserName, fixPassword, fixConfirm);
    
    [self _dismiss];
}

#pragma mark - Private

- (void)_dismiss {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [_registerButton setUserInteractionEnabled:_userNameField.text.length > 0 && _passwordField.text.length > 0 && _confirmPasswordField.text.length > 0];
}


@end
