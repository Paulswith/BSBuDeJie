//
//  BSSoundViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/15.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSSoundViewController.h"
#import "BSRefreshView.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
//#import "BSEssenceSoundModel.h"
#import "BSEssenceAllModel.h"
#import "BSEssenceAllClell.h"
#import "BSDownload.h"
#import "BSEssenceBaseCell.h"
#import <AVFoundation/AVFoundation.h>
#import "BSPlayerBoxes.h"


#define newKey Essence_sound_new
#define moreKey Essence_sound_more

static NSString * const ID = @"BSSoundViewController";
@interface BSSoundViewController ()
@property(strong,nonatomic) NSMutableArray *allModelArray;
@property(strong,nonatomic) AVPlayer *viocePlayer; //声频播放器
@end

@implementation BSSoundViewController
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
    BSEssenceBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    BSEssenceAllModel *model = _allModelArray[indexPath.row];
    cell.cellItems = model;
    // 对按钮添加声音处理事件管理
    UIView *view =  cell.contentSoundView;
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)subView;
            subBtn.tag = indexPath.row;
            [subBtn addTarget:self action:@selector(playVoice:) forControlEvents:UIControlEventTouchDown];
        }
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSEssenceAllModel *model = _allModelArray[indexPath.row];
    return model.row_height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    BSEssenceAllModel *model =  _allModelArray[indexPath.row];
    BSLog(@"model:%@",model.description);
}

#pragma mark - loadData
- (void)loadDataWithKey:(NSString *)key {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    BOOL isGetRefresh = [key hasSuffix:@"new"]; //区分是否加载更多
    NSDictionary *parameters = [BSDownload downloadParametersWithkey:key];
    
    __block NSMutableArray *tempArray = [NSMutableArray array];
    __weak UITableView *tableView = self.tableView;
    [manager  GET:BSMainRUL
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              BSLog(@"success -- url=%@",task.response.URL);
              [BSSaveToolsBox setObject:responseObject[@"info"][@"maxtime"] forKey:BSEssenceMaxTime autoSynchronize:YES];
              tempArray = [BSEssenceAllModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
              //下拉刷新的时候清空再拉取
              if (isGetRefresh) {
//                  self.allModelArray=nil;
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

#pragma mark - 声音播放
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

#pragma mark - 父类实现的方法
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
- (AVPlayer *)viocePlayer {
//    if (!_viocePlayer) {
//        _viocePlayer = [AVPlayer new];
//    }
//    return _viocePlayer;
    return [BSPlayerBoxes shareInstance].viocePlayer;
}
@end
