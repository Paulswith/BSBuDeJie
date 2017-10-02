//
//  BSStartViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSStartViewController.h"
#import "BSTabBarViewController.h"
#import "BSSaveToolsBox.h"
#import "BSADViewController.h"

#define BS_Version @"versionOfBS"
@interface BSStartViewController ()

@end

@implementation BSStartViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//}

+ (UIViewController *)keyRootViewController {
    
    /*
     mark -- 之前对比版本进入特殊控制器展示的代码
     
    UIViewController *tabbarViewController;
    NSString *currentVesion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *lastVersion = [BSSaveToolsBox objectForKey:BS_Version];
    BSLog(@"last:%@--current:%@",lastVersion,currentVesion);
//    if (![currentVesion isEqualToString:lastVersion]) {
    if ([currentVesion isEqualToString:lastVersion]) {
        tabbarViewController = [[BSADViewController alloc] init];
        //存储版本信息, 作为每次进入的比对
        [BSSaveToolsBox setObject:currentVesion forKey:BS_Version autoSynchronize:YES];
    }else {
        tabbarViewController = [[BSTabBarViewController alloc] init];
    }
    return tabbarViewController;
     */
    return [BSADViewController new];  //现在直接进入广告界面即可
}

@end
