//
//  BSAddNavigationBtn.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSAddNavigationBtn.h"
#import "UIImage+Catogory.h"

@implementation BSAddNavigationBtn

+ (UIView *)addNaviBtnWithNormalImageName:(NSString *)normalImageName highLightImageName:(NSString *)hlImageName {
    UIButton *btn =  [[UIButton alloc] init];
    [btn setImage:[UIImage imageNotRenderingWithName:normalImageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNotRenderingWithName:hlImageName] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    // 若是直接添加Btn到上面, 会出现按钮面积广, 需要增加一个view饶坑
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    return btnView;
}

@end
