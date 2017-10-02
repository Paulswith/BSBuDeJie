//
//  BSTableViewCell.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/2.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSTableViewCell.h"
#import "UIImage+Catogory.h"
#import <UIImageView+WebCache.h>
#import "UIView+Frame.h"
#import "BSFollowItem.h"

@interface BSTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *subFollow;
@property (weak, nonatomic) IBOutlet UIButton *addFollow;


@end

@implementation BSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubViews];
    [self resoveRound];
 
}
#pragma mark - 分割线的处理方式2,重写setFrame方法
- (void)setFrame:(CGRect)frame {
    // 另边距均为减5,露出肚腩让人们以为那是分割线~
    frame.size.height -= 5;
    [super setFrame:frame];
}

- (void)resoveRound {
    //圆角处理,方法1
//    _headImageView.layer.cornerRadius = _headImageView.width / 2 ;
//    _headImageView.layer.masksToBounds = YES;
}
#pragma mark - 按钮状态新增背景
- (void)setupSubViews {
    [_addFollow setBackgroundImage:[UIImage imageNotRenderingWithName:@"FollowBtnBg"] forState:UIControlStateNormal];
    [_addFollow setBackgroundImage:[UIImage imageNotRenderingWithName:@"FollowBtnClickBg"] forState:UIControlStateHighlighted];
}

#pragma mark - cellSetterInfo
- (void)setSetCellItem:(BSFollowItem *)setCellItem {
    _setCellItem = setCellItem;
    _name.text = setCellItem.theme_name;
    _subFollow.text = [self followString:setCellItem.sub_number];
    NSURL *imageUrl = [NSURL URLWithString:setCellItem.image_list];
    UIImage *defaultImage = [UIImage imageNotRenderingWithName:@"defaultUserIcon"];
//    [_headImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNotRenderingWithName:@"defaultUserIcon"]];
    [_headImageView sd_setImageWithURL:imageUrl placeholderImage:defaultImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //圆角处理方法2 裁剪
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.width, image.height)];
        [path addClip];
        [image drawAtPoint:CGPointZero];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _headImageView.image =image;
    }];
}

#pragma mark - 万以上修改字符串
- (NSString *)followString:(NSInteger)number {
    if (number > 10000) {
        return [NSString stringWithFormat:@"%.1f万人已订阅",number/10000.0];
    }
    return [NSString stringWithFormat:@"%ld人已订阅",number];
}

@end
