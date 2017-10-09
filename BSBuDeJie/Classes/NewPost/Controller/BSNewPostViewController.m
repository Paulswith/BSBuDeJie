//
//  BSNewPostViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/9/27.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSNewPostViewController.h"
#import "UIColor+RandomColor.h"
#import "BSAddNavigationBtn.h"
#import "UIImage+Catogory.h"
#import "BSMyFollowViewController.h"


@interface BSNewPostViewController ()

@end

@implementation BSNewPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    //设置左做牛
    UIView *leftView = [BSAddNavigationBtn addNaviBtnWithNormalImageName:@"MainTagSubIcon"
                                                  highLightImageName:@"MainTagSubIconClick"];
    UIButton *btn = leftView.subviews[0];
    [btn addTarget:self action:@selector(tapFollow) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNotRenderingWithName:@"MainTitle"]];
    [titleImageView sizeToFit];
    self.navigationItem.titleView = titleImageView;
}

- (void)tapFollow {
    [self.navigationController pushViewController:[BSMyFollowViewController new] animated:YES];
}

@end
