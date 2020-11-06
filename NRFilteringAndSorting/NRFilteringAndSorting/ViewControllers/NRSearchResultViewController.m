//
//  NRSearchResultViewController.m
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/5.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRSearchResultViewController.h"

@interface NRSearchResultViewController ()

@end

@implementation NRSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _filteredProducts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    NRProduct* product = [_filteredProducts objectAtIndex:indexPath.row];
    
    cell.textLabel.text = product.title;
    
    NSString* priceString = [product formattedIntroPrice];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ | %@", priceString, @(product.yearIntroduced)];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
