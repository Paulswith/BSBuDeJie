//
//  BSEssencePhotoView.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/20.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssencePhotoView.h"
#import "BSGifImageView.h"
#import "BSGIFImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>


@interface BSEssencePhotoView()

@end
@implementation BSEssencePhotoView
/*
+ (instancetype)photoViewWithPhotoType:(NSString *)photoType photoURL:(NSString *)photoURL {
    BSEssencePhotoView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BSEssencePhotoView class]) owner:nil options:nil] firstObject];
    if (photoType.boolValue == YES) {
        BSGifImageView *gifImageView =  [[BSGifImageView alloc] initWithFrame:CGRectMake(0, 0, screenW - 20, 300)];
//        gifImageView.backgroundColor = [UIColor grayColor];
//        [gifImageView sd_setAnimationImagesWithURLs:@[[NSURL URLWithString:photoURL]]];
        gifImageView.image = [UIImage imageNamed:@"all.gif"];
        [view.mainView addSubview:gifImageView];
    }else {
        [view shouldShowGifIcon:NO];
        UIImageView *normalImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW - 20, 300)];
        normalImageView.backgroundColor = [UIColor orangeColor];
//        [normalImageView sd_setImageWithURL:[NSURL URLWithString:photoURL]];
        [view.mainView addSubview:normalImageView];
    }
    return view;
    /*
     1 内存飙升, imageView没有循环, 因为不属于里面的View
     

*/
+ (instancetype)photoViewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}


@end
