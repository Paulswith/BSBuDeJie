//
//  BSLoginViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/3.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSLoginViewController.h"
#import "BSLoginAndRegisterView.h"
#import "BSQuickLogin.h"


@interface BSLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginLargeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewCons;
@property (weak, nonatomic) IBOutlet UIView *quickLoginBottomView;

@end

@implementation BSLoginViewController
- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)selectRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
//    BSLog(@"constant:%f",_largeViewTrailing.constant);
//    BSLog(@"width:%f",_loginLargeView.width);
    /*
     踩坑记
     1 先让view等宽于屏幕,(只有是宽度才有乘法得增, Constraint乘法是压缩等比) 令view等于两倍父view * 2
     2 设置Leading等于父vew
     3 leading移动一个屏幕宽度
     
     */
    _loginViewCons.constant = (_loginViewCons.constant == 0 ?  -_loginLargeView.width/2 : 0);
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];  //重新绘制
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupSubViews];
}

#pragma mark - 子控件安装
- (void)setupSubViews {
    //登陆注册输入框
    BSLoginAndRegisterView *loginView =  [BSLoginAndRegisterView loginView];
    loginView.frame = CGRectMake(0, 0, _loginLargeView.width/2, _loginLargeView.height);
    [_loginLargeView addSubview:loginView];
    
    BSLoginAndRegisterView *registerView = [BSLoginAndRegisterView registerView];
    loginView.frame = CGRectMake(_loginLargeView.width/2, 0, _loginLargeView.width/2, _loginLargeView.height);
//    registerView.x = _loginLargeView.width / 2;  //设置移动到屏幕之外
    [_loginLargeView addSubview:registerView];
    //快速登陆
    BSQuickLogin *quickLoginView = [BSQuickLogin quickLoginView];
    quickLoginView.frame = _quickLoginBottomView.bounds;
    [_quickLoginBottomView addSubview:quickLoginView];
}



@end
