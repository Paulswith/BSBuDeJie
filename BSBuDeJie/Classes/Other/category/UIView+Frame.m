//
//  UIView+Frame.m
//  LotteryTicket
//
//  Created by Dobby on 2017/9/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//  如何给View的分类添加简单的一步到frame

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect tempRect = self.frame;
    tempRect.size.width = width;
    self.frame = tempRect;
}

- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect tempRect = self.frame;
    tempRect.size.height = height;
    self.frame = tempRect;
}

- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect tempRect = self.frame;
    tempRect.origin.x = x;
    self.frame = tempRect;
}

- (CGFloat)y {
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y {
    CGRect tempRect = self.frame;
    tempRect.origin.y = y;
    self.frame = tempRect;
}

@end
