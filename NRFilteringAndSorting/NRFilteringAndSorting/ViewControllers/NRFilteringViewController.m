//
//  NRFilteringViewController.m
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/2.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRFilteringViewController.h"
#import "NRFilteringViewController+DataSource.h"
#import "NRFilteringViewController+Updating.h"

@interface NRFilteringViewController () <UISearchBarDelegate, UISearchControllerDelegate>

@property (nonatomic, strong) NRSearchResultViewController* resultsViewController;

@end

@implementation NRFilteringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    _resultsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NRSearchResultViewController"];
    _resultsViewController.tableView.delegate = self;
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultsViewController];
    _searchController.delegate = self;
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchController.obscuresBackgroundDuringPresentation = NO;
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.scopeButtonTitles = @[@"ALL", @"Birthdays", @"Weddings", @"Funerals"];
    
    self.navigationItem.searchController = _searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    
    self.definesPresentationContext = YES;
    
    [self setUpDataSource];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _searchController.searchBar.scopeButtonTitles.count - 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Birthdays";
            break;
        case 1:
            return @"Weddings";
            break;
        case 2:
            return @"Funerals";
            break;
            
        default:
            break;
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberInSection = 0;
    switch (section) {
        case 0:
            numberInSection = [self quantityForType:NRProductType_Birthdays];
            break;
        case 1:
            numberInSection = [self quantityForType:NRProductType_Weddings];
            break;
        case 2:
            numberInSection = [self quantityForType:NRProductType_Funerals];
            break;
            
        default:
            break;
    }
    return numberInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    NRProduct* product = [self productForIndexPath:indexPath];
    
    cell.textLabel.text = product.title;
    
    NSString* priceString = [product formattedIntroPrice];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ | %@", priceString, @(product.yearIntroduced)];
    
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:_searchController];
}

#pragma mark - UISearchControllerDelegate

- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    
}
@end
