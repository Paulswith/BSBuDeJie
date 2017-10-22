//
//  BSEssenceBaseCell.h
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/19.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSEssenceSoundView;
@class BSEssencePhotoView;
@class BSEssenceVideoView;
@class BSEssenceAllModel;

@interface BSEssenceBaseCell : UITableViewCell

@property(strong,nonatomic) BSEssenceAllModel *cellItems; //设置cell属性  子类来实现

@property(weak,nonatomic) BSEssenceSoundView *contentSoundView;
@property(weak,nonatomic) BSEssencePhotoView *contentPhotoView;
@property(weak,nonatomic) BSEssenceVideoView *contentVideoView;
@end
