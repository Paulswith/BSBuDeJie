//
//  BSAllTableView.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/14.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSAllTableView.h"
#import "BSRefreshView.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "BSEssenceAllModel.h"
//#import "BSEssenceAllClell.h"
#import "BSEssenceBaseCell.h"
#import "BSDownload.h"

#define newKey Essence_all_new
#define moreKey Essence_all_more
static NSString * const ID = @"cellALL";
@interface BSAllTableView ()

@property(strong,nonatomic) NSMutableArray<__kindof BSEssenceAllModel *> *allModelArray;

@end

@implementation BSAllTableView
-(void)viewDidLoad {
    [super viewDidLoad];
    UINib *registerNIb = [UINib nibWithNibName:NSStringFromClass([BSEssenceBaseCell class]) bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:registerNIb forCellReuseIdentifier:ID];
    [self loadDataWithKey:newKey];
//    self.tableView.rowHeight = 250;
}
#pragma mark - loadData 
- (void)loadDataWithKey:(NSString *)key {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    BOOL isGetRefresh = [key hasSuffix:@"new"]; //区分是否加载更多
    NSDictionary *parameters = [BSDownload downloadParametersWithkey:key];
    
    __block NSMutableArray *tempArray = [NSMutableArray array];
    __weak UITableView *tableView = self.tableView;
    [manager GET:BSMainRUL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BSLog(@"success -- url=%@",task.response.URL);
        [BSSaveToolsBox setObject:responseObject[@"info"][@"maxtime"] forKey:BSEssenceMaxTime autoSynchronize:YES];
        tempArray = [BSEssenceAllModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //下拉刷新的时候清空再拉取
        if (isGetRefresh) {
            self.allModelArray=nil;
            for (BSEssenceAllModel *model in tempArray) {
                [self.allModelArray addObject:model];
            }
        }else {
            // 加载更多的就叠加
            for (BSEssenceAllModel *model in tempArray) {
                [self.allModelArray addObject:model];
            }
        }
        [tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BSLog(@"failure -- url=%@, Error=%@",task.response.URL,error);
    }];
}

#pragma makr ---------------------
#pragma mark - tableviewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    BSEssenceBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
#warning 思路 根据类型判断, 如果是A类型,直接让A类型返回一个方法View, 直接赋值即可\
    但是高度可能要重新处理下,每个类需要针对此处理下. 可以自定义各自的xib, 声音xib下面是有最佳评论的,所以必须为uiview类型,让它自己处理好扔给我们就好
    
    BSEssenceBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    BSEssenceAllModel *model = _allModelArray[indexPath.row];
    cell.cellItems = model;
    return cell;
}
//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _allModelArray[indexPath.row].text_height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    BSEssenceAllModel *model = _allModelArray[indexPath.row];
    NSLog(@"%@ // %f",model.text,model.text_height);
}


- (void)doubleReloadData {
    [self loadDataWithKey:newKey];
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - 上下拉方法实现
- (void)loadNewData {
    [self loadDataWithKey:newKey];
    [super loadNewData];
}

- (void)loadMoreData {
    [self loadDataWithKey:moreKey];
    [super loadMoreData];
}

- (NSMutableArray *)allModelArray {
    if (!_allModelArray) {
        _allModelArray =[NSMutableArray array];
    }
    return _allModelArray;
}
@end
