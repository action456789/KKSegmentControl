//
//  KKSegmentControlManager.m
//  Business
//
//  Created by ke sen. on 2018/6/7.
//

#import "KKSegmentControlCombiner.h"

@interface KKSegmentControlCombiner() <KKSegmentControlHeadVCDelegate, KKSegmentControlPageVCDelegate>

@property (nonatomic, strong) UIView *mainSperatorLine;

@end

@implementation KKSegmentControlCombiner {
    NSMutableArray<NSString *> *_titles;
    NSCache<NSNumber *, __kindof UIViewController *> *_cache;
    
    KKSegmentControlBaseLayout *_layout;
}

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                            layout:(KKSegmentControlBaseLayout *)layout {
    return [self initWithItemTitles:itemTitles controllers:nil layout:layout];
}

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                       controllers:(NSMutableArray *)controllers
                            layout:(KKSegmentControlBaseLayout *)layout {
    if (self = [super init]) {
        _titles = itemTitles;
        _layout = layout;
        
        [self createHeaderView];
        
        // 添加一条分隔线
        [self createLine];
        
        [self createPageWithControllers:controllers];
        
        _cache = [[NSCache alloc] init];
    }
    return self;
}

- (void)createHeaderView {
    _headerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _layout.appearance.headerViewWidth, _layout.appearance.headerViewWidth)];
    
    _headVC = [[KKSegmentControlHeadVC alloc] initWithItemTitles:_titles layout:_layout];
    _headVC.delegate = self;
    
    [_headerContainerView addSubview:_headVC.view];
    // 在父控制器中添加
//    [self addChildViewController:_headVC];
    
    [_headVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self->_headerContainerView);
    }];
}

- (void)createLine {
    if (_layout.appearance.isShowHeadPageSeparatorLine) {
        UIView *line = [UIView new];
        line.backgroundColor = _layout.appearance.headPageSeparatorLineBgColor;
        [_headerContainerView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_headerContainerView.mas_bottom);
            make.left.equalTo(self->_headerContainerView).offset(self->_layout.appearance.headPageSeparatorLineLeftPadding);
            make.right.equalTo(self->_headerContainerView).offset(-self->_layout.appearance.headPageSeparatorLineRightPadding);
            make.height.equalTo(@(self->_layout.appearance.headPageSeparatorLineHeight));
        }];
    }
}

- (void)createPageWithControllers:(NSMutableArray *)controllers {
    _pageContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _pageVC = [[KKSegmentControlPageVC alloc] initWithPageCount:_titles.count controllers:controllers];
    _pageVC.delegate = self;
    [_pageVC setCurrentPage:0 isUserOperate:NO];
    [_pageContainerView addSubview:_pageVC.view];
    // 在父控制器中添加
//    [self addChildViewController:_pageVC];
    
    [_pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self->_pageContainerView);
    }];
}

#pragma mark - Public Method

- (void)clearCache {
    [_cache removeAllObjects];
}

#pragma mark - KKSegmentControlHeadVC delegate

- (void)segmentControlHeadVC:(KKSegmentControlHeadVC *)vc
        itemChangedFromIndex:(NSUInteger)from
                     toIndex:(NSUInteger)to
{
    [self.pageVC setCurrentPage:to isUserOperate:NO];
}

#pragma mark - KKSegmentControlPageVCDelegate delegate

- (void)segmentControlPageVC:(KKSegmentControlPageVC *)vc
        pageChangedFromIndex:(NSUInteger)from
                     toIndex:(NSUInteger)to
               isUserOperate:(BOOL)isUserOperate
{
    if (isUserOperate) {
        [self.headVC autoScrollItemsScrollViewFromIndex:from toIndex:to animate:YES];
    }
    
    if (!self.pageVC.realtimePage) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *controller = [self->_cache objectForKey:@(to)];
        if (!controller) {
            controller = [self.delegate segmentControlCombiner:self viewControllerForPageAtIndex:to];
            if (controller) {
                [self->_cache setObject:controller forKey:@(to)];
            }
        }
        [self.pageVC updateControllerFromIndex:from toIndex:to withController:controller];
    });
}

- (void)segmentControlPageVC:(KKSegmentControlPageVC *)vc scrollViewScrollPercentX:(CGFloat)percentX indexWhenDraging:(NSInteger)index {
    [self.headVC updateSliderWithPercentX:percentX indexWhenDraging:index];
}

- (void)segmentControlPageVC:(KKSegmentControlPageVC *)vc scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.headVC pageVCScrollViewDidEndDecelerating];
}

@end
