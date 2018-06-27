//
//  KKSlideTabBarBaseLayout.m
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "KKSegmentControlBaseLayout.h"

@implementation KKSegmentControlBaseLayout {
    UIView *_superView;
}

# pragma mark - getter

- (instancetype)initWithItemTitles:(NSMutableArray<NSString *> *)itemTitles {
    self = [super init];
    if (self) {
        _itemTitles = itemTitles;
    }
    return self;
}

- (instancetype)initWithItemTitles:(NSMutableArray<NSString *> *)itemTitles
                        appearance:(__kindof KKSegmentControlAppearance *)appearance {
    self = [super init];
    if (self) {
        _itemTitles = itemTitles;
        _appearance = appearance;
    }
    return self;
}

- (NSMutableArray *)itemStringWidths
{
    if (!_itemStringWidths) {
        _itemStringWidths = [NSMutableArray array];
        
        if (self.appearance.itemFontSelected && self.appearance.itemFontNormal) {
            for (NSString *title in _itemTitles) {
                NSDictionary *attrs = @{NSFontAttributeName : self.appearance.itemFontSelected};
                CGFloat widthSelected = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
                
                attrs = @{NSFontAttributeName : self.appearance.itemFontNormal};
                CGFloat widthNormal = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
                
                [_itemStringWidths addObject:@(ceil(MAX(widthSelected, widthNormal)))];
            }
        } else {
            NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:self.appearance.itemFontSize]};
            for (NSString *title in _itemTitles) {
                CGFloat w = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
                [_itemStringWidths addObject:@(ceil(w))];
            }
        }
    }
    return _itemStringWidths;
}

- (void)updateItemTitle:(NSString *)newTitle atIndex:(NSUInteger)index {
    if (index >= _itemTitles.count) {
        return;
    }
    
    if ([_itemTitles[index] isEqualToString:newTitle]) {
        return;
    }
    
    _itemTitles[index] = newTitle;
    
    // 重新计算宽度
    self.itemStringWidths = nil;
}

- (void)layoutItemsViews:(NSArray *)views {
    
}

- (CGFloat)lineWidthWithIndex:(NSInteger)index {
    return 0;
}

@end
