//
//  BSLoadMoreView.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/17.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSLoadMoreView.h"

@implementation BSLoadMoreView

- (void)prepare
{
    [super prepare];
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
