//
//  NRMainTableViewController.m
//  NRUIDemo
//
//  Created by NicoRobine on 2020/7/6.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRMainTableViewController.h"

#import "NRDocumentPickerViewController.h"

#import "NRDemoItem.h"

@interface NRMainTableViewController ()

@property (nonatomic, strong) NSMutableArray<NRDemoItem *>* dataSource;

@end

@implementation NRMainTableViewController

#pragma mark - Life Cycle


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self _initialData];
}

#pragma mark - Initial

- (void)_initialData {
    self.title = @"NRUIDemo";
    [self.dataSource addObject:[[NRDemoItem alloc] initWithTitle:@"NRDocumentPickerViewController" sutTitle:@"文档选择控制器，可以选择共享的文件和iCloud文件"]];
}

#pragma mark - Private

- (void)_onTapItem:(NRDemoItem *)item {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
    }
    
    NRDemoItem* item = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.subTitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NRDemoItem* item = [self.dataSource objectAtIndex:indexPath.row];
    [self _onTapItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - Getter

- (NSMutableArray<NRDemoItem *> *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}


@end
