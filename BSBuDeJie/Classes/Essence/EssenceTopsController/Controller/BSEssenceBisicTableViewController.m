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



static NSString * const ID = @"AllCell";
//static NSString * const getDataClues = @"上拉加载可更多";
//static NSString * const loadingClues = @"小的正在加载中...";
static CGFloat const topInset = 35 + 35;   //另外的35是因为下拉加的高度
static CGFloat const tabBarHeight = 49;
static CGFloat const bottomInset = topInset + tabBarHeight;   //顶部偏移量 + 底部tabbar 自行调整,来展示


@interface BSEssenceBisicTableViewController ()

/*
@property (weak, nonatomic) UIImageView *imageFooterView;
@property (weak, nonatomic) UILabel *buttomCluesLabel;
@property (weak, nonatomic) UIActivityIndicatorView *buttomActivityView;
@property (assign, nonatomic,getter=isButtomRefresing) BOOL buttomRefresing;


//@property (weak, nonatomic) UIImageView *imageHeaderView;
//@property (weak, nonatomic) UILabel *topCluesLabel;
//@property (weak, nonatomic) UIActivityIndicatorView *topActivityView;
@property (assign, nonatomic,getter=isShouldRefresed) BOOL shouldRefresed;
//@property(strong,nonatomic) BSRefreseView *refreseView; //下拉刷新
*/
//数据总源
@property (assign, nonatomic) NSInteger dataCount;


@end


@implementation BSEssenceBisicTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    // 顶部只需要根据需要的下移, 而顶部除了tabbar还要加上自动偏倚64
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
#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [self headerTopView:scrollView.contentOffset.y];// 下拉刷新
//    [self footerButtomView:scrollView.contentOffset.y]; //加载更多
    BSLog(@"%f,%f",self.tableView.contentInset.bottom,scrollView.contentOffset.y);
}
/*
- (void)headerTopView:(CGFloat)contentOffSetY {
    if (self.isShouldRefresed == YES && contentOffSetY > -BSEssenseHeaderViewHeight) { //需要刷新数据, 且已经弹回原点
//        _topCluesLabel.text = @"刷新数据中....";
//        [self.refreseView refreshingWithMessage:@"刷新数据中...."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _dataCount += 5;
            //返回数据后需要做的事情
//            [_topActivityView stopAnimating];
#warning 记得替换大型的刷新的数据
            [self.tableView reloadData];
//            _topCluesLabel.text = @"下拉可以刷新";
//            [self.refreseView didRefreshWithMessage];
            _shouldRefresed = NO;
        });
        return;
    }
    if (contentOffSetY < -BSEssenseHeaderViewHeight) {
//        _topCluesLabel.text = @"松开即可刷新";
//        [_topActivityView startAnimating];
//        [self.refreseView willRefreshedWithMessage:@"松开可刷新"];
        _shouldRefresed = YES;
    }
}
 
- (void)footerButtomView:(CGFloat)contentOffSetY {
    if (self.isButtomRefresing) {return;} //避免单次, 多次请求拉取数据
    // footerView文本 = 内容高度  +  顶部偏倚(49+64?) - tableView的高度  (+- other达到需求目的)
    // 如果是数据最后一个的y 值?
    CGFloat shouldShowHeight = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.height;
    if (contentOffSetY >= shouldShowHeight) {
        _buttomRefresing = YES;
        [_buttomActivityView startAnimating];
        _buttomCluesLabel.text = loadingClues;
        //无请求前, 模拟数据操作
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.dataCount += 5;
            //返回数据后需要做的事情
            [_buttomActivityView stopAnimating];
#warning 记得替换大型的刷新的数据
            [self.tableView reloadData];
            _buttomRefresing = NO;
            _buttomCluesLabel.text = getDataClues;
        });
    }
}
 */
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text=[NSString stringWithFormat:@"%@-%ld",NSStringFromClass([self class]),indexPath.row];
    return cell;
}
#pragma mark - TableViewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
