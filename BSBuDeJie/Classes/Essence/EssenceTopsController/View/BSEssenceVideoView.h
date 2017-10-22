//
//  BSEssenceVideoView.h
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/20.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSEssenceAllModel;

@interface BSEssenceVideoView : UIView

@property (strong, nonatomic) BSEssenceAllModel *videoModel;


+ (instancetype)videoViewFromXib;
@end
