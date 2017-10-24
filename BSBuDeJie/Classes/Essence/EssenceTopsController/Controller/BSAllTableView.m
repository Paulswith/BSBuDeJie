//
//  BSAllTableView.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/14.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSAllTableView.h"
#import "BSRefreshView.h"
#import "BSEssenceAllModel.h"
#import "BSEssenceBaseCell.h"
#import "BSDownload.h"
#import "BSEssenceVideoView.h"
#import "XLVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "XLSlider.h"


#define newKey Essence_all_new
#define moreKey Essence_all_more
static NSString * const ID = @"BSAllTableView";
/*
@interface AVPlayBE:NSObject

+ (instancetype)shareInstance;

@property(strong,nonatomic) XLVideoPlayer *_AVplayer;
@end
@implementation AVPlayBE

+ (instancetype)shareInstance {
    static AVPlayBE* _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
        _instance._AVplayer = [[XLVideoPlayer alloc]init];
    });
    return _instance;
}

@end
 */
@interface BSAllTableView ()
{
    NSIndexPath *_indexPath;
    XLVideoPlayer *_AVplayer;
//    CGRect _currentPlayCellRect;
}
//@property(strong,nonatomic) AVPlayBE *AVplayer;
@property(strong,nonatomic) AVPlayer *viocePlayer; //用来播放声音
@property(strong,nonatomic) NSMutableArray<__kindof BSEssenceAllModel *> *allModelArray;
@end

@implementation BSAllTableView
- (void)viewDidLoad {
    [super viewDidLoad];
//    _AVplayer = [AVPlayBE shareInstance];
    [self loadDataWithKey:newKey];
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
    cell.cellItems = model;
    // 视频cell进行添加手势
    if (model.type == BSEssenceTypeVideo) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoPlayer:)];
        [cell.contentVideoView addGestureRecognizer:tap];
        cell.contentVideoView.tag = indexPath.row + 100;
    }
    // 视频cell进行添加手势
    if (model.type == BSEssenceTypeSound) {
        UIView *view =  cell.contentSoundView;
        for (UIView *subView in view.subviews) {
            if ([subView isKindOfClass:[UIButton class]]) {
                UIButton *subBtn = (UIButton *)subView;
                subBtn.tag = indexPath.row;
                [subBtn addTarget:self action:@selector(playVoice:) forControlEvents:UIControlEventTouchDown];
            }
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _allModelArray[indexPath.row].row_height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    BSEssenceAllModel *model = _allModelArray[indexPath.row];

//    _AVplayer.completedPlayingBlock = ^(XLVideoPlayer *player) {
//        [player destroyPlayer];
//    };
//    _AVplayer.slider.value = 1.0;
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

#pragma mark - palyAction
- (void)showVideoPlayer:(UITapGestureRecognizer *)tapGesture {
    // 把之前的播放器干掉
    [_AVplayer destroyPlayer];
    _AVplayer = nil;
    
    // 重新载入新播放器
    UIView *view = tapGesture.view;  // 拿到view 索引模型 cell来添加上去 tableView
    BSEssenceAllModel *model = _allModelArray[view.tag - 100];
    _indexPath = [NSIndexPath indexPathForRow:view.tag - 100 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_indexPath];
    
    _AVplayer = [[XLVideoPlayer alloc] init];
//    _AVplayer = [AVPlayBE shareInstance]._AVplayer;
    _AVplayer.videoUrl = model.videouri;
    [_AVplayer playerBindTableView:self.tableView currentIndexPath:_indexPath];
    _AVplayer.frame = view.frame;
    [cell.contentView addSubview:_AVplayer];
    
    _AVplayer.completedPlayingBlock = ^(XLVideoPlayer *player) {
        [player destroyPlayer];
        _AVplayer = nil;
    };
}
- (void)playVoice:(UIButton *)sender {
    if (sender.isSelected) {
        //之前若是选中的, 就暂停. 且取消之前的选中状态
        [self.viocePlayer pause];
    }else {
        BSEssenceAllModel *model = _allModelArray[sender.tag];
        model.vioceSelect = sender.selected;
        AVPlayerItem *playVoiceItem =  [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.voiceuri]];
        //        self.playVoiceItem = playVoiceItem;
        [self.viocePlayer replaceCurrentItemWithPlayerItem:playVoiceItem];
        [self.viocePlayer play];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //是否展示视频小窗
    if ([scrollView isEqual:self.tableView]) {
        [_AVplayer playerScrollIsSupportSmallWindowPlay:NO];
    }
}

#pragma mark - lazyLoad
- (AVPlayer *)viocePlayer {
    if (!_viocePlayer) {
        _viocePlayer = [[AVPlayer alloc] init];
    }
    return _viocePlayer;
}

@end
