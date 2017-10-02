//
//  BSFollowItem.h
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/2.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSFollowItem : NSObject
@property (strong, nonatomic) NSString *image_list; // 头像
@property (assign, nonatomic) NSInteger sub_number;  //订阅数
@property (strong, nonatomic) NSString *theme_name;  //官方名

@end
