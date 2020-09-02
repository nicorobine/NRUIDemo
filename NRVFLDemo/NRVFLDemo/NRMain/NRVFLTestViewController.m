//
//  NRVFLTestViewController.m
//  NRVFLDemo
//
//  Created by NicoRobine on 2020/9/2.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRVFLTestViewController.h"

@interface NRVFLTestViewController ()

@property (nonatomic, strong) UIView* redView;

@property (nonatomic, strong) UIView* greenView;

@property (nonatomic, strong) UIView* blueView;

@property (nonatomic, strong) UIView* purpleView;


@end

@implementation NRVFLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nr_initialUI];
    
    [self nr_addConstraints];
}

#pragma mark - UI

- (void)nr_initialUI {
    [self.view addSubview:self.redView];
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.blueView];
    [self.view addSubview:self.purpleView];
}

- (void)nr_addConstraints {
    [self.redView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.greenView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.blueView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.purpleView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    NSString* red_H_vf = @"H:|-[_redView]-|";
//    NSString* red_V_vf = @"V:|-16-[_redView]-|";
    NSDictionary* r_Dict = NSDictionaryOfVariableBindings(_redView);
    NSArray <NSLayoutConstraint *>* redConstraints_H = [NSLayoutConstraint constraintsWithVisualFormat:red_H_vf options:NSLayoutFormatAlignAllLeading metrics:nil views:r_Dict];
//    NSArray <NSLayoutConstraint *>* redConstraints_V = [NSLayoutConstraint constraintsWithVisualFormat:red_V_vf options:0 metrics:nil views:r_Dict];
    [self.view addConstraints:redConstraints_H];
//    [self.view addConstraints:redConstraints_V];
    NSLayoutConstraint* red_h_c = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.3 constant:0];
    [self.view addConstraint:red_h_c];
}

#pragma mark - Properties

- (UIView *)redView {
    if (!_redView) {
        _redView = [UIView new];
        [_redView setBackgroundColor:[UIColor systemRedColor]];
    }
    return _redView;
}

- (UIView *)greenView {
    if (!_greenView) {
        _greenView = [UIView new];
        [_greenView setBackgroundColor:[UIColor systemGreenColor]];
    }
    return _greenView;
}

- (UIView *)blueView {
    if (!_blueView) {
        _blueView = [UIView new];
        [_blueView setBackgroundColor:[UIColor systemBlueColor]];
    }
    return _blueView;
}

- (UIView *)purpleView {
    if (!_purpleView) {
        _purpleView = [UIView new];
        [_purpleView setBackgroundColor:[UIColor systemPurpleColor]];
    }
    return _purpleView;
}

@end
