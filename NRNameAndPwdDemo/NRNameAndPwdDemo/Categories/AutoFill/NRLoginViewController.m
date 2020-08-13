//
//  NRLoginViewController.m
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/12.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRLoginViewController.h"
#import "NRTextInputViewController.h"
#import "NRLoginModel.h"

@interface NRLoginViewController () <UITextFieldDelegate>
{
    NRLoginModel *_loginModel;
    OnStateChange _onStateChange;
}

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation NRLoginViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self nr_initial];
    
}

#pragma mark - Private

- (void)nr_initial {
    __weak typeof(self) weakSelf = self;
    _onStateChange = ^(NSString * _Nullable userName, NSString * _Nullable pwd, NSString * _Nullable passwordRules, BOOL startLogi) {
        weakSelf.pwdField.passwordRules = [UITextInputPasswordRules passwordRulesWithDescriptor:passwordRules];
    };
    [self loginModel];
}

#pragma mark - Actions

- (IBAction)login:(UIButton *)sender {
    
}

- (IBAction)updatePasswordRule:(id)sender {
    NRTextInputViewController* textInput = [NRTextInputViewController new];
    textInput.initialText = _loginModel.passwordRules;
    textInput.onDone = ^(NRTextInputViewController *controller, NSString *text) {
        self->_loginModel.passwordRules = text;
        [controller dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:textInput animated:YES completion:nil];
}


- (IBAction)regist:(id)sender {
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"fullText: %@,\nrange: %@,\nreplacementString: %@", textField.text, NSStringFromRange(range), string);
    NSLog(@"passwordRules: %@", _pwdField.passwordRules.passwordRulesDescriptor);
    return YES;
}

#pragma mark - Properties

- (NRLoginModel *)loginModel {
    if (!_loginModel) {
        _loginModel = [[NRLoginModel alloc] initWithStateChange:_onStateChange];
    }
    return _loginModel;
}

@end
