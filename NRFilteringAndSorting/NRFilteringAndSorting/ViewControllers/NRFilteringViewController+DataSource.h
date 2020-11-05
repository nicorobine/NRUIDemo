//
//  NRFilteringViewController+DataSource.h
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/5.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRFilteringViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NRFilteringViewController (DataSource)

- (void)setUpDataSource;

- (NSInteger)quantityForType:(NRProductType)type;

- (NRProduct *)productForIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
