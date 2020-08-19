//
//  NRColorSettingViewController.m
//  NRColorDemo
//
//  Created by NicoRobine on 2020/8/19.
//  Copyright © 2020 王文涛. All rights reserved.
//

#import "NRColorSettingViewController.h"

@interface NRColorSettingViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *followSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *manualSwitch;

@end

@implementation NRColorSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Private

- (void)nr_switch {
    [self nr_switchUserInderfaceStyle:self.manualSwitch.isOn ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight];
}

- (void)nr_switchUserInderfaceStyle:(UIUserInterfaceStyle)style {
    [UIApplication sharedApplication].windows.firstObject.overrideUserInterfaceStyle = style;
}

#pragma mark - Actions

- (IBAction)nr_close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)flowChanged:(UISwitch *)sender {
    [self.manualSwitch setUserInteractionEnabled:!sender.isOn];
    if (sender.isOn) {
        [self nr_switchUserInderfaceStyle:UITraitCollection.currentTraitCollection.userInterfaceStyle];
    } else {
        [self nr_switch];
    }
}

- (IBAction)manualChanged:(UISwitch *)sender {
    [self nr_switch];
}


@end
