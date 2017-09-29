//
//  BSTabBarViewController.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/9/27.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSTabBarViewController.h"
#import "BSEssenceViewController.h"
#import "BSFriendTrendViewController.h"
#import "BSMineViewController.h"
#import "BSNewPostViewController.h"
#import "BSPublishViewController.h"
#import "UIImage+Catogory.h"



@interface BSTabBarViewController ()

@end

@implementation BSTabBarViewController

//+ (void)load {
//    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[BSTabBarViewController class]]];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1 新建子控制器,设置子控制器的属性,添加到tabbar
    [self setupChildrenControl];

}
#pragma mark - 添加子控制器
- (void)setupChildrenControl
{
    // 精华 新帖 发布 关注 我
    [self addChildViewController:[self childViewControlName:[BSEssenceViewController new]
                                                      title:@"精华"
                                                  imageName:@"essence"]];
    [self addChildViewController:[self childViewControlName:[BSNewPostViewController new]
                                                      title:@"新帖"
                                                  imageName:@"new"]];
    [self addChildViewController:[self childViewControlName:[BSPublishViewController new]
                                                      title:@"发布"
                                                  imageName:@"publish"]];
    [self addChildViewController:[self childViewControlName:[BSFriendTrendViewController new]
                                                      title:@"关注"
                                                  imageName:@"friendTrends"]];
    [self addChildViewController:[self childViewControlName:[BSMineViewController new]
                                                      title:@"我"
                                                  imageName:@"me"]];
}

#pragma mark - 创建控制器方法
- (UIViewController *)childViewControlName:(UIViewController *)Control title:(NSString *)title imageName:(NSString *)imageName{
    
    NSString *normalImageName = [NSString stringWithFormat:@"tabBar_%@_icon",imageName];
    NSString *selectImageName = [NSString stringWithFormat:@"tabBar_%@_click_icon",imageName]; //tabBar_essence_click_icon
    //设置富文本属性
    if (![Control isKindOfClass:[BSPublishViewController class]]) {
        NSMutableDictionary *att = [NSMutableDictionary dictionary];
        att[NSForegroundColorAttributeName] = [UIColor redColor];
        [Control.tabBarItem setTitleTextAttributes:att forState:UIControlStateSelected];
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        [Control.tabBarItem setTitleTextAttributes:attr forState:UIControlStateNormal];
        Control.tabBarItem.title = title;
    }else {
        Control.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    Control.tabBarItem.image = [UIImage imageNotRenderingWithName:normalImageName];
    Control.tabBarItem.selectedImage = [UIImage imageNotRenderingWithName:selectImageName];
    self.tabBar
    return [[UINavigationController alloc] initWithRootViewController:Control];
}

@end