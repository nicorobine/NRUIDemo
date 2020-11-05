//
//  NRFilteringViewController+Updating.h
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/5.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRFilteringViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NRFilteringViewController (Updating)

- (NSPredicate *)findMatches:(NSString *)searchString;

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController;


@end

NS_ASSUME_NONNULL_END
