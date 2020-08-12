//
//  NRMainViewController.m
//  NRNameAndPwdDemo
//
//  Created by NicoRobine on 2020/7/31.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRMainViewController.h"
#import "NRMainModel.h"

#import "NRLoginViewController.h"
#import "NRBiometricLoginViewController.h"

@interface NRMainViewController ()

@property (nonatomic, strong) NRMainModel* mainModel;

@end

@implementation NRMainViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _moniteData];
}

#pragma mark - Data

- (void)_moniteData {
    __weak typeof(self) weakSelf = self;
    self.mainModel.onSelected = ^(NRCellInfo * _Nonnull info, NSUInteger index) {
        switch (index) {
            case 0:
                [weakSelf _toBiometricAuth:info];
                break;
            default:
                [weakSelf _toLogin:info];
                break;
        }
    };
}

#pragma mark - Private

- (void)_toBiometricAuth:(NRCellInfo *)info {
    NRBiometricLoginViewController* biometricVC = [[NRBiometricLoginViewController alloc] init];
    [self _showDefualt:biometricVC info:info];
}

- (void)_toLogin:(NRCellInfo *)info {
    NRLoginViewController* loginVC = [[NRLoginViewController alloc] init];
    [self _showDefualt:loginVC info:info];
}

- (void)_showDefualt:(UIViewController *)vc info:(NRCellInfo *)info {
    vc.title = info.title;
    [self.navigationController showViewController:vc sender:self];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mainModel.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NRCellInfo* info = [self.mainModel cellInfoWithIndexPath:indexPath.row];
    [cell.textLabel setText:info.title];
    [cell.detailTextLabel setText:info.subTitle];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.mainModel selectedIndex:indexPath.row];
}

#pragma mark - Properties

- (NRMainModel *)mainModel {
    if (!_mainModel) {
        _mainModel = [[NRMainModel alloc] init];
    }
    return _mainModel;
}

@end
