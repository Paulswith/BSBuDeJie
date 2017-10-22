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
#import "XLVideoPlayer.h"
//#import "BSEssencePhotoView.h"
#import "BSEssenceVideoView.h"

#define newKey Essence_all_new
#define moreKey Essence_all_more
static NSString * const ID = @"cellALL";

@interface BSAllTableView ()
{
    NSIndexPath *_indexPath;
    XLVideoPlayer *_player;
    CGRect _currentPlayCellRect;
}

@property(strong,nonatomic) NSMutableArray<__kindof BSEssenceAllModel *> *allModelArray;
@end

@implementation BSAllTableView
-(void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataWithKey:newKey];
    UINib *registerNIb = [UINib nibWithNibName:NSStringFromClass([BSEssenceBaseCell class]) bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:registerNIb forCellReuseIdentifier:ID];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    _videoPlayer = [[XLVideoPlayer alloc] init]; 
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

#pragma makr ---------------------
#pragma mark - tableviewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSEssenceAllModel *model = _allModelArray[indexPath.row];
    BSEssenceBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (model.type == BSEssenceTypeVideo) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoPlayer:)];
        [cell.contentVideoView addGestureRecognizer:tap];
        cell.contentVideoView.tag = indexPath.row + 100;
    }
    
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
//    _videoPlayer = nil;
//}

- (void)showVideoPlayer:(UITapGestureRecognizer *)tapGesture {
    [_player destroyPlayer];
    _player = nil;
    
    UIView *view = tapGesture.view;  // 拿到view 索引模型 cell来添加上去 tableView
//    XLVideoItem *item = self.videoArray[view.tag - 100];
    BSEssenceAllModel *model = _allModelArray[view.tag - 100];
    _indexPath = [NSIndexPath indexPathForRow:view.tag - 100 inSection:0];
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
//    _player 
}

@end
