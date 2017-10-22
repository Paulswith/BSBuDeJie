//
//  BSEssenceSoundView.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/20.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceSoundView.h"

@interface BSEssenceSoundView()
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (weak, nonatomic) IBOutlet UIImageView *playStatuImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimerLabel;




@end

@implementation BSEssenceSoundView


+ (instancetype)soundViewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}


@end
