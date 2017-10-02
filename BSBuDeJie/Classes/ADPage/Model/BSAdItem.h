//
//  BSAdItem.h
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/2.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BSAdItem : NSObject

@property (strong, nonatomic) NSString *w_picurl; //图片地址
@property (strong, nonatomic) NSString *ori_curl; //广告跳转链接
@property (assign, nonatomic) NSInteger h;
@property (assign, nonatomic) NSInteger w;

@end
