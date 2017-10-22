//
//  BSVideoTableView.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/14.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSVideoTableView.h"
#import "BSRefreshView.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "BSEssenceAllModel.h"
#import "BSEssenceAllClell.h"
#import "BSDownload.h"
#import "BSEssenceBaseCell.h"
#import "XLVideoPlayer.h"
#import "BSEssenceVideoView.h"

#define newKey Essence_video_new
#define moreKey Essence_video_more

static NSString * const ID = @"cellVideo";
@interface BSVideoTableView ()
{
    NSIndexPath *_indexPath;
    XLVideoPlayer *_player;
    CGRect _currentPlayCellRect;
}

@property(strong,nonatomic) NSMutableArray *allModelArray;

@end

@implementation BSVideoTableView
-(void)viewDidLoad {
    [super viewDidLoad];
    UINib *registerNIb = [UINib nibWithNibName:NSStringFromClass([BSEssenceBaseCell class]) bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:registerNIb forCellReuseIdentifier:ID];
    [self loadDataWithKey:newKey];
}


#pragma makr ---------------------
#pragma mark - tableviewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSEssenceAllModel *model = _allModelArray[indexPath.row];
    BSEssenceBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoPlayer:)];
//    cell.contentPhotoView addGeest
    [cell.contentVideoView addGestureRecognizer:tap];
    cell.contentVideoView.tag = indexPath.row;
    cell.cellItems = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSEssenceAllModel *model = _allModelArray[indexPath.row];
    return model.row_height;
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
#pragma mark - 父类继承必须实现的方法
- (void)doubleReloadData {
    [self loadDataWithKey:newKey];
    [self.tableView.mj_header beginRefreshing];  //里面调用了setneedDisplay 不需要super
}
- (void)loadNewData {
    [self loadDataWithKey:newKey];
    [super loadNewData];
}
- (void)loadMoreData {
    [self loadDataWithKey:moreKey];
    [super loadMoreData];
}
- (void)cleanModelArray {
    [self.allModelArray removeAllObjects];
    self.allModelArray = nil;
}
#pragma mark - 懒加载
- (NSMutableArray *)allModelArray {
    if (!_allModelArray) {
        _allModelArray =[NSMutableArray array];
    }
    return _allModelArray;
}
#pragma mark - 播放器逻辑
- (void)showVideoPlayer:(UITapGestureRecognizer *)tapGesture {
    [_player destroyPlayer];
    _player = nil;
    
    UIView *view = tapGesture.view;  // 拿到view 索引模型 cell来添加上去 tableView
    //    XLVideoItem *item = self.videoArray[view.tag - 100];
    BSEssenceAllModel *model = _allModelArray[view.tag];
    _indexPath = [NSIndexPath indexPathForRow:view.tag inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_indexPath];
    
    _player = [[XLVideoPlayer alloc] init];
    _player.videoUrl = model.videouri;
    [_player playerBindTableView:self.tableView currentIndexPath:_indexPath];
    _player.frame = view.frame;
    
    [cell.contentView addSubview:_player];
    
    _player.completedPlayingBlock = ^(XLVideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.tableView]) {
        [_player playerScrollIsSupportSmallWindowPlay:NO];
    }
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    BSLog(@"我要消失了!");
}
@end
