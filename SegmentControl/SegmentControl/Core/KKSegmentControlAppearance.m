//
//  KKSegmentControlConfig.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/12/7.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "KKSegmentControlAppearance.h"

@implementation KKSegmentControlAppearance

- (CGFloat)headerViewHeight {
    return 40.f;
}

- (CGFloat)headerViewWidth {
    return kScreenWidth;
}
    
- (UIColor *)headerBackgroundColor {
    return [UIColor whiteColor];
}

- (SegmentControlSlidePosition)slidePosition {
    return SegmentControlSlidePositionBottom;
}

- (BOOL)isShowSlide {
    return YES;
}

- (CGFloat)slideHeight {
    return 2.f;
}

- (CGFloat)slideWidth {
    return 50;
}

- (CGFloat)slideTopPaddingForItem {
    return 2;
}

- (BOOL)isSlideWidthAuto {
    return YES;
}

- (CGFloat)slideLeftRightOverWidth {
    return 5.f;
}

- (CGFloat)firstItemLeftPadding {
    return 48;
}

- (CGFloat)lastItemRightPadding {
    return 20;
}

- (CGFloat)itemHorizontalSpace {
    return 96;
}

- (CGFloat)itemMoreWidth {
    return 0;
}

- (CGFloat)itemHeightRatio {
    return 0.9;
}

- (CGFloat)itemFontSize {
    return 14.f;
}

- (CGFloat)itemSeperaterWidth {
    return 0.5f;
}

- (CGFloat)itemSperaterHeight {
    return 18.f;
}

- (UIColor *)itemSperaterBgColor {
    return kColorWithHex(0xff7608);
}

- (UIColor *)itemFontNormalColor {
    return kColorWithHex(0x333333);
}

- (UIColor *)itemFontSelectedColor {
    return kColorWithHex(0x333333);
}

- (UIColor *)itemSeperaterColor {
    return kColorWithHex(0x808080);
}

- (UIFont *)itemFontNormal {
    return [UIFont systemFontOfSize:[self itemFontSize] weight:UIFontWeightRegular];
}

- (UIFont *)itemFontSelected {
    return [UIFont systemFontOfSize:[self itemFontSize] weight:UIFontWeightSemibold];
}

- (CGFloat)itemSelectedTransformScaleX {
    return 1.1;
}

- (CGFloat)itemSelectedTransformScaleY {
    return 1.1;
}

- (CGFloat)slideTransformScaleX {
    return 1.1;
}

- (CGFloat)slideTransformScaleY {
    return 1.1;
}

- (UIColor *)sliderColor {
    return kColorWithHex(0xD03B5C);
}

- (CGFloat)pageViewInsectWithHeadView {
    return 0;
}

- (UIColor *)pageBackgroundColor {
    return [UIColor whiteColor];
}

@end
