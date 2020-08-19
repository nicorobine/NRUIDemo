//
//  NRCollectionViewCell.m
//  NRColorDemo
//
//  Created by 王文涛 on 2020/8/18.
//  Copyright © 2020 王文涛. All rights reserved.
//

#import "NRCollectionViewCell.h"

@implementation NRCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.titleLabel setTextColor:[UIColor labelColor]];
    [self setBackgroundColor:[UIColor systemBackgroundColor]];
}

@end
