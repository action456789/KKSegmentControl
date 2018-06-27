//
//  KKSegmentControlConfig.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/12/7.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <UIKit/UIKit.h>

// TODO: 修改宏定义名称
// 宽度
#define kk_ScreenWidth    ([UIApplication sharedApplication].keyWindow.rootViewController.view.bounds.size.width)
// 高度
#define kk_ScreenHeight   ([UIApplication sharedApplication].keyWindow.rootViewController.view.bounds.size.height)

#define kk_ColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

typedef NS_ENUM(NSUInteger, SegmentControlSlidePosition) {
    SegmentControlSlidePositionBottom,
    SegmentControlSlidePositionTop,
};

@interface KKSegmentControlAppearance : NSObject

@property (nonatomic, assign) CGFloat headerViewHeight;
@property (nonatomic, assign) CGFloat headerViewWidth;
@property (nonatomic, strong) UIColor *headerBackgroundColor;

@property (nonatomic, assign) SegmentControlSlidePosition slidePosition;
@property (nonatomic, assign, getter=isShowSlide) BOOL showSlide;

@property (nonatomic, assign) CGFloat slideHeight;
@property (nonatomic, assign) CGFloat slideWidth;
@property (nonatomic, assign) CGFloat slideTopPaddingForItem; // 滑块距离顶部(或者item)的距离
@property (nonatomic, assign) CGFloat slideLeftRightOverWidth;
@property (nonatomic, assign, getter=isSlideWidthAuto) BOOL slideWidthAuto; // 是否自动计算 slide 的宽度
@property (nonatomic, strong) UIColor *sliderColor;
@property (nonatomic, assign) CGFloat slideTransformScaleX;
@property (nonatomic, assign) CGFloat slideTransformScaleY;

@property (nonatomic, assign) CGFloat firstItemLeftPadding;
@property (nonatomic, assign) CGFloat lastItemRightPadding;
@property (nonatomic, assign) CGFloat itemHorizontalSpace;
@property (nonatomic, assign) CGFloat itemMoreWidth;
@property (nonatomic, assign) CGFloat itemHeightRatio; // item的高度占据 headerView 高度的比例
@property (nonatomic, assign) CGFloat itemFontSize;
@property (nonatomic, assign) CGFloat itemSeperaterWidth;
@property (nonatomic, assign) CGFloat itemSperaterHeight;
@property (nonatomic, strong) UIColor *itemSperaterBgColor;
@property (nonatomic, strong) UIColor *itemFontNormalColor;
@property (nonatomic, strong) UIColor *itemFontSelectedColor;
@property (nonatomic, strong) UIFont *itemFontNormal;
@property (nonatomic, strong) UIFont *itemFontSelected;
@property (nonatomic, strong) UIColor *itemSeperaterColor;

@property (nonatomic, assign) CGFloat itemSelectedTransformScaleX;
@property (nonatomic, assign) CGFloat itemSelectedTransformScaleY;

// header 与 page 之间分割线
@property (nonatomic, assign, getter=isShowHeadPageSeparatorLine) BOOL showHeadPageSeparatorLine;
@property (nonatomic, strong) UIColor *headPageSeparatorLineBgColor;
@property (nonatomic, assign) CGFloat headPageSeparatorLineHeight;
@property (nonatomic, assign) CGFloat headPageSeparatorLineLeftPadding;
@property (nonatomic, assign) CGFloat headPageSeparatorLineRightPadding;

// header 与 page 之间的距离
@property (nonatomic, assign) CGFloat headPageSpace;
@property (nonatomic, strong) UIColor *pageBackgroundColor;

@end
