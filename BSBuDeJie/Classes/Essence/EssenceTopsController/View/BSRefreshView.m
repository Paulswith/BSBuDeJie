//
//  BSRefreshView.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/17.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSRefreshView.h"

@implementation BSRefreshView

- (void)prepare {
    [super prepare];
    // 设置普通状态的动画图片
    NSArray *idleImages = @[[UIImage imageNamed:@"refresh__normal"]];
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        NSString *imageName_ = [NSString stringWithFormat:@"refresh_%zd", i];
        UIImage *image = [UIImage imageNamed:imageName_];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    
    
    
}

@end
