//
//  UIImage+Frame.h
//  LotteryTicket
//
//  Created by Dobby on 2017/9/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Frame)

@property(assign,nonatomic)CGFloat width;
@property(assign,nonatomic)CGFloat height;

+ (UIImage *)imageNotRenderingWithName:(NSString *)name;
@end
