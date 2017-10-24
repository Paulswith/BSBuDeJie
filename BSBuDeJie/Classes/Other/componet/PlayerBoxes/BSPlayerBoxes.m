//
//  BSPlayerBoxes.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/24.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSPlayerBoxes.h"
#import "XLVideoPlayer.h"


@implementation BSPlayerBoxes


+ (instancetype)shareInstance {
    static BSPlayerBoxes* _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
        _instance.videoPlayer = [[XLVideoPlayer alloc]init];
        _instance.viocePlayer = [[AVPlayer alloc] init];
    });
    return _instance;
}
@end
