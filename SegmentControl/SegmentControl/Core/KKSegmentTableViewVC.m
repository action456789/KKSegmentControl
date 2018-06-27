//
//  MemberBalanceDetailVC.m
//  Business
//
//  Created by ke sen. on 2018/6/7.
//

#import "KKSegmentTableViewVC.h"

#import "KKSegmentControlCombiner.h"

#import "Masonry.h"

@interface KKSegmentTableViewVC () <UITableViewDelegate, UITableViewDataSource, KKSegmentControlCombinerDelegate>

@property (nonatomic, strong) KKSegmentControlCombiner *segCombiner;

@end

@implementation KKSegmentTableViewVC {

}

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
    }
    return self;
}

- (void)setupSegCombiner {
    _segCombiner.delegate = self;
    [self addChildViewController:_segCombiner.headVC];
    [self addChildViewController:_segCombiner.pageVC];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.rowHeight = 1000;
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_segCombiner clearCache];
}

- (KKSegmentControlAppearance *)appearence {
    return _segCombiner.headVC.layout.appearance;
}

#pragma mark - UITableView delegate, datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self appearence].headerViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _segCombiner.headerContainerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SegCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        [cell.contentView addSubview:_segCombiner.pageContainerView];
        
        [_segCombiner.pageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

# pragma mark - KKSegmentControlCombinerDelegate

- (UIViewController *)segmentControlCombiner:(KKSegmentControlCombiner *)unit viewControllerForPageAtIndex:(NSInteger)index {
    return [UIViewController new];
}

@end
