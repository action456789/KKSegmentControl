//
//  MemberBalanceDetailVC.h
//  Business
//
//  Created by ke sen. on 2018/6/7.
//

#import <UIKit/UIKit.h>
#import "KKSegmentControlHeadVC.h"
#import "KKSegmentControlPageVC.h"

@class KKSegmentControlBaseLayout;
@class KKSegmentTableViewVC;

@interface KKSegmentTableViewVC : UIViewController

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                            layout:(KKSegmentControlBaseLayout *)layout;

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                       controllers:(NSMutableArray *)controllers
                            layout:(KKSegmentControlBaseLayout *)layout;

@property (strong, nonatomic) UITableView *tableView;

@end
