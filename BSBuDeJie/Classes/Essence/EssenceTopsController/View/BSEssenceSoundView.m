//
//  BSEssenceSoundView.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/20.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceSoundView.h"
#import "BSEssenceAllModel.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface BSEssenceSoundView()
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (weak, nonatomic) IBOutlet UIButton *playStatuBtn;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimerLabel;




@end

@implementation BSEssenceSoundView


+ (instancetype)soundViewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}
-(void)setSoundModel:(BSEssenceAllModel *)soundModel {
    _soundModel = soundModel;
    /*
     @property(strong,nonatomic) NSString *voiceuri; //音频地址
     @property(strong,nonatomic) NSString *voicetime; //音频时间
     @property(strong,nonatomic) NSString *voicelength; //音频时长
     @property(strong,nonatomic) NSArray *playcount; //播放次数
     
     */
    [self.bottomImageView sd_setImageWithURL:[NSURL URLWithString:soundModel.image1]];
//    [self.bottomImageView sd_setImageWithURL:[NSURL URLWithString:soundModel.cdn_img] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        BSLog(@"image:%@, imageFrame:%@",image,NSStringFromCGSize(image.size));
//        self.bottomImageView.image = image;
//    }];
    
    BSLog(@"%@, %@, %@, %@,",soundModel.voiceuri,soundModel.voicetime, soundModel.voicelength,soundModel.playfcount);
    
    
    
}

@end
