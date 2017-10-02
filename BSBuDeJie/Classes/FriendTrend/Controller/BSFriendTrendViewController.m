//
//  BSFriendTrendViewController.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/9/27.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSFriendTrendViewController.h"
#import "BSAddNavigationBtn.h"
#import "BSLoginViewController.h"

@interface BSFriendTrendViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation BSFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_loginBtn addTarget:self action:@selector(loginTap) forControlEvents:UIControlEventTouchDown];
    UIView *leftView = [BSAddNavigationBtn addNaviBtnWithNormalImageName:@"friendsRecommentIcon"
                                   highLightImageName:@"friendsRecommentIcon-click"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.title = @"我的关注";
}
- (void)loginTap {
    [self presentViewController:[BSLoginViewController new] animated:YES completion:nil];
}

@end
