
//
//  BSEssenceVideoView.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/20.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceVideoView.h"
#import "BSEssenceAllModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface BSEssenceVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *videoCover;
@property (weak, nonatomic) IBOutlet UIImageView *playBtn;

@end
@implementation BSEssenceVideoView

+ (instancetype)videoViewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}
- (void)setVideoModel:(BSEssenceAllModel *)videoModel {
    _videoModel = videoModel;
    
    NSURL *imageURL = [NSURL URLWithString:videoModel.cdn_img];
    [_videoCover sd_setImageWithURL:imageURL];
}


@end
