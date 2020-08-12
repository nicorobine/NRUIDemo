//
//  NRCodeItem.m
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/12.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRCodeItem.h"

@interface NRCodeItem() {
    // 外观
    NRCodeItemStyle _style;
    
    // 光标
    UIView* cursor;
}

@end

@implementation NRCodeItem

- (instancetype)initWithFrame:(CGRect)frame style:(NRCodeItemStyle)style {
    if (self = [super initWithFrame:frame]) {
        [self nr_setup];
        _style = style;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self nr_setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self nr_setup];
    }
    return self;
}

#pragma mark - Private

- (void)nr_setup {
    _style = NRCodeItemStyleLine;
    _activeColor = [UIColor systemIndigoColor];
    _color = [UIColor systemGray6Color];
    _active = false;
    _showCursor = false;
}


#pragma mark - Properties

- (NRCodeItemStyle)style {
    return _style;
}

@end
