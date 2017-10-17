//
//  BSTabBarViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/9/27.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSTabBarViewController.h"
#import "BSEssenceViewController.h"
#import "BSFriendTrendViewController.h"
#import "BSMineViewController.h"
#import "BSNewPostViewController.h"
#import "UIImage+Catogory.h"
#import "BSTabBar.h"
#import "BSNavigationController.h"



@interface BSTabBarViewController ()

@property (strong, nonatomic) id selectTabBar;  //用来确认是否当前页面的第二次点击
@property (strong, nonatomic) NSMutableArray *childVC; //用来保存控制器,方便索引
@end

@implementation BSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildrenControl];
    [self replaceCustomTabbar];
    //初始化已选按钮 赋值, 默认为第一个
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //给所有按钮子控件添加点击事件监听 中间那个就不需要了,这样子才能和索引对的上
    for (id subTabBar in self.tabBar.subviews) {
        if ([subTabBar isKindOfClass:NSClassFromString(@"UITabBarButton")] ) {
            if (!_selectTabBar) {
                _selectTabBar = subTabBar;  //首次进入,需要保存精华Tabbar为第一个
            }
            [subTabBar addTarget:self action:@selector(tabbarTap:) forControlEvents:UIControlEventTouchDown];
        }
    }
}
- (void)tabbarTap:(id)tapBtn {
    if (_selectTabBar == tapBtn ) {
        //对当前控制器二次点击就抛通知
        BSNavigationController *navi = _childVC[self.selectedIndex];
//        BSLog(@"BSTabBarNotiKey = %@",navi);
        [[NSNotificationCenter defaultCenter] postNotificationName:BSTabBarRepeastDidTap
                                                            object:nil userInfo:@{
                                                                                  BSTabBarNotiKey:navi,
                                                                                  }];
         }
    _selectTabBar = tapBtn;
    
}

#pragma mark - 替换为自定义的Tabbar
- (void)replaceCustomTabbar {
    // 1 因为是只读属性, 利用KVC, 替换为创建的TabBar, 新建子控制器,设置子控制器的属性,添加到tabbar, 实现中间是加号类型
    BSTabBar *tabbar = [[BSTabBar alloc] init];
    [self setValue:tabbar forKey:@"tabBar"];
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
//    [self addChildViewController:[self childViewControlName:[BSPublishViewController new]
//                                                      title:@"发布"
//                                                  imageName:@"publish"]];
    [self addChildViewController:[self childViewControlName:[BSFriendTrendViewController new]
                                                      title:@"关注"
                                                  imageName:@"friendTrends"]];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:NSStringFromClass([BSMineViewController class]) bundle:nil];
    BSMineViewController *mineVC =  [storyBoard instantiateInitialViewController];
    [self addChildViewController:[self childViewControlName:mineVC
                                                      title:@"我"
                                                  imageName:@"me"]];
}

#pragma mark - 创建控制器方法
- (UIViewController *)childViewControlName:(UIViewController *)Control title:(NSString *)title imageName:(NSString *)imageName{
    [self.childVC addObject:Control];  //可变数组, 不可用下划线访问的意思? 刚才_childVC一直失败
    NSString *normalImageName = [NSString stringWithFormat:@"tabBar_%@_icon",imageName];
    NSString *selectImageName = [NSString stringWithFormat:@"tabBar_%@_click_icon",imageName]; //tabBar_essence_click_icon
    //设置富文本属性
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor redColor];
    [Control.tabBarItem setTitleTextAttributes:att forState:UIControlStateSelected];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [Control.tabBarItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    Control.tabBarItem.title = title;
    Control.tabBarItem.image = [UIImage imageNotRenderingWithName:normalImageName];
    Control.tabBarItem.selectedImage = [UIImage imageNotRenderingWithName:selectImageName];
    return [[BSNavigationController alloc] initWithRootViewController:Control];
}
- (NSMutableArray *)childVC {
    if (!_childVC) {
        _childVC = [NSMutableArray array];
    }
    return _childVC;
}
@end
