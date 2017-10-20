//
//  BSEssencePhotoView.h
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/20.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSEssencePhotoView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *gifIcon;
@property (weak, nonatomic) IBOutlet UIView *mainView;
+ (instancetype)photoViewFromXib;
@end
