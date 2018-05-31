//
//  KKSlideTabBarLayoutAuto.m
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "KKSegmentControlLayoutAuto.h"

@implementation KKSegmentControlLayoutAuto

-(void)layoutItemsViews:(NSArray *)views {
    __block CGFloat itemX = self.config.firstItemLeftPadding;
    
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
        CGFloat x = itemX + idx * self.config.itemHorizontalSpace;
        
        // ScrollView
        UIView *superView = itemButton.superview;
        
        // 最外层View
        UIView *rootView = [superView superview];
        
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rootView.mas_top);
            make.height.mas_equalTo(@(self.config.headerViewHeight * self.config.itemHeightRatio));
            make.left.mas_equalTo(superView.mas_left).offset(x);
            make.width.mas_equalTo(@(titleStringW));
        }];
        
        itemX += titleStringW;
    }];
}

- (CGFloat)lineWidthWithIndex:(NSInteger)index {
    if (self.itemStringWidths.count > 0) {
        return [self.itemStringWidths[index] floatValue] + self.config.slideLeftRightOverWidth * 2;
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
    [attrStr addAttribute:NSFontAttributeName value:self.config.itemFontNormal range:range];
    
    // 设置颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:self.config.itemFontNormalColor range:range];
    
    return  attrStr;
}

- (NSAttributedString *)attriStringForSelectedWith:(NSString *)text {
    NSRange range = NSMakeRange(0, text.length);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    // 设置字体大小
    [attrStr addAttribute:NSFontAttributeName value:self.config.itemFontSelected range:range];
    
    // 设置颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:self.config.itemFontSelectedColor range:range];
    
    return  attrStr;
}

@end
