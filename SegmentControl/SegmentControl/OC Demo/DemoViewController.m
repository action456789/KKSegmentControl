//
//  DemoViewController.m
//  SegmentControl
//
//  Created by ke sen. on 2018/6/6.
//  Copyright © 2018年 ke sen. All rights reserved.
//

#import "DemoViewController.h"
#import "KKSegmentControlAppearance.h"
#import "KKSegmentControlLayoutAuto.h"
#import "KKSegmentControlVC.h"
#import "PageViewController.h"

@interface DemoViewController () <KKSegmentControlVCDelegate>

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titles = @[@"哈喽", @"弓箭女皇", @"野蛮人之王", @"头号玩家", @"哈哈哈", @"哈喽", @"弓箭女皇", @"野蛮人之王", @"头号玩家"];
    KKSegmentControlAppearance *appearance = [KKSegmentControlAppearance new];
    KKSegmentControlBaseLayout *layout = [[KKSegmentControlLayoutAuto alloc] initWithItemTitles:[titles mutableCopy] appearance:appearance];
    KKSegmentControlVC *seg = [[KKSegmentControlVC alloc] initWithItemTitles:titles layout:layout];
    seg.delegate = self;
    
    [self.view addSubview:seg.view];
    [self addChildViewController:seg];
    
    seg.view.frame = CGRectMake(0, 64, kk_ScreenWidth, kk_ScreenHeight);
}


- (UIViewController *)segmentControlVC:(KKSegmentControlVC *)segmentControl viewControllerForPageAtIndex:(NSInteger)index {
    UIViewController *vc = [PageViewController new];
    return vc;
}

@end
