//
//  UIView+Frame.h
//  LotteryTicket
//
//  Created by Dobby on 2017/9/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)


/*
 1 给基类增加分类, 可以全部继承的子类都拥有
 2 分类中无法使用属性,但@property依然会生成getter和setter方法,只不过不会生成下划线的属性
 如下, 在头文件生成,在.m内部实现
 */
@property(assign,nonatomic)CGFloat width;
@property(assign,nonatomic)CGFloat height;
@property(assign,nonatomic)CGFloat x;
@property(assign,nonatomic)CGFloat y;

@end
