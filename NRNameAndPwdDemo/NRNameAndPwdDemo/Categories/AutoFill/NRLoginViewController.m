//
//  NRLoginViewController.m
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/12.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRLoginViewController.h"
#import "NRLoginModel.h"

@interface NRLoginViewController () <UITextFieldDelegate>
{
    NRLoginModel *_loginModel;
}
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@end

@implementation NRLoginViewController

#pragma mark - Life Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - Actions

- (IBAction)login:(UIButton *)sender {
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"fullText: %@,\nrange: %@,\nreplacementString: %@", textField.text, NSStringFromRange(range), string);
    return YES;
}

#pragma mark - Properties

- (NRLoginModel *)loginModel {
    if (!_loginModel) {
        _loginModel = [[NRLoginModel alloc] init];
    }
    return _loginModel;
}

@end
