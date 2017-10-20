//
//  BSEssenceBaseCell.h
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/19.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSEssenceAllModel;


@interface BSEssenceBaseCell : UITableViewCell

@property(strong,nonatomic) BSEssenceAllModel *cellItems; //设置cell属性  子类来实现

@end
