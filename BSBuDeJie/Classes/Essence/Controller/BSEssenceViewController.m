//
//  BSEssenceViewController.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/9/27.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "UIColor+RandomColor.h"
#import "UIImage+Catogory.h"
#import "BSAddNavigationBtn.h"

@interface BSEssenceViewController ()

@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    [self setNavigationViewes]; // 设置navigation上的按钮们
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


@end
