//
//  NRCollectionViewController.m
//  NRColorDemo
//
//  Created by 王文涛 on 2020/8/18.
//  Copyright © 2020 王文涛. All rights reserved.
//

#import "NRCollectionViewController.h"
#import "NRCollectionViewCell.h"

@interface NRCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray <NRColorItem *> *colors;

@end

@implementation NRCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib* nib = [UINib nibWithNibName:NSStringFromClass([NRCollectionViewCell class]) bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([NRCollectionViewCell class])];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NRColorItem *item = [self.colors objectAtIndex:indexPath.row];
    NRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NRCollectionViewCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = item.colorDescription;
    cell.contentView.backgroundColor = item.color;
    return cell;
}

#pragma mark <UICollectionViewDelegate>

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width/2, 100);
}

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
