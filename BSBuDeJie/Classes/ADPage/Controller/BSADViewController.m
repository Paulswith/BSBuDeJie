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
@property (weak, nonatomic) IBOutlet UIImageView *holderImageVie;
@property (weak, nonatomic) IBOutlet UIButton *countTime;
@property (weak, nonatomic) NSTimer *timer;  //自带强引用,用weak即可
@property (strong, nonatomic) BSAdItem *item;

@end

#pragma mark - 倒计时总时长
static NSInteger timeCount = 5;

@implementation BSADViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addJumpBtnGesture];//添加点击手势
    #warning 还没做屏幕适配
    _luanchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    [self setAdImageViewContent];
}
#pragma mark - 跳转逻辑
- (void)addJumpBtnGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adImageViewTap)];
    [_holderImageVie addGestureRecognizer:tap];
    _holderImageVie.userInteractionEnabled = YES;
}
- (void)adImageViewTap {
    NSURL *jumpUrl = [NSURL URLWithString:_item.ori_curl];
    [[UIApplication sharedApplication] openURL:jumpUrl options:@{} completionHandler:nil];
}
- (void)countTimeDo {
    --timeCount;
    if (timeCount == 0) [self jumpMainController];
    [self.countTime setTitle:[NSString stringWithFormat:@"点击跳过:%ld",timeCount] forState:UIControlStateNormal];
}
#pragma mark - 跳转主控制器
- (void)jumpMainController {
    if (_timer) [_timer invalidate]; // 销毁定时器
    [UIApplication sharedApplication].keyWindow.rootViewController = [BSTabBarViewController new];
}

#pragma mark - 广告图拉取
- (void)setAdImageViewContent {
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *url = @"http://mobads.baidu.com/cpro/ui/mads.php";
    parameter[@"code2"] = paraArgv;
    
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];   // 取出字典部分
        _item =  [BSAdItem mj_objectWithKeyValues:adDict];  //转模型
        BSLog(@"广告url:%@",_item.w_picurl);
        [self setAdViewWithURL:_item.w_picurl];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BSLog(@"error: %@",error);
    }];
}
#pragma mark - 有无广告逻辑处理
- (void)setAdViewWithURL:(NSString *)url {
    if ([url hasPrefix:@"http"]) {
        [_luanchImageView removeFromSuperview];
        [_holderImageVie sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) BSLog(@"download ADImage : %@",error);
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countTimeDo) userInfo:nil repeats:YES];
            [_countTime addTarget:self action:@selector(jumpMainController) forControlEvents:UIControlEventTouchDown];
        }];
    }else {
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(jumpMainController) userInfo:nil repeats:NO];
    }
    
}

@end
