//
//  NRFilteringViewController.h
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/2.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRProduct.h"
#import "NRSearchResultViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NRFilteringViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray<NRProduct *>* products;

@property (nonatomic, strong) UISearchController* searchController;

@end

NS_ASSUME_NONNULL_END
