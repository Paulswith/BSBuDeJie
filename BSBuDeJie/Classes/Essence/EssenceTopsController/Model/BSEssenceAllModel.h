//
//  BSEssenceAllModel.h
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/18.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, BSEssenceType)
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
@property(strong,nonatomic) NSString *comment; //评论的数量
@property(strong,nonatomic) NSString *repost; //转发的数量
@property(strong,nonatomic) NSString *hate; //踩的数量
@property(strong,nonatomic) NSString *love; //收藏量- 赞吧
@property(strong,nonatomic) NSString *type; //类型
@property(strong,nonatomic) NSString *is_gif; //是否为gif图类型 ,否为Png
@property(strong,nonatomic) NSString *height; //图片或视频等其他的内容的高度
@property(strong,nonatomic) NSString *width; //图片或视频等其他的内容的宽度
@property(strong,nonatomic) NSString *cdn_img; // gif / png / 视频封面的图片Url
@property(strong,nonatomic) NSArray *top_cmt; // 最佳评论

//@property(strong,nonatomic) NSString *cdn_img; // gif / png / 视频封面的图片Url







@property(assign,nonatomic) CGFloat text_height; //自定义缓存高度
@property(assign,nonatomic) CGRect contentViewFrame; //
//@property(strong,nonatomic) NSMutableArray<__kindof BSEssenceAllModel *> *text_heightArray; //存储cell的高度的数组
@end
