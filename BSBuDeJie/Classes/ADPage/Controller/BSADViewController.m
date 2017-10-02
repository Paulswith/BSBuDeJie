//
//  BSADViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSADViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "BSAdItem.h"
#import "BSTabBarViewController.h"


#define paraArgv @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface BSADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *luanchImageView;
@property (weak, nonatomic) IBOutlet UIView *ADPlaceHolder;
@property (weak, nonatomic) IBOutlet UIButton *countTime;
@property (strong, nonatomic) UIImageView *adImageView;
@property (strong, nonatomic) BSAdItem *item;
@property (weak, nonatomic) NSTimer *timer;  //自带强引用,用weak即可

@end



@implementation BSADViewController
#pragma mark - 该图作为显示在占位图上的Imageview
- (UIImageView *)adImageView {
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc] init];
        [self.ADPlaceHolder addSubview:_adImageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adImageViewTap)];
        [_adImageView addGestureRecognizer:tap];
        _adImageView.userInteractionEnabled = YES;
    }
    return _adImageView;
}
// 图片跳转地址
- (void)adImageViewTap {
    NSURL *jumpUrl = [NSURL URLWithString:_item.ori_curl];
    [[UIApplication sharedApplication] openURL:jumpUrl options:@{} completionHandler:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
#warning 还没做屏幕适配
    self.luanchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    [self setAdContent];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countTimeDo) userInfo:nil repeats:YES];
    [_countTime addTarget:self action:@selector(jumpMainController) forControlEvents:UIControlEventTouchDown];
}
- (void)countTimeDo {
    static NSInteger countTime = 5;
    if (countTime == 0) {
//        [_timer invalidate]; // 销毁定时器
        [self jumpMainController];
    }
    [self.countTime setTitle:[NSString stringWithFormat:@"点击跳过:%ld",countTime] forState:UIControlStateNormal];
    countTime --;
}
// 跳转主控制器
- (void)jumpMainController {
//    [UIView animateWithDuration:0
//                          delay:0
//                        options:0
//                     animations:^{}
//                     completion:^(BOOL finished) {
//                         [UIApplication sharedApplication].keyWindow.rootViewController = [BSTabBarViewController new];
//                         //当前无转场动画
//                     }];
    [_timer invalidate]; // 销毁定时器
    [UIApplication sharedApplication].keyWindow.rootViewController = [BSTabBarViewController new];
}

#pragma mark - 广告展示
- (void)setAdContent {
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *url = @"http://mobads.baidu.com/cpro/ui/mads.php";
    parameter[@"code2"] = paraArgv;
    
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 1先写到本地看看具体的取参
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];   // 取出字典部分
        _item =  [BSAdItem mj_objectWithKeyValues:adDict];  //转模型
//        CGFloat height = screenW / _item.w * _item.h;  // 高比高 宽比宽
        BSLog(@"广告url:%@",_item.w_picurl);
        self.adImageView.frame = CGRectMake(0, 0, screenW, screenH);
        [_adImageView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]]; //SDImage设置图片
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BSLog(@"error: %@",error);
    }];
}



@end
