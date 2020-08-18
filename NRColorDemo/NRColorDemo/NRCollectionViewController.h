//
//  NRCollectionViewController.h
//  NRColorDemo
//
//  Created by 王文涛 on 2020/8/18.
//  Copyright © 2020 王文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NRColorItem : NSObject

@property (nonatomic, copy) NSString* colorDescription;

@property (nonatomic, strong) UIColor* color;

- (instancetype)initWithColor:(UIColor *)color description:(NSString *)colorDescription;

@end

@interface NRCollectionViewController : UICollectionViewController

@end

NS_ASSUME_NONNULL_END
