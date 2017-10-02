//
//  BSMyFollowViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/2.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSMyFollowViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "BSTableViewCell.h"
#import "BSFollowItem.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface BSMyFollowViewController ()

@property (strong, nonatomic) NSArray *groupArray;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation BSMyFollowViewController

static NSString  * const cellIndentifier = @"cellInden";

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD showWithStatus:@"正在加载中..."]; //提示语
    [self loadJson];
    self.navigationItem.title = @"推荐关注";
    //1 分割线乱来-清空处理
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    //2 分割线乱来- 重写系统方法处理
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //取消分割线
    self.tableView.backgroundColor = BSColor(220, 220, 221);    // 设置tableView背景颜色
    UINib *registerNib = [UINib nibWithNibName:NSStringFromClass([BSTableViewCell class]) bundle:nil];
    [self.tableView registerNib:registerNib forCellReuseIdentifier:cellIndentifier];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    [_manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
}
#pragma mark - 内容请求
- (void)loadJson {
    _manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *url = @"http://d.api.budejie.com/forum/subscribe/bs0315-iphone-4.5.7.json";
    [_manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];  //成功销毁提示语
        _groupArray = [BSFollowItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"What a Error!"]; //失败新提示语
        BSLog(@"%@",error);
    }];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier    forIndexPath:indexPath];
    BSFollowItem *item = _groupArray[indexPath.row];
    cell.setCellItem = item;
    return cell;
}
#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;//合理高度,对齐xib的高度
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //取消选中状态
}
@end
