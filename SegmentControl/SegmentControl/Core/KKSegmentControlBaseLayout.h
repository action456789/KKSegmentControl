//
//  KKSlideTabBarBaseLayout.h
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKSegmentControlAppearance.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKSegmentControlBaseLayout : NSObject

@property (nonatomic, strong, nullable) NSMutableArray<NSNumber *> *itemStringWidths;
@property (nonatomic, strong, readonly) NSMutableArray<NSString *> *itemTitles;
@property (nonatomic, strong, readonly) __kindof KKSegmentControlAppearance *appearance;
@property (nonatomic, assign) BOOL itemScrollViewScrollEnable;
@property (nonatomic, assign) BOOL showSeperater;

- (instancetype)initWithItemTitles:(NSMutableArray<NSString *> *)itemTitles
                            appearance:(__kindof KKSegmentControlAppearance *)appearance;

- (void)layoutItemsViews:(NSArray *)views;
- (CGFloat)lineWidthWithIndex:(NSInteger)index;


/**
 更新标题
 */
- (void)updateItemTitle:(NSString *)newTitle atIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
