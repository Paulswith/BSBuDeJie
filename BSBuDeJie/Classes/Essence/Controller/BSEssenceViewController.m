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
#import "BSEssenceTableView.h"
#import "BSVideoTableView.h"
#import "BSPhotoTableView.h"
#import "BSJokeTableView.h"


#define View_Y CGRectGetMaxY(self.navigationController.navigationBar.frame)  //顶部按钮的Y值
#define btnCount 5   //顶部按钮的数量

@interface BSEssenceViewController ()<UIScrollViewDelegate>

@property(strong,nonatomic) NSArray *topBtnTitleArray; //顶部按钮的title
@property(strong,nonatomic) NSArray *topBtnVCArray; //顶部按钮的title
@property(strong,nonatomic) UIButton *selectBtn; //选中的按钮
@property(strong,nonatomic) UIScrollView *downScrollView; //底层的scrollView

@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;  //去除自动64
    [self setNavigationViewes]; // 设置navigation上的按钮
    
    //0 添加scrollView先, 这样子可以让按钮在上面
    [self setupScrollView];
    //1 设置顶部的按钮
    [self setupTopView];
    
}
- (void)setupScrollView {
    _topBtnVCArray = @[[BSAllTableView new],[BSEssenceTableView new],[BSVideoTableView new],[BSPhotoTableView new],[BSJokeTableView new]];
//    _downScrollView =  [[UIScrollView alloc] initWithFrame:CGRectMake(0, View_Y, screenW, self.view.height)]; //左右移动的时候会偏移64
    _downScrollView =  ({
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenW, self.view.height)];
        scroll.contentSize = CGSizeMake(5 * screenW, 0);
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.bounces = NO;
        scroll.pagingEnabled = YES;
        scroll.scrollEnabled = YES;
        scroll.delegate = self;
        scroll;
    });
    // 添加不同的View上去
    for (int insertI = 0; insertI < btnCount; insertI ++) {
        UIViewController *ableView = _topBtnVCArray[insertI];
        ableView.view.frame = CGRectMake(screenW * insertI, 0, screenW, screenH);
        [_downScrollView addSubview:ableView.view];
    }
    [self.view addSubview:_downScrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}

#pragma mark - 设置navigation上的按钮们
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

- (void)setupTopView {
    _topBtnTitleArray = @[@"全部",@"精华",@"视频",@"图片",@"段子"];
    UIView *topBtnPlaceView =  [[UIView alloc] initWithFrame:CGRectMake(0, View_Y, screenW, 35)];
    CGFloat width = screenW/btnCount;
    for (int i=0; i < btnCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width * i, 0, width, 35);
        [btn setTitle:_topBtnTitleArray[i] forState:UIControlStateNormal];
        [topBtnPlaceView addSubview:btn];
        btn.tag = i;
        [btn setBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.1]];
        [btn addTarget:self action:@selector(topBtnTapAction:) forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:topBtnPlaceView];
}

#pragma mark - 按钮的点击事件,根据tag判断
- (void)topBtnTapAction:(UIButton *)btn {
    //点击切换背景色的逻辑
    NSInteger tag =  btn.tag;
    [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _selectBtn = btn;
    
    //点移动conten逻辑
    CGFloat X = tag * screenW;
    [_downScrollView setContentOffset:CGPointMake(X, _downScrollView.contentOffset.y) animated:YES];
    
}
@end
