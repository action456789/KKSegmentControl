//
//  KKSegmentControlManager.h
//  Business
//
//  Created by ke sen. on 2018/6/7.
//

#import <Foundation/Foundation.h>
#import "KKSegmentControlHeadVC.h"
#import "KKSegmentControlPageVC.h"

@class KKSegmentControlBaseLayout;
@class KKSegmentControlCombiner;

NS_ASSUME_NONNULL_BEGIN

@protocol KKSegmentControlCombinerDelegate <NSObject>

/**
 数据源：返回每页控制器
 @return UIViewController 及其子类
 */
- (__kindof UIViewController *)segmentControlCombiner:(KKSegmentControlCombiner *)combiner viewControllerForPageAtIndex:(NSInteger)index;

@end

@interface KKSegmentControlCombiner : NSObject

/// init all items but the array of page controllers is nil
- (instancetype)initWithItemTitles:(NSArray<NSString *> *)itemTitles
                            layout:(__kindof KKSegmentControlBaseLayout *)layout;

/// designated init, init all items and page controllers once a time
- (instancetype)initWithItemTitles:(NSArray<NSString *> *)itemTitles
                       controllers:(NSArray<__kindof UIViewController *> * _Nullable)controllers
                            layout:(__kindof KKSegmentControlBaseLayout *)layout;

@property (nonatomic, weak) id<KKSegmentControlCombinerDelegate> delegate;


/**
 注意：在展示的控制器中，需要将headVC和pageVC作为子控制器加入
 */
@property (nonatomic, strong) KKSegmentControlHeadVC *headVC;
@property (nonatomic, strong) KKSegmentControlPageVC *pageVC;

@property (nonatomic, strong) UIView *headerContainerView;
@property (nonatomic, strong) UIView *pageContainerView;


/**
 当前 Index
 */
@property (nonatomic, assign) NSUInteger currentIndex;

- (void)clearCache;

@end

NS_ASSUME_NONNULL_END
