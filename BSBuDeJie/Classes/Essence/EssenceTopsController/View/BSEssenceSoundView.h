//
//  BSEssenceSoundView.h
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/20.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSEssenceAllModel;
@interface BSEssenceSoundView : UIView

@property(strong,nonatomic) BSEssenceAllModel *soundModel; 
+ (instancetype)soundViewFromXib;
@end
