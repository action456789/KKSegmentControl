//
//  KKSegmentControlPageVC.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "KKSegmentControlPageVC.h"
#import "KKSegmentControlBaseLayout.h"
#import <Masonry/Masonry.h>
#import "UIView+Frame.h"

@interface KKSegmentControlPageVC () <UIScrollViewDelegate>
{
    NSUInteger      _itemCount;
    NSMutableArray<__kindof UIViewController *>  *_controllers;
    
    NSInteger _indexWhenDraging; // 开始拖拽时的index
    BOOL _isDraging; // 正在拖拽滑动
}
@property (nonatomic, assign) NSUInteger currentPage;
@end

@implementation KKSegmentControlPageVC

- (instancetype)initWithPageCount:(NSInteger)count
                      controllers:(NSMutableArray<__kindof UIViewController *> * _Nullable )controllers {
    if (self = [super init]) {
        _controllers = [NSMutableArray array];
        _currentPage = -1;
        _itemCount = count;
        _realtimePage = controllers == nil;
        
        [self.view addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        
        [self addControllers:controllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(_itemCount * _scrollView.frame.size.width, 0);
}

- (void)addControllers:(NSMutableArray *)controllers {
    for (int i=0; i<controllers.count; i++) {
        UIViewController *vc = controllers[i];
        [self addControllerAtIndex:i withController:vc];
    }
}

- (void)addControllerAtIndex:(NSUInteger)index withController:(UIViewController *)controller {
    [_controllers insertObject:controller atIndex:index];
    
    [_scrollView addSubview:controller.view];
    [self addChildViewController:controller];
    
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.mas_equalTo(self->_scrollView);
        make.left.mas_equalTo(self->_scrollView.mas_left).offset(index * [self width]);
    }];
}

- (void)replaceControllerAtIndex:(NSUInteger)index withController:(UIViewController *)controller {
    UIViewController *vc = _controllers[index];
    [_controllers replaceObjectAtIndex:index withObject:controller];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
    
    [_scrollView addSubview:controller.view];
    [self addChildViewController:controller];

    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.mas_equalTo(self->_scrollView);
        make.left.mas_equalTo(self->_scrollView.mas_left).offset(index * [self width]);
    }];
}

- (void)updateControllerFromIndex:(NSUInteger)from toIndex:(NSUInteger)to withController:(UIViewController *)controller {
    NSInteger count = _controllers.count;
    if (to == count) { // first
        [self addControllerAtIndex:to withController:controller];
        
    } else if (to < count) {
        BOOL sameKindOfObject = [_controllers[to] isKindOfClass:[KKSegmentControlPlaceholdVC class]];
        if (self.realtimePage || sameKindOfObject) {
            [self replaceControllerAtIndex:to withController:controller];
        }
    } else {// jump
        for (NSUInteger i=from+1; i<to; i++) {
            KKSegmentControlPlaceholdVC *placeholdController = [[KKSegmentControlPlaceholdVC alloc] init];
            [self addControllerAtIndex:i withController:placeholdController];
        }
        [self updateControllerFromIndex:from toIndex:to withController:controller];
    }
}

- (void)autoScrollFromIndex:(NSUInteger)from toIndex:(NSUInteger)to animate:(BOOL)animate {
    CGFloat x = to * [self width];
    [_scrollView setContentOffset:CGPointMake(x, 0) animated:animate];
}

@synthesize currentPage = _currentPage;
- (NSUInteger)currentPage {
    return _scrollView.contentOffset.x / [self width];
}

- (CGFloat)width {
    // TODO: fix bug 非realtimePage模式下，返回的宽度不对
    CGFloat w = self.view.bounds.size.width;
    return w;
}

#pragma mark getter, setter

- (void)setCurrentPage:(NSUInteger)page isUserOperate:(BOOL)isUserOperate {
    if (!isUserOperate) {
        [self autoScrollFromIndex:_currentPage toIndex:page animate:YES];
    }
    if (_currentPage != page) {
        if ([self.delegate respondsToSelector:@selector(segmentControlPageVC:pageChangedFromIndex:toIndex:isUserOperate:)]) {
            [self.delegate segmentControlPageVC:self
                           pageChangedFromIndex:_currentPage
                                        toIndex:page
                                  isUserOperate:isUserOperate];
        }
    }
    
    _currentPage = page;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (NSInteger)currentPageIndex {
    int page = _scrollView.contentOffset.x / [self width];
    return page;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _indexWhenDraging = _scrollView.contentOffset.x / [self width];
    _isDraging = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _isDraging = NO;
    int page = scrollView.contentOffset.x / [self width];
    [self setCurrentPage:page isUserOperate:YES];
}

// 为了实现slide实时滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //往左滑动大于0，往右小于0(由于默认偏移320)
    if (!_isDraging) {
        return;
    }
    CGFloat percentX = (scrollView.contentOffset.x - CGRectGetWidth(scrollView.frame) * _indexWhenDraging) / CGRectGetWidth(scrollView.frame);
    
    if ([self.delegate respondsToSelector:@selector(segmentControlPageVC:scrollViewScrollPercentX:indexWhenDraging:)]) {
        [self.delegate segmentControlPageVC:self scrollViewScrollPercentX:percentX indexWhenDraging:_indexWhenDraging];
    }
}

@end

@implementation KKSegmentControlPlaceholdVC

@end

