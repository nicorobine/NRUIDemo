//
//  NRMainModel.m
//  NRNameAndPwdDemo
//
//  Created by NicoRobine on 2020/7/31.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRMainModel.h"
#import <Foundation/Foundation.h>

@interface NRMainModel()
{
    NSMutableArray<NRCellInfo *>* _datas;
}

@end

@implementation NRMainModel

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        [self _setUp];
    }
    return self;
}

#pragma mark - Private

- (void)_setUp {
    _datas = @[].mutableCopy;
    [self _initialData];
}

- (void)_initialData {
    [_datas addObject:[[NRCellInfo alloc] initWithTitle:@"FaceIdOrTouchId" subTitle:@"直接使用FaceId或者TouchId登录，只能校验成功与否"]];
    [_datas addObject:[[NRCellInfo alloc] initWithTitle:@"自动填充账号密码" subTitle:@"使用keyChain管理账号密码，同时可以实现Web的账号密码填充"]];
}

#pragma mark - Public

- (void)selectedIndex:(NSUInteger)index {
    NSAssert(index < _datas.count, @"Index out of range");
    if (self.onSelected) {
        self.onSelected(_datas[index], index);
    }
}

- (NRCellInfo *)cellInfoWithIndexPath:(NSInteger)index {
    return [_datas objectAtIndex:index];
}

#pragma mark - Properties

- (NSArray<NRCellInfo *> *)datas {
    return _datas;
}

@end


@implementation NRCellInfo

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle  {
    if (self = [super init]) {
        _title = title;
        _subTitle = subTitle;
    }
    return self;
}

@end
