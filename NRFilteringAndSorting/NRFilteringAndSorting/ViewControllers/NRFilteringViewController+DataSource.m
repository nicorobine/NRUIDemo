//
//  NRFilteringViewController+DataSource.m
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/5.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRFilteringViewController+DataSource.h"

@implementation NRFilteringViewController (DataSource)

- (NSInteger)quantityForType:(NRProductType)type {
    NSInteger quantity = 0;
    for (NRProduct* product in self.products) {
        if (product.type == type) {
            quantity += 1;
        }
    }
    return quantity;
}

- (NRProduct *)productForIndexPath:(NSIndexPath *)indexPath {
    NRProduct* product;
    
    NSInteger birthdayCount = [self quantityForType:NRProductType_Birthdays];
    
    switch (indexPath.section) {
        case NRProductType_Birthdays - 1:
            product = self.products[indexPath.row];
            break;
        case NRProductType_Weddings - 1:
            product = self.products[indexPath.row + birthdayCount];
            break;
        case NRProductType_Funerals - 1:
        {
            NSInteger weddingCount = [self quantityForType:NRProductType_Weddings];
            product = self.products[indexPath.row + birthdayCount + weddingCount];
            break;
        }
            
        default:
            break;
    }
    
    return product;
}

- (void)setUpDataSource {
    self.products = @[
        [[NRProduct alloc] initWithTitle:@"Ginger" yearIntroduced:2007 introPrice:49.98 type:NRProductType_Birthdays],
        [[NRProduct alloc] initWithTitle:@"Gladiolus" yearIntroduced:2001 introPrice:49.98 type:NRProductType_Birthdays],
        [[NRProduct alloc] initWithTitle:@"Orchid" yearIntroduced:2007 introPrice:49.98 type:NRProductType_Birthdays],
        [[NRProduct alloc] initWithTitle:@"Geranium" yearIntroduced:2006 introPrice:49.98 type:NRProductType_Birthdays],
        [[NRProduct alloc] initWithTitle:@"Daisy" yearIntroduced:2006 introPrice:49.98 type:NRProductType_Birthdays],
        [[NRProduct alloc] initWithTitle:@"Poinsettia Red" yearIntroduced:1997 introPrice:49.98 type:NRProductType_Weddings],
        [[NRProduct alloc] initWithTitle:@"Poinsettia Pink" yearIntroduced:2006 introPrice:49.98 type:NRProductType_Weddings],
        [[NRProduct alloc] initWithTitle:@"Red Rose" yearIntroduced:2007 introPrice:49.98 type:NRProductType_Weddings],
        [[NRProduct alloc] initWithTitle:@"White Rose" yearIntroduced:2008 introPrice:49.98 type:NRProductType_Weddings],
        [[NRProduct alloc] initWithTitle:@"Tulip" yearIntroduced:2006 introPrice:49.98 type:NRProductType_Weddings],
        [[NRProduct alloc] initWithTitle:@"Carnation Red" yearIntroduced:2008 introPrice:49.98 type:NRProductType_Weddings],
        [[NRProduct alloc] initWithTitle:@"Carnation White" yearIntroduced:2010 introPrice:49.98 type:NRProductType_Funerals],
        [[NRProduct alloc] initWithTitle:@"Sunflower" yearIntroduced:2011 introPrice:49.98 type:NRProductType_Funerals],
        [[NRProduct alloc] initWithTitle:@"Gardenia" yearIntroduced:2010 introPrice:49.98 type:NRProductType_Funerals],
        [[NRProduct alloc] initWithTitle:@"Daffodil" yearIntroduced:2012 introPrice:49.98 type:NRProductType_Funerals]
    ].mutableCopy;
}

@end
