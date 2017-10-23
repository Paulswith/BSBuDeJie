//
//  BSEssenceAllModel.h
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/18.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, BSEssenceType)
{
     // 1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
    BSEssenceTypeDefault=1,
    BSEssenceTypePhoto=10,
    BSEssenceTypeJoke=29,
    BSEssenceTypeSound=31,
    BSEssenceTypeVideo=41,
    BSEssenceTypeAll=BSEssenceTypeDefault,
};

@interface BSEssenceAllModel : NSObject

@property(strong,nonatomic) NSString *profile_image; //头像地址
@property(strong,nonatomic) NSString *screen_name; //发帖人昵称
@property(strong,nonatomic) NSString *text; //title
@property(strong,nonatomic) NSString *passtime; //帖子通过的时间
@property(assign,nonatomic) NSInteger comment; //评论的数量
@property(assign,nonatomic) NSInteger repost; //转发的数量
@property(assign,nonatomic) NSInteger hate; //踩的数量
@property(assign,nonatomic) NSInteger love; //收藏量- 赞吧
@property(assign,nonatomic) NSInteger type; //类型
@property(assign,nonatomic) BOOL is_gif; //是否为gif图类型 ,否为Png
@property(assign,nonatomic) NSInteger height; //图片或视频等其他的内容的高度
@property(assign,nonatomic) NSInteger width; //图片或视频等其他的内容的宽度
@property(strong,nonatomic) NSString *cdn_img; // gif / png / 视频封面的图片Url
@property(strong,nonatomic) NSString *image1; // gif / png / 视频封面的图片Url
@property(strong,nonatomic) NSString *image2; // gif / png / 视频封面的图片Url


@property(strong,nonatomic) NSString *videouri; // 视频url
@property(strong,nonatomic) NSArray *top_cmt; // 最佳评论
@property(strong,nonatomic) NSString *voiceuri; //音频地址
@property(strong,nonatomic) NSString *voicetime; //音频时间
@property(strong,nonatomic) NSString *voicelength; //音频时长
@property(strong,nonatomic) NSArray *playfcount; //播放次数
@property(assign,nonatomic) BOOL vioceSelect; // 选中为选中状态

// 非后台下发数据,自缓存部分
@property(assign,nonatomic) CGFloat row_height; //自定义缓存高度
@property(assign,nonatomic) CGRect contentViewFrame; //
@property (assign, nonatomic) BOOL larger_pic; //是否为大图
@property (assign, nonatomic) BOOL hasBestCommont; //是否为大图
@property (strong, nonatomic) UITableView *bindTableView; //播放器需要绑定的
@property (strong, nonatomic) NSIndexPath *bindIndexPath; //播放器需要绑定的

//videouri

@end
