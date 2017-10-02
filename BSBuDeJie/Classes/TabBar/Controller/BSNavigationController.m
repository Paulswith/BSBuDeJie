//
//  BSNavigationController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSNavigationController.h"

@interface BSNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BSNavigationController
+ (void)load {
    // 全局设置naviagation
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [bar setTitleTextAttributes:dict];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     通过此方法处理全屏返回
     1 通过代理方法拿到target,也是handleNavigationTransition:的处理对象UIGestureRecognizer
     2 获取系统handleNavigationTransition: 使用系统的来处理全屏滑动
     3 代理会把自己传过来~
     */
    id target = self.interactivePopGestureRecognizer.delegate;  //会拿到系统的interactivePopGestureRecognizer
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];   // 转交给interactivePopGestureRecognizer内部的方法来判断处理
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO; 
    pan.delegate = self;
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.viewControllers.count > 1 ? YES : NO;  //栈顶之外的说明不是根控制器,允许滑动. else不允许滑动返回
}

#pragma mark - 隐藏tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {  //判断非栈底控制器,需要隐藏下tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
