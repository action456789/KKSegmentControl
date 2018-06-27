//
//  KKSlideTabBarLayoutBisect.m
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "KKSegmentControlLayoutBisect.h"

@implementation KKSegmentControlLayoutBisect

- (void)layoutItemsViews:(NSArray *)views {
    __block CGFloat itemX = self.appearance.firstItemLeftPadding;
    
    [views enumerateObjectsUsingBlock:^(id view, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *itemButton;
        if ([view isKindOfClass:[UIButton class]]) {
            itemButton = (UIButton *)view;
        } else {
            return ;
        }
        
        [itemButton setTitle:self.itemTitles[idx] forState:UIControlStateNormal];
        itemButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        itemButton.titleLabel.font = [UIFont systemFontOfSize:self.appearance.itemFontSize];
        
        [itemButton setTitleColor:self.appearance.itemFontNormalColor forState:UIControlStateNormal];
        [itemButton setTitleColor:self.appearance.itemFontSelectedColor forState:UIControlStateSelected];
        
        CGFloat seperaterWidthsSum = (self.itemTitles.count - 1) * self.appearance.itemSeperaterWidth;
        CGFloat w = (kk_ScreenWidth - self.appearance.firstItemLeftPadding - self.appearance.lastItemRightPadding - seperaterWidthsSum) / views.count;
        CGFloat offsetX = (w + self.appearance.itemSeperaterWidth) * idx ;
        
        // ScrollView
        UIView *superView = itemButton.superview;
        
        // 最外层View
        UIView *rootView = [superView superview];
        
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rootView.mas_top);
            make.height.mas_equalTo(@(self.appearance.headerViewHeight * self.appearance.itemHeightRatio));
            make.left.mas_equalTo(superView.mas_left).offset(offsetX);
            make.width.mas_equalTo(@(w));
        }];
        
        itemX += w;
        
        if (self.showSeperater && idx != self.itemTitles.count - 1) {
            UIView *seperaterView = [UIView new];
            seperaterView.backgroundColor = self.appearance.itemSeperaterColor;
            [superView addSubview:seperaterView];
            
            [seperaterView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(itemButton.mas_right);
                make.width.mas_equalTo(self.appearance.itemSeperaterWidth);
                make.height.mas_equalTo(self.appearance.itemSperaterHeight);
                make.centerY.mas_equalTo(itemButton);
            }];
        }
    }];
}

- (CGFloat)lineWidthWithIndex:(NSInteger)index {
    CGFloat w = self.appearance.slideWidth;
    if (self.appearance.slideWidthAuto) {
        w = (kk_ScreenWidth / self.itemTitles.count) - ((self.appearance.firstItemLeftPadding - self.appearance.slideLeftRightOverWidth) * 2);
    }
    return w;
}

- (BOOL)itemScrollViewScrollEnable {
    return NO;
}

- (BOOL)showSeperater {
    return YES;
}

@end
