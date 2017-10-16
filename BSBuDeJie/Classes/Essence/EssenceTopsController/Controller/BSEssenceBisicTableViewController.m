//
//  BSEssenceBisicTableViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/15.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceBisicTableViewController.h"

static NSString * const ID = @"AllCell";
static NSString * const getDataClues = @"上拉加载可更多";
static NSString * const loadingClues = @"小的正在加载中...";
static CGFloat const topInset = 35;
static CGFloat const navigationInset = 64;
static CGFloat const bottomInset = 49 + navigationInset;


@interface BSEssenceBisicTableViewController ()
/*加载更多*/
@property (weak, nonatomic) UIImageView *imageFooterView;
@property (weak, nonatomic) UILabel *buttomCluesLabel;
@property (weak, nonatomic) UIActivityIndicatorView *buttomActivityView;
@property (assign, nonatomic,getter=isButtomRefresing) BOOL buttomRefresing;

/*下拉刷新*/
@property (weak, nonatomic) UIImageView *imageHeaderView;
@property (weak, nonatomic) UILabel *topCluesLabel;
@property (weak, nonatomic) UIActivityIndicatorView *topActivityView;
@property (assign, nonatomic,getter=isShouldRefresed) BOOL shouldRefresed;

//数据总源
@property (assign, nonatomic) NSInteger dataCount;


@end


@implementation BSEssenceBisicTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
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
    //_imageFooterView
    UIImageView *imageheaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, BSEssenseHeaderViewHeight)];
    
    //cluesLabel
    UILabel *loadMoreLabel = [[UILabel alloc] init];
    loadMoreLabel.text = @"下拉可以刷新";
    loadMoreLabel.textColor = [UIColor orangeColor];
    loadMoreLabel.textAlignment = NSTextAlignmentCenter; //置中
    loadMoreLabel.frame = _imageFooterView.bounds;
    loadMoreLabel.centerX = _imageFooterView.centerX;
    _topCluesLabel = loadMoreLabel;
    
    //_activityView
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(50, 0 , 30, 30)];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _topActivityView = activityView;
    
    [imageheaderView addSubview:activityView];
    [imageheaderView addSubview:loadMoreLabel];
    self.tableView.tableHeaderView = imageheaderView;
}
- (void)setupLoadMoreFooterView {
    //_imageFooterView
    UIImageView *imageFooterView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, 30)];
    _imageFooterView = imageFooterView;
    
    //_loadMoreLabel
    UILabel *loadMoreLabel = [[UILabel alloc] init];
    loadMoreLabel.text = getDataClues;
    loadMoreLabel.textColor = [UIColor orangeColor];
    loadMoreLabel.textAlignment = NSTextAlignmentCenter; //置中
    loadMoreLabel.frame = _imageFooterView.bounds;
    loadMoreLabel.centerX = _imageFooterView.centerX;
    _buttomCluesLabel = loadMoreLabel;
    
    //_activityView
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(50, 0 , 30, 30)];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _buttomActivityView = activityView;
    
    [_imageFooterView addSubview:activityView];
    [_imageFooterView addSubview:_buttomCluesLabel];
    self.tableView.tableFooterView=_imageFooterView;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f ---- %f",scrollView.contentOffset.y,self.tableView.contentOffset.y);
    [self headerTopView:scrollView.contentOffset.y];// 下拉刷新
    [self footerButtomView:scrollView.contentOffset.y]; //加载更多
}

- (void)headerTopView:(CGFloat)contentOffSetY {
    if (self.isShouldRefresed == YES && contentOffSetY > -BSEssenseHeaderViewHeight) { //需要刷新数据, 且已经弹回原点
        _topCluesLabel.text = @"刷新数据中....";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _dataCount += 5;
            //返回数据后需要做的事情
            [_topActivityView stopAnimating];
#warning 记得替换大型的刷新的数据
            [self.tableView reloadData];
            _topCluesLabel.text = @"下拉可以刷新";
            _shouldRefresed = NO;
        });
        return;
    }
    if (contentOffSetY < -BSEssenseHeaderViewHeight) {
        _topCluesLabel.text = @"松开即可刷新";
        [_topActivityView startAnimating];
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
