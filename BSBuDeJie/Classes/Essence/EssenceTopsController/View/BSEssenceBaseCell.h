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
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;  // 头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;    // 发布者名字
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel; //更新时间
@property (weak, nonatomic) IBOutlet UIButton *moreDetailBtn; // 详情页按钮
@property (weak, nonatomic) IBOutlet UIButton *zanBtn; //赞
@property (weak, nonatomic) IBOutlet UIButton *caiBtn; //踩
@property (weak, nonatomic) IBOutlet UIButton *shareBtn; //分享
@property (weak, nonatomic) IBOutlet UIButton *commentBtn; //评论

@property (weak, nonatomic) IBOutlet UIView *contentPlaceHolderView; //内容占位View
//NS_DESIGNATED_INITIALIZER
// 让子类来实现具体的内容展示
@property (weak, nonatomic) IBOutlet UILabel *infoTextLabel;

//- (instancetype)initWithBaseCellFormXib;

@property(strong,nonatomic) BSEssenceAllModel *cellItems; //设置cell属性  子类来实现

@end
