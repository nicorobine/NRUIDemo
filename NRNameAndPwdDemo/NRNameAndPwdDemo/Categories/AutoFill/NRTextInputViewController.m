//
//  NRTextInputViewController.m
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/13.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRTextInputViewController.h"

@interface NRTextInputViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation NRTextInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.textField setText:self.initialText];
    
    [self.textField becomeFirstResponder];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (self.onDone) {
        self.onDone(self, textField.text);
    }
    
    return YES;
}


@end
