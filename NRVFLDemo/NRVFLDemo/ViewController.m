//
//  ViewController.m
//  NRVFLDemo
//
//  Created by NicoRobine on 2020/9/2.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "ViewController.h"
#import "NRVFLTestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)nr_test1:(id)sender {
    NRVFLTestViewController* vflTest = [[NRVFLTestViewController alloc] init];
    [self.navigationController pushViewController:vflTest animated:YES];
}

@end
