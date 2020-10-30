//
//  NRSceneTestViewController.m
//  WLAppLifeCycleDemo
//
//  Created by NicoRobine on 2020/10/28.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRSceneTestViewController.h"
#import <UIKit/UISceneSession.h>

@interface NRSceneTestViewController ()

@end

@implementation NRSceneTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)nr_createNewScene:(id)sender {
    
}

- (IBAction)nr_switchSeneOne:(id)sender {
    
    NSUserActivity* activity = [[NSUserActivity alloc] initWithActivityType:@"com.nicorobine.oneScene"];
    activity.targetContentIdentifier = @"com.nicorobine.oneScene";
    
    [[UIApplication sharedApplication] requestSceneSessionActivation:nil userActivity:activity options:nil errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"%s%s error:%@", __FILE_NAME__, __FUNCTION__, error);
    }];
}


@end
