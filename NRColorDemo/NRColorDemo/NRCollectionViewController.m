//
//  NRCollectionViewController.m
//  NRColorDemo
//
//  Created by 王文涛 on 2020/8/18.
//  Copyright © 2020 王文涛. All rights reserved.
//

#import "NRCollectionViewController.h"
#import "NRCollectionViewCell.h"
#import "NRCollectionReusableView.h"

@interface NRCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray <NRColorItem *> *colors;

@property (nonatomic, strong) NSArray <NSArray<NRColorItem *> *>*groupedColors;

@property (nonatomic, strong) NSArray <NSString *>*categorys;

@end

@implementation NRCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib* nib = [UINib nibWithNibName:NSStringFromClass([NRCollectionViewCell class]) bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([NRCollectionViewCell class])];
    UINib* reuseNib = [UINib nibWithNibName:NSStringFromClass([NRCollectionReusableView class]) bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:reuseNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([NRCollectionReusableView class])];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.groupedColors.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.groupedColors[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NRColorItem *item = [self.colors objectAtIndex:indexPath.row];
    NRColorItem *item = [self.groupedColors[indexPath.section] objectAtIndex:indexPath.row];
    NRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NRCollectionViewCell class]) forIndexPath:indexPath];
    if (indexPath.section == 1) {
        cell.titleLabel.text = item.colorDescription;
        cell.titleLabel.textColor = item.color;
        cell.contentView.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        cell.titleLabel.text = item.colorDescription;
        cell.contentView.backgroundColor = item.color;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NRCollectionReusableView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([NRCollectionReusableView class]) forIndexPath:indexPath];
        [headerView.titleLabel setText:self.categorys[indexPath.section]];
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(collectionView.frame.size.width, 50);
}

#pragma mark <UICollectionViewDelegate>

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(collectionView.frame.size.width/2, 100);
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return UICollectionViewFlowLayoutAutomaticSize;
//}

#pragma mark - Properties

- (NSArray<NRColorItem *> *)colors {
    if (!_colors) {
        _colors = @[
            [[NRColorItem alloc] initWithColor:[UIColor systemRedColor] description:@"systemRedColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGreenColor] description:@"systemGreenColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemBlueColor] description:@"systemBlueColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemOrangeColor] description:@"systemOrangeColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemYellowColor] description:@"systemYellowColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemPinkColor] description:@"systemPinkColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemPurpleColor] description:@"systemPurpleColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemTealColor] description:@"systemTealColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemIndigoColor] description:@"systemIndigoColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGrayColor] description:@"systemGrayColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGray2Color] description:@"systemGray2Color"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGray3Color] description:@"systemGray3Color"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGray4Color] description:@"systemGray4Color"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGray5Color] description:@"systemGray5Color"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGray6Color] description:@"systemGray6Color"],
            [[NRColorItem alloc] initWithColor:[UIColor labelColor] description:@"labelColor"],
            [[NRColorItem alloc] initWithColor:[UIColor secondaryLabelColor] description:@"secondaryLabelColor"],
            [[NRColorItem alloc] initWithColor:[UIColor tertiaryLabelColor] description:@"tertiaryLabelColor"],
            [[NRColorItem alloc] initWithColor:[UIColor quaternaryLabelColor] description:@"quaternaryLabelColor"],
            [[NRColorItem alloc] initWithColor:[UIColor linkColor] description:@"linkColor"],
            [[NRColorItem alloc] initWithColor:[UIColor placeholderTextColor] description:@"placeholderTextColor"],
            [[NRColorItem alloc] initWithColor:[UIColor separatorColor] description:@"separatorColor"],
            [[NRColorItem alloc] initWithColor:[UIColor opaqueSeparatorColor] description:@"opaqueSeparatorColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemBackgroundColor] description:@"systemBackgroundColor"],
            [[NRColorItem alloc] initWithColor:[UIColor secondarySystemBackgroundColor] description:@"secondarySystemBackgroundColor"],
            [[NRColorItem alloc] initWithColor:[UIColor tertiarySystemBackgroundColor] description:@"tertiarySystemBackgroundColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGroupedBackgroundColor] description:@"systemGroupedBackgroundColor"],
            [[NRColorItem alloc] initWithColor:[UIColor secondarySystemGroupedBackgroundColor] description:@"secondarySystemGroupedBackgroundColor"],
            [[NRColorItem alloc] initWithColor:[UIColor tertiarySystemGroupedBackgroundColor] description:@"tertiarySystemGroupedBackgroundColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemFillColor] description:@"systemFillColor"],
            [[NRColorItem alloc] initWithColor:[UIColor secondarySystemFillColor] description:@"secondarySystemFillColor"],
            [[NRColorItem alloc] initWithColor:[UIColor tertiarySystemFillColor] description:@"tertiarySystemFillColor"],
            [[NRColorItem alloc] initWithColor:[UIColor quaternarySystemFillColor] description:@"quaternarySystemFillColor"],
        ];
    }
    return _colors;
}

- (NSArray<NSArray<NRColorItem *> *> *)groupedColors {
    if (!_groupedColors) {
        _groupedColors = @[
        @[
            [[NRColorItem alloc] initWithColor:[UIColor systemRedColor] description:@"systemRedColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGreenColor] description:@"systemGreenColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemBlueColor] description:@"systemBlueColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemOrangeColor] description:@"systemOrangeColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemYellowColor] description:@"systemYellowColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemPinkColor] description:@"systemPinkColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemPurpleColor] description:@"systemPurpleColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemTealColor] description:@"systemTealColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemIndigoColor] description:@"systemIndigoColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGrayColor] description:@"systemGrayColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGray2Color] description:@"systemGray2Color"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGray3Color] description:@"systemGray3Color"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGray4Color] description:@"systemGray4Color"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGray5Color] description:@"systemGray5Color"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGray6Color] description:@"systemGray6Color"],
        ],
        @[
            [[NRColorItem alloc] initWithColor:[UIColor labelColor] description:@"labelColor"],
            [[NRColorItem alloc] initWithColor:[UIColor secondaryLabelColor] description:@"secondaryLabelColor"],
            [[NRColorItem alloc] initWithColor:[UIColor tertiaryLabelColor] description:@"tertiaryLabelColor"],
            [[NRColorItem alloc] initWithColor:[UIColor quaternaryLabelColor] description:@"quaternaryLabelColor"],
            [[NRColorItem alloc] initWithColor:[UIColor linkColor] description:@"linkColor"],
            [[NRColorItem alloc] initWithColor:[UIColor placeholderTextColor] description:@"placeholderTextColor"],
            [[NRColorItem alloc] initWithColor:[UIColor separatorColor] description:@"separatorColor"],
            [[NRColorItem alloc] initWithColor:[UIColor opaqueSeparatorColor] description:@"opaqueSeparatorColor"],

        ],
        @[
            [[NRColorItem alloc] initWithColor:[UIColor systemBackgroundColor] description:@"systemBackgroundColor"],
            [[NRColorItem alloc] initWithColor:[UIColor secondarySystemBackgroundColor] description:@"secondarySystemBackgroundColor"],
            [[NRColorItem alloc] initWithColor:[UIColor tertiarySystemBackgroundColor] description:@"tertiarySystemBackgroundColor"],
            [[NRColorItem alloc] initWithColor:[UIColor systemGroupedBackgroundColor] description:@"systemGroupedBackgroundColor"],
            [[NRColorItem alloc] initWithColor:[UIColor secondarySystemGroupedBackgroundColor] description:@"secondarySystemGroupedBackgroundColor"],
            [[NRColorItem alloc] initWithColor:[UIColor tertiarySystemGroupedBackgroundColor] description:@"tertiarySystemGroupedBackgroundColor"],
        ],
        @[
            [[NRColorItem alloc] initWithColor:[UIColor systemFillColor] description:@"systemFillColor"],
            [[NRColorItem alloc] initWithColor:[UIColor secondarySystemFillColor] description:@"secondarySystemFillColor"],
            [[NRColorItem alloc] initWithColor:[UIColor tertiarySystemFillColor] description:@"tertiarySystemFillColor"],
            [[NRColorItem alloc] initWithColor:[UIColor quaternarySystemFillColor] description:@"quaternarySystemFillColor"],
        ]];
    }
    return _groupedColors;
}

- (NSArray<NSString *> *)categorys {
    if (!_categorys) {
        _categorys = @[
            @"🌞System Colors",
            @"🌞Foreground Colors",
            @"🌞Background Colors",
            @"🌞Fill Colors",
        ];
    }
    return _categorys;
}

@end

@implementation NRColorItem

- (instancetype)initWithColor:(UIColor *)color description:(NSString *)colorDescription {
    if (self = [super init]) {
        _color = color;
        _colorDescription = colorDescription;
    }
    return self;
}

@end
