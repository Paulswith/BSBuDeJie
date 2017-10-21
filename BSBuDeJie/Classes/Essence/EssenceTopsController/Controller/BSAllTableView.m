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
#import "BSEssenceBaseCell.h"
#import "BSDownload.h"
#import "BSEssencePhotoView.h"

#define newKey Essence_all_new
#define moreKey Essence_all_more
static NSString * const ID = @"cellALL";

@interface BSAllTableView ()
@property(strong,nonatomic) NSMutableArray<__kindof BSEssenceAllModel *> *allModelArray;
@end

@implementation BSAllTableView
-(void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataWithKey:newKey];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanModelArray) name:BSSettingsCleanCacheNoti object:nil];
    
    UINib *registerNIb = [UINib nibWithNibName:NSStringFromClass([BSEssenceBaseCell class]) bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:registerNIb forCellReuseIdentifier:ID];
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
        [responseObject writeToFile:@"/Users/mac/Desktop/Vie/all.plist" atomically:YES];

        //下拉刷新的时候清空再拉取
        if (isGetRefresh) {
            [self cleanModelArray];
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
    BSEssenceBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    BSEssenceAllModel *model = _allModelArray[indexPath.row];
    cell.cellItems = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _allModelArray[indexPath.row].row_height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    BSEssenceAllModel *model = _allModelArray[indexPath.row];
    NSLog(@"%@ ",model.description);
}

#pragma mark - 父类的一堆方法
- (void)doubleReloadData {
    [self loadDataWithKey:newKey];
    [self.tableView.mj_header beginRefreshing];
}
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
- (void)cleanModelArray {
    [self.allModelArray removeAllObjects];
    self.allModelArray = nil;
}
#warning Mark一个bug, 清除缓存再双击tab,则gif不播放了,类似是按了暂停,或者载入的缓存图以清除,但gifImage不知道
//-(void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

@end
