//
//  NRSearchResultViewController.h
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/5.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRProduct.h"

NS_ASSUME_NONNULL_BEGIN

@interface NRSearchResultViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray<NRProduct *>* filteredProducts;

@end

NS_ASSUME_NONNULL_END
