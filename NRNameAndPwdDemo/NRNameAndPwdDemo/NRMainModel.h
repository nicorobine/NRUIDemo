//
//  NRMainModel.h
//  NRNameAndPwdDemo
//
//  Created by NicoRobine on 2020/7/31.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class NRCellInfo;

typedef void (^NRItemSelectedBlock)(NRCellInfo *info, NSUInteger index);

@interface NRCellInfo : NSObject

@property (nonatomic, copy) NSString* title;

@property (nonatomic, copy) NSString* subTitle;

@property (nonatomic, copy) NSString* identifier;

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end

@interface NRMainModel : NSObject

@property (readonly) NSArray<NRCellInfo *>* datas;

@property (nonatomic, copy) NRItemSelectedBlock onSelected;

- (void)selectedIndex:(NSUInteger)index;

- (NRCellInfo *)cellInfoWithIndexPath:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
