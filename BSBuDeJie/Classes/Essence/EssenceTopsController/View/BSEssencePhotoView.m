//
//  BSEssencePhotoView.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/20.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssencePhotoView.h"
#import "BSEssenceAllModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FLAnimatedImageView.h"
#import "BSBrowerController.h"

@interface BSEssencePhotoView()

@property (weak, nonatomic) IBOutlet UIImageView *gifIcon;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeLargerPicBtn;

@end
@implementation BSEssencePhotoView

+ (instancetype)photoViewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}
- (void)setPhotoItems:(BSEssenceAllModel *)photoItems {
    _photoItems = photoItems;
    if (photoItems.is_gif==0) {
        [self.gifIcon removeFromSuperview];
    }
    NSURL *ImageURL = [NSURL URLWithString:photoItems.cdn_img];
    if (photoItems.is_gif == YES) {
        // gif直接给图就可以, 这个框架很牛瓣,感谢FL
        [self.imageView sd_setImageWithURL:ImageURL];
    }else {
        [self.imageView sd_setImageWithURL:ImageURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (photoItems.larger_pic) {
                //如果是大图就进行裁剪下,根据frame的矩形,没错,就是要高度而已~ 这里是主线程!
                CGFloat clipHeight = photoItems.contentViewFrame.size.height;
                UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width, clipHeight), NO, 0);
                UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, image.size.width, clipHeight)];
                [path addClip];
                [image drawAtPoint:CGPointZero];
                image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            self.imageView.image = image;
        }];
    }
}
- (IBAction)seeLargerPicTouch:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:_photoItems.cdn_img];
    [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
    //还没开发详情页,将就
}


@end
