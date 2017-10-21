//
//  BSEssenceAllModel.h
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/18.
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
@property(assign,nonatomic) NSInteger is_gif; //是否为gif图类型 ,否为Png
@property(assign,nonatomic) NSInteger height; //图片或视频等其他的内容的高度
@property(assign,nonatomic) NSInteger width; //图片或视频等其他的内容的宽度
@property(strong,nonatomic) NSString *cdn_img; // gif / png / 视频封面的图片Url
@property(strong,nonatomic) NSString *image0; // gif / png / 视频封面的图片Url
@property(strong,nonatomic) NSArray *top_cmt; // 最佳评论

// 非后台下发数据,自缓存部分
@property(assign,nonatomic) CGFloat row_height; //自定义缓存高度
@property(assign,nonatomic) CGRect contentViewFrame; //
@property (assign, nonatomic) BOOL larger_pic; //是否为大图

@end
