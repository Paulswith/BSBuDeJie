
//
//  BSMineViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSMineViewController.h"
#import "BSAddNavigationBtn.h"
#import "BSSettingController.h"
#import "BSCollectionViewCell.h"
#import "BSMineCollectionItem.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SafariServices/SafariServices.h>
#import "BSBrowerController.h"


#pragma mark - 静态全局变量
static NSString * const ID = @"cellID";
static NSInteger const countOfLine = 4;
static CGFloat const spaceOfColumn = 2; //列间距

@interface BSMineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *mineItemGroup;
@property (assign, nonatomic) CGFloat collectionItemHeight;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation BSMineViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _mineItemGroup = [NSMutableArray array];
    [self setupFooterView];
    [self setupRightBtnAndTitle];
    [self loadCollectionViewData];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setNeedsLayout];
    // mark bugFix, 与webView交互的情况下, navigationBar刷新布局
}
- (void)setupFooterView {
    //流水布局处理
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = spaceOfColumn;
    layout.minimumInteritemSpacing = spaceOfColumn;
    layout.itemSize = ({
        NSInteger columnCountOfLine = countOfLine - 1; //几条竖线
        //计算公式为, 减去列间距 / 行个数
        CGFloat sizeWH = (screenW - columnCountOfLine * spaceOfColumn) /countOfLine;
        CGSize size = CGSizeMake(sizeWH, sizeWH);
        _collectionItemHeight = sizeWH;
        size;
    });
    
    //设置collectionView位置
    _collectionView = ({
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 400) collectionViewLayout:layout];
        collection.backgroundColor = self.tableView.backgroundColor;
        collection.dataSource = self;
        collection.delegate = self;
        collection.scrollEnabled = NO; //无须滚动
//        collection.alwaysBounceHorizontal = YES;
        collection;
    });
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);  //日常处理tableView的自动inset偏移64  /挤出一个微笑/
    self.tableView.tableFooterView = _collectionView;
    //注册cell
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([BSCollectionViewCell class]) bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:ID];
    
}
- (void)loadCollectionViewData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *minePageAPI = @"http://api.budejie.com/api/api_open.php";
    NSDictionary *parameters = @{
                                 @"a":@"square",
                                 @"c":@"topic"
                                 };
    [manager GET:minePageAPI parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _mineItemGroup = [BSMineCollectionItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        BSLog(@"MinePage -- success count:%ld",_mineItemGroup.count);
        //拉取到数据后重新调整高度
        _collectionView.height = ({
            NSInteger row = (_mineItemGroup.count - 1)/countOfLine + 1;
            row * _collectionItemHeight + row * spaceOfColumn; // 行数*高度 + 间距*行数
        });
        [self resoveEmpty]; //处理空挡
        [_collectionView reloadData];
        /*
         mark 大bug修复
         1 无需设置self.tableView.contentSize,用此方法刷新当前的section自动计算contentSize
         2 不然你在任何地方加, 但是没给tableView一个自己计算自己的机会,永远都不会休止的
         */
        [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BSLog(@"MinePage -- failure:%@--url:%@",error,task.response.URL);
    }];
}
- (void)resoveEmpty {
    // 计算求余公式为: 总数/行数 % 行数
    NSInteger remainCount = (_mineItemGroup.count / countOfLine) % countOfLine ;
    // 若有余,则遍历增加空挡item
    if (remainCount) {
        for (NSInteger i=0; i<remainCount; i++) {
            [_mineItemGroup addObject:[BSMineCollectionItem new]];
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mineItemGroup.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.cellOfMineItem = _mineItemGroup[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BSMineCollectionItem *item = _mineItemGroup[indexPath.row];
    if ([item.url hasPrefix:@"http"]) {
        NSURL *jumpURL = [NSURL URLWithString:item.url];
        BSBrowerController *brower = [[BSBrowerController alloc] init];
        brower.url = jumpURL;
        [self.navigationController pushViewController:brower animated:YES];
    }
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //取消选中
}

#pragma mark - setupRightBtnes
- (void)setupRightBtnAndTitle {
    UIView *moonView = [BSAddNavigationBtn addNaviBtnWithNormalImageName:@"mine-moon-icon"
                                   highLightImageName:@"mine-moon-icon-click"];
    UIView *settingView = [BSAddNavigationBtn addNaviBtnWithNormalImageName:@"mine-setting-icon"
                                                         highLightImageName:@"mine-setting-icon-click"];
    UIButton *moonBtn = moonView.subviews[0];
    UIButton *settingBtn = settingView.subviews[0];
    [moonBtn addTarget:self action:@selector(moonTouch) forControlEvents:UIControlEventTouchDown];
    [settingBtn addTarget:self action:@selector(settingTouch) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *moonViewItem = [[UIBarButtonItem alloc] initWithCustomView:moonView];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:settingView];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonViewItem];
    self.navigationItem.title = @"我的";
    
}
- (void)moonTouch {
#warning moonSkinNone
    NSLog(@"%s",__func__);
}
- (void)settingTouch {
    [self.navigationController pushViewController:[BSSettingController new] animated:YES];
}







@end
