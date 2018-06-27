//
//  KKSegmentControlVC.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "KKSegmentControlVC.h"
#import "KKSegmentControlBaseLayout.h"
#import <Masonry/Masonry.h>

@interface KKSegmentControlVC() <KKSegmentControlCombinerDelegate>


@end

@implementation KKSegmentControlVC
    
- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                            layout:(KKSegmentControlBaseLayout *)layout {
    return [self initWithItemTitles:itemTitles controllers:nil layout:layout];
}
    
- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                       controllers:(NSMutableArray *)controllers
                            layout:(KKSegmentControlBaseLayout *)layout {
    if (self = [super init]) {
        _segCombiner = [[KKSegmentControlCombiner alloc] initWithItemTitles:itemTitles controllers:controllers layout:layout];
        
        [self setupSegCombiner];
        
        [self autoLayoutSubviews];
    }
    return self;
}

- (void)setupSegCombiner {
    _segCombiner.delegate = self;
    
    [self.view addSubview:_segCombiner.headerContainerView];
    [self.view addSubview:_segCombiner.pageContainerView];
    
    [self addChildViewController:_segCombiner.headVC];
    [self addChildViewController:_segCombiner.pageVC];
}

- (void)autoLayoutSubviews {
    KKSegmentControlAppearance *appearance = _segCombiner.headVC.layout.appearance;
    
    CGFloat h = appearance.headerViewHeight;
    CGFloat w = appearance.headerViewWidth;
    
    [_segCombiner.headerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@(h));
        make.width.mas_equalTo(@(w));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    CGFloat offset = appearance.isShowHeadPageSeparatorLine ? appearance.headPageSeparatorLineHeight : 0;
    offset += appearance.headPageSpace;
    
    [_segCombiner.pageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_segCombiner.headerContainerView.mas_bottom).offset(offset);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    
    // 只有一个时，不显示头部
    if (_segCombiner.headVC.itemTitles.count == 1) {
        _segCombiner.headerContainerView.hidden = YES;
        [_segCombiner.headerContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->_segCombiner.headerContainerView.mas_bottom).offset(-h);
        }];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 解决 gesture back 冲突
    if (self.navigationController.interactivePopGestureRecognizer) {
        [_segCombiner.pageVC.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    }
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_segCombiner clearCache];
}

- (UIViewController *)segmentControlCombiner:(KKSegmentControlCombiner *)combiner viewControllerForPageAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(segmentControlVC:viewControllerForPageAtIndex:)]) {
        return [self.delegate segmentControlVC:self viewControllerForPageAtIndex:index];
    }
    return [UIViewController new];
}
    
@end
