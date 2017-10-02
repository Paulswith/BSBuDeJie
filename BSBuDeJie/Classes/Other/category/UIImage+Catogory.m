//
//  UIImage+Frame.m
//  LotteryTicket
//
//  Created by Dobby on 2017/9/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//  如何给Image分类添加快速获取属性

#import "UIImage+Catogory.h"

@implementation UIImage (Frame)
- (CGFloat)width {
    return self.size.width;
}

- (CGFloat)height {
    return self.size.height;
}
+ (UIImage *)imageNotRenderingWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
