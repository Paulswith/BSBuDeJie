//
//  BSEssenceViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/9/27.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "UIColor+RandomColor.h"
#import "UIImage+Catogory.h"
#import "BSAddNavigationBtn.h"
#import "BSAllTableView.h"
#import "BSSoundViewController.h"
#import "BSVideoTableView.h"
#import "BSPhotoTableView.h"
#import "BSJokeTableView.h"
#import "BSNavigationController.h"
#import "BSEssenceBisicTableViewController.h"
#import "BSEssenceView.h"


#define View_Y CGRectGetMaxY(self.navigationController.navigationBar.frame)  //顶部按钮的Y值

@interface BSEssenceViewController ()<UIScrollViewDelegate>

@property(strong,nonatomic) NSArray *topBtnTitleArray; //顶部按钮的title
@property(strong,nonatomic) NSArray *topBtnVCArray; //顶部按钮的title
@property(strong,nonatomic) UIButton *selectBtn; //选中的按钮
@property(strong,nonatomic) UIScrollView *scrollView; //底层的scrollView
@property (strong, nonatomic) UIView *topBtnPlaceView;
@property (strong, nonatomic) UIView *lineView;

@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    // ABFLB2139966218
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;  //去除自动64
    //-1 设置navigation上的按钮
    [self setNavigationViewes];
    //0 添加scrollView和设置控制器
    [self setupControlView];
    //1 设置顶部的按钮
    [self setupTopSwitchView];
    
    [self topBtnTapAction:_topBtnPlaceView.subviews[0] shouldReload:YES]; //进入控制器的时候,保持选中第一个状态
    //2 监听tabbar点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarDidRepeastTap:) name:BSTabBarRepeastDidTap object:nil];
}
- (void)tabBarDidRepeastTap:(NSNotification *)notication {
    UIViewController *infoVC = notication.userInfo[BSTabBarNotiKey];
    BOOL isSelfClass = [infoVC isKindOfClass:[self class]];
    if (isSelfClass) {
        //如果是当前控制器被双击则:
        [[self getcurrentSubVCWithIndex:_selectBtn.tag] doubleReloadData];
    }
}
- (void)setupControlView {
    _topBtnVCArray = @[[BSAllTableView new],[BSVideoTableView new],[BSSoundViewController new],[BSPhotoTableView new],[BSJokeTableView new]];
    _scrollView =  [BSEssenceView essenceScrollViewWithWidth:_topBtnVCArray.count * screenW];
    _scrollView.delegate = self;
    // 添加不同的五个控制器上去
    for (int insertI = 0; insertI < _topBtnVCArray.count; insertI ++) {
        UIViewController *ableView = _topBtnVCArray[insertI];
        ableView.view.frame = CGRectMake(screenW * insertI, 0, screenW, screenH);
        [_scrollView addSubview:ableView.view];
    }
    [self.view addSubview:_scrollView];
}
- (void)setupTopSwitchView {
    // 按钮设置
    _topBtnTitleArray = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    _topBtnPlaceView =  [[UIView alloc] initWithFrame:CGRectMake(0, View_Y, screenW, 35)];
    _topBtnPlaceView.backgroundColor = BSColor(224, 224, 224);
    CGFloat width = screenW/_topBtnTitleArray.count;
    for (int i=0; i < _topBtnTitleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(width * i, 0, width, 35);
        [btn setTitle:_topBtnTitleArray[i] forState:UIControlStateNormal];
//        [btn setBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.1]];
        [btn addTarget:self action:@selector(topBtnTapAction:) forControlEvents:UIControlEventTouchDown];
        [_topBtnPlaceView addSubview:btn];
    }
    // 引导底部下划线
    CGFloat lineHeight = 2;
    CGFloat lineY = _topBtnPlaceView.height - lineHeight;
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, 30, lineHeight)];
    _lineView.backgroundColor = [UIColor redColor];
    
    [_topBtnPlaceView addSubview:_lineView];
    [self.view addSubview:_topBtnPlaceView];
}

#pragma makr ---------------------
#pragma mark - crollViewdelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger indexTag = scrollView.contentOffset.x / screenW;   //
//    NSLog(@"scrollViewDidEndDecelerating : %@,index=%ld",NSStringFromCGPoint(scrollView.contentOffset),indexTag);
    UIButton *indexBtn = _topBtnPlaceView.subviews[indexTag];
    [self topBtnTapAction:indexBtn shouldReload:NO]; // 模仿点击按钮来实现
}

#pragma mark - 按钮的点击事件,根据tag判断
- (void)topBtnTapAction:(UIButton *)sender {
    [self topBtnTapAction:sender shouldReload:YES];
}
- (void)topBtnTapAction:(UIButton *)btn shouldReload:(BOOL)reload {
    if (reload == YES && btn == _selectBtn) {
        [[self getcurrentSubVCWithIndex:btn.tag] doubleReloadData];
    }
    //点击切换背景色的逻辑
    NSInteger tag =  btn.tag;
    if (tag > _topBtnVCArray.count) {
        return;
    }
    [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _selectBtn = btn;
    // 下划线移动
    [UIView animateWithDuration:0.2 animations:^{
        _lineView.centerX = btn.centerX;
        
    }];
    //点移动conten逻辑
    CGFloat X = tag * screenW;
    [_scrollView setContentOffset:CGPointMake(X, _scrollView.contentOffset.y) animated:YES];
    
}


#pragma mark - 设置navigation上的按钮
- (void)setNavigationViewes {
    // 设置左右按钮
    UIView *leftView = [BSAddNavigationBtn addNaviBtnWithNormalImageName:@"nav_item_game_click_iconN"
                                                      highLightImageName:@"nav_item_game_click_icon"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    UIView *rightView = [BSAddNavigationBtn addNaviBtnWithNormalImageName:@"navigationButtonRandomN"
                                                       highLightImageName:@"navigationButtonRandom"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNotRenderingWithName:@"MainTitle"]];
    [titleImageView sizeToFit];
    self.navigationItem.titleView = titleImageView;
}

- (BSEssenceBisicTableViewController *)getcurrentSubVCWithIndex:(NSInteger)index {
    if (index > _topBtnVCArray.count) {
        return nil;
    }
    return _topBtnVCArray[index];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
