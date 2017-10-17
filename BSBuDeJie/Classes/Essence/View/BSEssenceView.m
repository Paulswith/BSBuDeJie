//
//  BSEssenceView.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/18.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceView.h"

@implementation BSEssenceView

+ (instancetype)essenceScrollViewWithWidth:(CGFloat)width {
    
    BSEssenceView *scroll = [[self alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    scroll.contentSize = CGSizeMake(width, 0);
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.bounces = NO;
    scroll.pagingEnabled = YES;
    scroll.scrollEnabled = YES;
    scroll.backgroundColor = [UIColor grayColor];
    return scroll;
}
@end
