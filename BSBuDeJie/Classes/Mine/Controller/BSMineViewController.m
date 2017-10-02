
//
//  BSMineViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSMineViewController.h"
#import "UIColor+RandomColor.h"
#import "BSAddNavigationBtn.h"
#import "BSSettingController.h"

@interface BSMineViewController ()

@end

@implementation BSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    [self setupRightBtnAndTitle];
}
#pragma mark - setupRightBtnes
- (void)setupRightBtnAndTitle {
    UIView *moonView = [BSAddNavigationBtn addNaviBtnWithNormalImageName:@"mine-moon-icon"
                                   highLightImageName:@"mine-moon-icon-click"];
    UIView *settingView = [BSAddNavigationBtn addNaviBtnWithNormalImageName:@"mine-setting-icon"
                                                         highLightImageName:@"mine-setting-icon-click"];
    UIButton *moonBtn = moonView.subviews[0];
    UIButton *settingBtn = settingView.subviews[0];
    [moonBtn addTarget:self action:@selector(moonTouch) forControlEvents:UIControlEventTouchDown];
    [settingBtn addTarget:self action:@selector(settingTouch) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *moonViewItem = [[UIBarButtonItem alloc] initWithCustomView:moonView];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:settingView];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonViewItem];
    self.navigationItem.title = @"我的";
    
}
- (void)moonTouch {
    NSLog(@"%s",__func__);
}
- (void)settingTouch {
//    NSLog(@"%s",__func__);
//    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[BSSettingController new] animated:YES];
}
@end
