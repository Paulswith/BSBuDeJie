//
//  BSHeadBottomBtn.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/3.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSHeadBottomBtn.h"

@implementation BSHeadBottomBtn

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.y = 0;  //image固定y轴,在起点
    self.imageView.centerX = self.width/2;  //移动到整个btn中心
    
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);  //位于image下发
    [self.titleLabel sizeToFit];// 自适应字体后再排版
    self.titleLabel.centerX = self.width/2;  //移动到整个btn中心
}

@end
