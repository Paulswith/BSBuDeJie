//
//  BSPlayerBoxes.h
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/24.
//  Copyright © 2017年 Dobby. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class XLVideoPlayer;



@interface BSPlayerBoxes : NSObject


+ (instancetype)shareInstance;
@property(strong,nonatomic) XLVideoPlayer *videoPlayer; //
@property(strong,nonatomic) AVPlayer *viocePlayer; //


@end
