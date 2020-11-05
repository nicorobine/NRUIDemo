//
//  NRFilteringViewController+Updating.m
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/5.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRFilteringViewController+Updating.h"

@implementation NRFilteringViewController (Updating)

- (NSPredicate *)findMatches:(NSString *)searchString {
    
    NSMutableArray<NSPredicate *>* searchItemsPredicate = @[].mutableCopy;
    
    // 产品title
    NSExpression* titleExpression = [NSExpression expressionForKeyPath:@"title"];
    NSExpression* searchStringExpression = [NSExpression expressionForConstantValue:searchString];
    
    // 比较标题的谓词
    NSPredicate* titleSearchPredicate = [NSComparisonPredicate predicateWithLeftExpression:titleExpression rightExpression:searchStringExpression modifier:NSDirectPredicateModifier type:NSContainsPredicateOperatorType options:NSCaseInsensitivePredicateOption | NSDiacriticInsensitivePredicateOption];
    
    // 添加标题谓词
    [searchItemsPredicate addObject:titleSearchPredicate];
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterNoStyle;
    numberFormatter.formatterBehavior = NSNumberFormatterBehaviorDefault;
    [numberFormatter numberFromString:searchString];
    
    NSNumber* targetNumber = [numberFormatter numberFromString:searchString];
    if (targetNumber) {
        NSExpression* targetNumberExpression = [NSExpression expressionForConstantValue:targetNumber];
        NSExpression* yearExpression = [NSExpression expressionForKeyPath:@"yearIntroduced"];
        NSPredicate* yearPredicate = [NSComparisonPredicate predicateWithLeftExpression:targetNumberExpression rightExpression:yearExpression modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSNormalizedPredicateOption];
        [searchItemsPredicate addObject:yearPredicate];
        
        NSExpression* priceExpression= [NSExpression expressionForKeyPath:@"introPrice"];
        NSPredicate* pricePredicate = [NSComparisonPredicate predicateWithLeftExpression:targetNumberExpression rightExpression:priceExpression modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSNormalizedPredicateOption];
        [searchItemsPredicate addObject:pricePredicate];
    }
    
    NSPredicate* finalPredicate;
    
    NSInteger selectedScopeButtonIndex = self.searchController.searchBar.selectedScopeButtonIndex;
    if (selectedScopeButtonIndex > 0) {
        if ([searchItemsPredicate count] > 0) {
            NSCompoundPredicate* compoundPredicate_1 = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
            NSPredicate* typePredicate = [NSPredicate predicateWithFormat:@"SELF.type == %@", @(selectedScopeButtonIndex)];
            finalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[compoundPredicate_1, typePredicate]];
        } else {
            finalPredicate = [NSCompoundPredicate predicateWithFormat:@"SELF.type == %@", @(selectedScopeButtonIndex)];
        }
    } else {
        finalPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
    }
    
    return finalPredicate;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSArray* searchResults = [self.products copy];
    
    NSString* strippedString = [searchController.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray<NSString *>* searchItems = [strippedString componentsSeparatedByString:@" "];
    
    NSMutableArray<NSPredicate *>* predicates = @[].mutableCopy;
    for (NSString* searchString in searchItems) {
        [predicates addObject:[self findMatches:searchString]];
    }
    
    NSCompoundPredicate* finalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    
    NSArray* filterResults = [searchResults filteredArrayUsingPredicate:finalPredicate];
    if (searchController.searchResultsController) {
        NRSearchResultViewController* resultsController = (NRSearchResultViewController *)searchController.searchResultsController;
        resultsController.filteredProducts = filterResults.mutableCopy;
        [resultsController.tableView reloadData];
    }
}

@end
