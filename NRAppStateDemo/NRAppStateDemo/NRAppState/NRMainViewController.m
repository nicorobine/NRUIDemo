//
//  NRMainViewController.m
//  NRAppStateDemo
//
//  Created by NicoRobine on 2020/9/2.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRMainViewController.h"

@interface NRMainViewController ()

@property (nonatomic, strong) UIButton* pushButton;

@property (nonatomic, strong) UIButton* secondButton;

@property (nonatomic, strong) UILabel* stateLabel;

@property (nonatomic, strong) NSNumber* stateNumber;

@end

@implementation NRMainViewController

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        [self nr_setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self nr_setup];
        NSNumber* number = [coder decodeObjectForKey:@"stateNumber"];
        if (number) {
            _stateNumber = number;
        }
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self nr_setup];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Initial

- (void)nr_setup {
    self.stateNumber = [NSNumber numberWithInt:0];
}

#pragma mark - configUI

- (void)nr_initialUI {
    [self.view addSubview:self.stateLabel];
    [self.view addSubview:self.pushButton];
    [self.view addSubview:self.secondButton];
    
    [self nr_addConstraints];
}

- (void)nr_addConstraints {
    
}

#pragma mark - Actions

- (void)nr_next {
    
}

- (void)nr_second {
    
}

#pragma mark - Properties

- (UIButton *)pushButton {
    if (!_pushButton) {
        _pushButton = [[UIButton alloc] init];
        [_pushButton setTitle:@"第一个" forState:UIControlStateNormal];
        [_pushButton addTarget:self action:@selector(nr_next) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushButton;
}

- (UIButton *)secondButton {
    if (!_secondButton) {
        _secondButton = [[UIButton alloc] init];
        [_secondButton setTitle:@"第二个" forState:UIControlStateNormal];
        [_secondButton addTarget:self action:@selector(nr_next) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _secondButton;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        [_stateLabel setText:[NSString stringWithFormat:@"state: %@", self.stateNumber]];
    }
    return _stateLabel;
}

@end
