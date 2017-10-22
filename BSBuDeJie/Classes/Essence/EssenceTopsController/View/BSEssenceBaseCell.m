//
//  BSEssenceBaseCell.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/19.
//  Copyright © 2017年 Dobby. All rights reserved.
//

/*
 makr一个超级大坑, 大战一天一直出现cell的位置问题, 最终原因:
 直接加载contentView就可以了, 不要再加占位图
 */

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
@property (weak, nonatomic) IBOutlet UILabel *infoTextLabel; //上方介绍的文本或者是段子的全文
@property (weak, nonatomic) IBOutlet UIView *bestCommentView;  //最佳评论view
@property (weak, nonatomic) IBOutlet UILabel *bestCommentUserLabel; //最佳评论的用户名
@property (weak, nonatomic) IBOutlet UILabel *bestCommontContentLabel; //最佳评论的文本 单行

//内容的view , 直接调
//@property(weak,nonatomic) BSEssenceSoundView *contentSoundView;
//@property(weak,nonatomic) BSEssencePhotoView *contentPhotoView;
//@property(weak,nonatomic) BSEssenceVideoView *contentVideoView;

@end

@implementation BSEssenceBaseCell

// 1为全部，10为图片，29为段子，31为音频，41为视频，默认为1

- (void)setCellItems:(BSEssenceAllModel *)cellItems {
    _cellItems = cellItems;
    self.nameLabel.text = cellItems.screen_name;
    self.infoTextLabel.text = cellItems.text;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:cellItems.profile_image] placeholderImage:[UIImage imageNotRenderingWithName:@"defaultUserIcon"]];
    [self.zanBtn setTitle:[NSString stringWithFormat:@"%ld",cellItems.love] forState:UIControlStateNormal];
    [self.caiBtn setTitle:[NSString stringWithFormat:@"%ld",cellItems.hate] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",cellItems.repost] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",cellItems.comment] forState:UIControlStateNormal];
    [self.updateTimeLabel setText:cellItems.passtime];

    if (cellItems.top_cmt.count > 0) {
        NSString *content = cellItems.top_cmt[0][@"content"];
        NSString *userName = cellItems.top_cmt[0][@"user"][@"username"];
        self.bestCommentUserLabel.text = userName;
        self.bestCommontContentLabel.text = content;
    }else {
        [self.bestCommentView removeFromSuperview];
    }
    
    //  判断是哪种类型的加载一下类型
    if (cellItems.type == BSEssenceTypePhoto) {
        self.contentPhotoView.photoItems = cellItems;
        [self.contentSoundView removeFromSuperview];
        [self.contentVideoView removeFromSuperview];
    }else if (cellItems.type == BSEssenceTypeVideo) {
        self.contentVideoView.videoModel = cellItems;
        [self.contentSoundView removeFromSuperview];
        [self.contentPhotoView removeFromSuperview];
    }else if (cellItems.type == BSEssenceTypeSound) {
        [self.contentVideoView removeFromSuperview];
        [self.contentPhotoView removeFromSuperview];
        // 如果在这里添加View上去, 会有乱七八糟的坑~ 有些都没有移除掉
    }else {
        [self.contentVideoView removeFromSuperview];
        [self.contentPhotoView removeFromSuperview];
        [self.contentSoundView removeFromSuperview];
    }
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //在这里对内容view调整大小
    if (_cellItems.type == BSEssenceTypePhoto) {
        self.contentPhotoView.frame = _cellItems.contentViewFrame;
    }else if (_cellItems.type == BSEssenceTypeVideo) {
        self.contentVideoView.frame = _cellItems.contentViewFrame;
    }else if (_cellItems.type == BSEssenceTypeSound) {
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
        [self.contentView addSubview:_contentPhotoView];
    }
    return _contentPhotoView;
}
- (BSEssenceSoundView *)contentSoundView {
    if (!_contentSoundView) {
        _contentSoundView = [BSEssenceSoundView soundViewFromXib];
        [self.contentView addSubview:_contentSoundView];
    }
    return _contentSoundView;
}
- (BSEssenceVideoView *)contentVideoView {
    if (!_contentVideoView) {
        _contentVideoView = [BSEssenceVideoView videoViewFromXib];
        [self.contentView addSubview:_contentVideoView];
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
