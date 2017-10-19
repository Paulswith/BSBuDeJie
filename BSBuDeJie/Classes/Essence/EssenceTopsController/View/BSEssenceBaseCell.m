//
//  BSEssenceBaseCell.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/19.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceBaseCell.h"
#import "BSEssenceAllModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface BSEssenceBaseCell()

@end
@implementation BSEssenceBaseCell
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        //
//    }
//    return self;
//}
/*
 @property(strong,nonatomic) NSString *profile_image; //头像地址
 @property(strong,nonatomic) NSString *screen_name; //发帖人昵称
 @property(strong,nonatomic) NSString *text; //title
 
 @property(strong,nonatomic) NSString *passtime; //帖子通过的时间
 
 @property(strong,nonatomic) NSString *comment; //评论的数量
 @property(strong,nonatomic) NSString *repost; //转发的数量
 @property(strong,nonatomic) NSString *hate; //踩的数量
 @property(strong,nonatomic) NSString *love; //收藏量- 赞吧
 */

- (void)setCellItems:(BSEssenceAllModel *)cellItems {
    _cellItems = cellItems;
    self.nameLabel.text = cellItems.screen_name;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:cellItems.profile_image] placeholderImage:[UIImage imageNotRenderingWithName:@"place"]];
    [self.zanBtn setTitle:cellItems.love forState:UIControlStateNormal];
    [self.caiBtn setTitle:cellItems.hate forState:UIControlStateNormal];
    [self.shareBtn setTitle:cellItems.repost forState:UIControlStateNormal];
    [self.commentBtn setTitle:cellItems.comment forState:UIControlStateNormal];
    
    [self.updateTimeLabel setText:cellItems.passtime];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    UIImage *cellBGImage = [UIImage imageNotRenderingWithName:@"mainCellBackground"];
    
    cellBGImage  = [cellBGImage stretchableImageWithLeftCapWidth:cellBGImage.width/2 topCapHeight:cellBGImage.height/2];
    self.backgroundView = [[UIImageView alloc] initWithImage:cellBGImage];
}

@end
