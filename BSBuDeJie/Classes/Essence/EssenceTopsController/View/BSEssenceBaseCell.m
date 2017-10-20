//
//  BSEssenceBaseCell.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/19.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceBaseCell.h"
#import "BSEssenceAllModel.h"
#import "BSEssenceSoundView.h"
#import "BSEssencePhotoView.h"
#import "BSEssenceVideoView.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface BSEssenceBaseCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;  // 头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;    // 发布者名字
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel; //更新时间
@property (weak, nonatomic) IBOutlet UIButton *moreDetailBtn; // 详情页按钮
@property (weak, nonatomic) IBOutlet UIButton *zanBtn; //赞
@property (weak, nonatomic) IBOutlet UIButton *caiBtn; //踩
@property (weak, nonatomic) IBOutlet UIButton *shareBtn; //分享
@property (weak, nonatomic) IBOutlet UIButton *commentBtn; //评论
// 让子类来实现具体的内容展示
@property (weak, nonatomic) IBOutlet UIView *contentPlaceHolderView; //内容占位View
@property (weak, nonatomic) IBOutlet UILabel *infoTextLabel; //上方介绍的文本或者是段子的全文
@property (weak, nonatomic) IBOutlet UIView *bestCommentView;  //最佳评论view
@property (weak, nonatomic) IBOutlet UILabel *bestCommentUserLabel; //最佳评论的用户名
@property (weak, nonatomic) IBOutlet UILabel *bestCommontContentLabel; //最佳评论的文本 单行


//内容的view
@property(strong,nonatomic) BSEssenceSoundView *contentSoundView;
@property(strong,nonatomic) BSEssencePhotoView *contentPhotoView;
@property(strong,nonatomic) BSEssenceVideoView *contentVideoView;

@end

@implementation BSEssenceBaseCell

- (void)setCellItems:(BSEssenceAllModel *)cellItems {
    _cellItems = cellItems;
    self.nameLabel.text = cellItems.screen_name;
    self.infoTextLabel.text = cellItems.text;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:cellItems.profile_image] placeholderImage:[UIImage imageNotRenderingWithName:@"defaultUserIcon"]];
    [self.zanBtn setTitle:cellItems.love forState:UIControlStateNormal];
    [self.caiBtn setTitle:cellItems.hate forState:UIControlStateNormal];
    [self.shareBtn setTitle:cellItems.repost forState:UIControlStateNormal];
    [self.commentBtn setTitle:cellItems.comment forState:UIControlStateNormal];
    [self.updateTimeLabel setText:cellItems.passtime];

    if (cellItems.top_cmt.count > 0) {
        NSString *content = cellItems.top_cmt[0][@"content"];
        NSString *userName = cellItems.top_cmt[0][@"user"][@"username"];
        self.bestCommentUserLabel.text = userName;
        self.bestCommontContentLabel.text = content;
    }
    self.bestCommentView.hidden = YES;
    //  判断是哪种类型的加载一下类型
    if (cellItems.type.integerValue == BSEssenceTypePhoto) {
        [self.contentSoundView removeFromSuperview];
        [self.contentVideoView removeFromSuperview];
//        [self.bestCommentView removeFromSuperview];
    }else if (cellItems.type.integerValue == BSEssenceTypeVideo) {
//        [self.bestCommentView removeFromSuperview];
        [self.contentSoundView removeFromSuperview];
        [self.contentPhotoView removeFromSuperview];
    }else if (cellItems.type.integerValue == BSEssenceTypeSound) {
        [self.contentVideoView removeFromSuperview];
        [self.contentPhotoView removeFromSuperview];
        //仅这里需要展示最佳评论
//        [self.bestCommentView removeFromSuperview];
        self.bestCommentView.hidden = NO;
        
    }else {
        [self.contentVideoView removeFromSuperview];
        [self.contentPhotoView removeFromSuperview];
        [self.contentSoundView removeFromSuperview];
//        [self.bestCommentView removeFromSuperview];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //在这里对内容view调整大小
    if (_cellItems.type.integerValue == BSEssenceTypePhoto) {
        self.contentPhotoView.frame = _cellItems.contentViewFrame;
    }else if (_cellItems.type.integerValue == BSEssenceTypeVideo) {
        self.contentVideoView.frame = _cellItems.contentViewFrame;
    }else if (_cellItems.type.integerValue == BSEssenceTypeSound) {
        //仅这里需要展示最佳评论
        self.contentSoundView.frame = _cellItems.contentViewFrame;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // 背景图片拉伸布局
    UIImage *cellBGImage = [UIImage imageNotRenderingWithName:@"mainCellBackground"];
    cellBGImage  = [cellBGImage stretchableImageWithLeftCapWidth:cellBGImage.width/2 topCapHeight:cellBGImage.height/2];
    self.backgroundView = [[UIImageView alloc] initWithImage:cellBGImage];
}

#pragma mark - 懒加载三个内容View
- (BSEssencePhotoView *)contentPhotoView {
    if (!_contentPhotoView) {
        _contentPhotoView = [BSEssencePhotoView photoViewFromXib];
        [self.contentPlaceHolderView addSubview:_contentPhotoView];
    }
    return _contentPhotoView;
}

- (BSEssenceSoundView *)contentSoundView {
    if (!_contentSoundView) {
        _contentSoundView = [BSEssenceSoundView soundViewFromXib];
        [self.contentPlaceHolderView addSubview:_contentSoundView];
    }
    return _contentSoundView;
}

- (BSEssenceVideoView *)contentVideoView {
    if (!_contentVideoView) {
        _contentVideoView = [BSEssenceVideoView videoViewFromXib];
        [self.contentPlaceHolderView addSubview:_contentVideoView];
    }
    return _contentVideoView;
}

#pragma mark - cell之间间距10
- (void)setFrame:(CGRect)frame {
    // cell之间的高度减去10
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
