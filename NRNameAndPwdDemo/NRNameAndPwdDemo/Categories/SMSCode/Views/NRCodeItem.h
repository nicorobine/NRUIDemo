//
//  NRCodeItem.h
//  NRNameAndPwdDemo
//
//  Created by 王文涛 on 2020/8/12.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NRCodeItemStyle) {
    NRCodeItemStyleLine,
    NRCodeItemStyleBorder,
};

NS_ASSUME_NONNULL_BEGIN

@interface NRCodeItem : UIControl

/**
 * @brief 激活状态下的颜色
 * @discussion 包含光标颜色，边框颜色
 */
@property (nonatomic, strong) UIColor *activeColor;

/**
 * @brief 普通状态下的颜色
 * @discussion 包含光标颜色，光标颜色
 */
@property (nonatomic, strong) UIColor *color;

/**
 * @brief 是否是激活状态
 */
@property (nonatomic, assign, getter=isActive) BOOL active;

/**
 * @brief 边框样式
 * @discussion 无边框，底线和全边框三种
 */
@property (nonatomic, readonly) NRCodeItemStyle style;

/**
 * @brief 是否显示光标
 */
@property (nonatomic, assign) BOOL showCursor;

/**
 * @param style 形状
 */
- (instancetype)initWithFrame:(CGRect)frame style:(NRCodeItemStyle)style;

@end

NS_ASSUME_NONNULL_END
