//
//  BSEssenceAllModel.h
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/18.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSEssenceAllModel : NSObject
@property(strong,nonatomic) NSString *profile_image; //头像地址
@property(strong,nonatomic) NSString *screen_name; //发帖人昵称
@property(strong,nonatomic) NSString *text; //title

@property(strong,nonatomic) NSString *passtime; //帖子通过的时间

@property(strong,nonatomic) NSString *comment; //评论的数量
@property(strong,nonatomic) NSString *repost; //转发的数量
@property(strong,nonatomic) NSString *hate; //踩的数量
@property(strong,nonatomic) NSString *love; //收藏量- 赞吧
//@property(strong,nonatomic) NSString *type; //类型
@end
