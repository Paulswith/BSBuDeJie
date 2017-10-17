//
//  BSEssenceBisicTableViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/15.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceBisicTableViewController.h"
#import "BSRefreshView.h"
#import "BSLoadMoreView.h"



static NSString * const ID = @"BSEssenceBisicTableViewController";
static CGFloat const topInset = 35 + 35;   //另外的35是因为下拉加的高度
static CGFloat const tabBarHeight = 49;
static CGFloat const bottomInset = topInset + tabBarHeight;   //顶部偏移量 + 底部tabbar 自行调整,来展示

@interface BSEssenceBisicTableViewController ()
//数据总源
@property (assign, nonatomic) NSInteger dataCount;

@end


@implementation BSEssenceBisicTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    CGFloat newTopInset = topInset - BSEssenseHeaderViewHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(newTopInset, 0, bottomInset, 0);   //下挪topView的间距 上挪tabBar的高度
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset; // 设置滚动条与tableView的内存的一致
    // 加载更多按钮
    [self setupLoadMoreFooterView];
    [self setupRefresingHeaderView];
    self.dataCount = 20;
}
#pragma mark - 上下拉按钮
- (void)setupRefresingHeaderView {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.mj_header = [BSRefreshView headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}
- (void)setupLoadMoreFooterView {
    self.tableView.mj_footer = [BSLoadMoreView footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

//下啦和进入的时候调用
- (void)loadNewData {
    self.dataCount += 5;
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
    });
}
// 上拉加载更多调用
- (void)loadMoreData
{
    self.dataCount +=5;
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView reloadData];
        [tableView.mj_footer endRefreshing];
    });
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text=[NSString stringWithFormat:@"%@-%ld",NSStringFromClass([self class]),indexPath.row];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

#pragma mark - TableViewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
