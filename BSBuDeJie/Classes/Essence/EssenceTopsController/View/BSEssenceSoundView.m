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
#import <AVFoundation/AVFoundation.h>


@interface BSEssenceSoundView()
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (weak, nonatomic) IBOutlet UIButton *playStatuBtn;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimerLabel;
//@property(strong,nonatomic) AVPlayer *player; //声频播放器
//@property(strong,nonatomic) AVPlayerItem *playVoiceItem;

@end

@implementation BSEssenceSoundView


+ (instancetype)soundViewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}
//- (IBAction)playTap:(UIButton *)sender {
//    
//    BSLog(@"save:%@ -- current:%@",self.playVoiceItem,self.player.currentItem);
//    if (self.playVoiceItem == nil) {
//        [self.player pause];
//        //不同的btn,不同的item值, 点击不同的时候都是Nil.~  绝望
//    }
//    if (self.playStatuBtn.selected) {
//        [self.player pause];
//    }else {
//        AVPlayerItem *playVoiceItem =  [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_soundModel.voiceuri]];
//        self.playVoiceItem = playVoiceItem;
//        [self.player replaceCurrentItemWithPlayerItem:playVoiceItem];
//        BSLog(@"playVoiceItem : %@, playItem%@)",playVoiceItem,self.player.currentItem);
//        [self.player play];
//    }
//    _soundModel.vioceSelect = !sender.selected;
//    self.playStatuBtn.selected = !sender.selected;
//}
-(void)setSoundModel:(BSEssenceAllModel *)soundModel {
    _soundModel = soundModel;
//    self.playStatuBtn addTarget:<#(nullable id)#> action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>
    /*
     @property(strong,nonatomic) NSString *voiceuri; //音频地址
     @property(strong,nonatomic) NSString *voicetime; //音频时间
     @property(strong,nonatomic) NSString *voicelength; //音频时长
     @property(strong,nonatomic) NSArray *playcount; //播放次数
     
     */
    [self.bottomImageView sd_setImageWithURL:[NSURL URLWithString:soundModel.image1]];
    BSLog(@"%@, %@, %@, %@,",soundModel.voiceuri,soundModel.voicetime, soundModel.voicelength,soundModel.playfcount);
    self.playStatuBtn.selected = soundModel.vioceSelect;
    
    
}
//- (AVPlayer *)player {
//    if (!_player) {
//        AVAudioPlayer
//        _player = [[AVPlayer alloc] init];
//    }
//    return _player;
//}
//- (AVPlayer *)player {
//    if (!_player) {
//        _player = [AVPlayer new];
//    }
//    return _player;
//}
@end
