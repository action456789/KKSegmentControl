//
//  KKSegmentControlHeadVC.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKSegmentControlBaseLayout.h"

@class KKSegmentControlHeadVC;

NS_ASSUME_NONNULL_BEGIN

@protocol KKSegmentControlHeadVCDelegate <NSObject>

@optional
- (void)segmentControlHeadVC:(KKSegmentControlHeadVC *)vc itemMoreClicked:(UIButton *)itemMore;

- (void)segmentControlHeadVC:(KKSegmentControlHeadVC *)vc itemChangedFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

@end

@interface KKSegmentControlHeadVC : UIViewController

@property (nonatomic, assign) id <KKSegmentControlHeadVCDelegate> delegate;

@property (nonatomic, strong, readonly) KKSegmentControlBaseLayout *layout;

@property (nonatomic, strong, readonly) NSArray<NSString *> *itemTitles;

- (instancetype)initWithItemTitles:(NSArray *)itemTitles
                            layout:(KKSegmentControlBaseLayout *)layout;

- (void)autoScrollItemsScrollViewFromIndex:(NSUInteger)from
                                   toIndex:(NSUInteger)to
                                   animate:(BOOL)animate;


/**
 更新标题

 @param newTitle 新的标题文字
 @param index 更新的标题数组下标
 */
- (void)updateItemTitle:(NSString *)newTitle atIndex:(NSUInteger)index;

// pageVC ScrollView 滑动时回调：实时更新slider的位置和长度
- (void)updateSliderWithPercentX:(CGFloat)percentX indexWhenDraging:(NSInteger)index;

// pageVC ScrollView 停止滑动时回调
- (void)pageVCScrollViewDidEndDecelerating;

@end

NS_ASSUME_NONNULL_END
