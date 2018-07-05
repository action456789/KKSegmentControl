//
//  KKSlideTabBarLayoutAuto.m
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "KKSegmentControlLayoutAuto.h"
#import <Masonry/Masonry.h>

@implementation KKSegmentControlLayoutAuto {
    __weak NSArray *_btns;
}

-(void)layoutItemsViews:(NSArray *)views {
    [super layoutItemsViews:views];
    
    _btns = views;
    
    __block CGFloat itemX = self.appearance.firstItemLeftPadding;
    
    [views enumerateObjectsUsingBlock:^(id view, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *itemButton;
        if ([view isKindOfClass:[UIButton class]]) {
            itemButton = (UIButton *)view;
        } else {
            return ;
        }
        
        NSString *btnText = self.itemTitles[idx];

        [itemButton setAttributedTitle:[self attriStringForNormalWith:btnText] forState:UIControlStateNormal];
        [itemButton setAttributedTitle:[self attriStringForSelectedWith:btnText] forState:UIControlStateSelected];
        
        CGFloat titleStringW = [self.itemStringWidths[idx] floatValue];
        CGFloat x = itemX + idx * self.appearance.itemHorizontalSpace;
        
        // ScrollView
        UIView *superView = itemButton.superview;
        
        // 最外层View
        UIView *rootView = [superView superview];
        
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rootView.mas_top);
            make.height.mas_equalTo(@(self.appearance.headerViewHeight * self.appearance.itemHeightRatio));
            make.left.mas_equalTo(superView.mas_left).offset(x);
            make.width.mas_equalTo(@(titleStringW));
        }];
        
        itemX += titleStringW;
    }];
}

-(void)updateLayout {
    if (_btns == nil) {
        return;
    }
    
    __block CGFloat itemX = self.appearance.firstItemLeftPadding;
    __block UIView *superView;
    
    [_btns enumerateObjectsUsingBlock:^(id view, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *itemButton;
        if ([view isKindOfClass:[UIButton class]]) {
            itemButton = (UIButton *)view;
        } else {
            return ;
        }
        
        NSString *btnText = self.itemTitles[idx];
        CGFloat titleStringW = [self.itemStringWidths[idx] floatValue];
        CGFloat x = itemX + idx * self.appearance.itemHorizontalSpace;
        
        [itemButton setAttributedTitle:[self attriStringForNormalWith:btnText] forState:UIControlStateNormal];
        [itemButton setAttributedTitle:[self attriStringForSelectedWith:btnText] forState:UIControlStateSelected];

        // ScrollView
        superView = itemButton.superview;
        
        [itemButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(titleStringW));
            make.left.mas_equalTo(superView.mas_left).offset(x);
        }];
        
        itemX += titleStringW;
    }];
    
    [UIView animateWithDuration:0.33 animations:^{
        [superView setNeedsLayout];
        [superView layoutIfNeeded];
    }];
}

- (CGFloat)lineWidthWithIndex:(NSInteger)index {
    if (self.itemStringWidths.count > 0) {
        return [self.itemStringWidths[index] floatValue] + self.appearance.slideLeftRightOverWidth * 2;
    }
    return 0;
}

- (BOOL)itemScrollViewScrollEnable {
    return YES;
}

- (BOOL)showSeperater {
    return NO;
}

- (NSAttributedString *)attriStringForNormalWith:(NSString *)text {
    NSRange range = NSMakeRange(0, text.length);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    // 设置字体大小
    [attrStr addAttribute:NSFontAttributeName value:self.appearance.itemFontNormal range:range];
    
    // 设置颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:self.appearance.itemFontNormalColor range:range];
    
    return  attrStr;
}

- (NSAttributedString *)attriStringForSelectedWith:(NSString *)text {
    NSRange range = NSMakeRange(0, text.length);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    // 设置字体大小
    [attrStr addAttribute:NSFontAttributeName value:self.appearance.itemFontSelected range:range];
    
    // 设置颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:self.appearance.itemFontSelectedColor range:range];
    
    return  attrStr;
}

- (void)updateItemTitle:(NSString *)newTitle atIndex:(NSUInteger)index {
    [super updateItemTitle:newTitle atIndex:index];
    
    [self updateLayout];
}

@end
