//
//  BSEssenceAllModel.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/18.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceAllModel.h"


#define Space 10
@implementation BSEssenceAllModel


- (float)text_height {

    if (_text_height) {
        BSLog(@"当前对象<%p>-已有高度为->[%f], 直接返回",self,_text_height);
        return _text_height;
    }  //有缓存就返回
    _text_height =  50; //相当于是y值, 40的topheight + label的间距10 = 50
    _text_height += 40; //底部bottomHeight 40 + 间距10
    _text_height += 10 + 10;  //这是早期cell划分减去的10高度 莫名其妙的还要再加10
    /*字体高度计算*/
    //提供一个固定宽度 + 无限高度的区域
    CGSize originalSize = CGSizeMake(screenW - 2*Space, MAXFLOAT);  //宽度 * 无限高
    NSDictionary *attribute = @{
                                NSFontAttributeName:[UIFont systemFontOfSize:17]
                                };
    // 根据字体属性和文本内容,计算. 需要注意文本大小和xib的一致
    _text_height += [_text boundingRectWithSize:originalSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.height;
    /*
    内容部分可在此加
    */
    BSLog(@"当前对象<%p>-计算高度为->[%f]",self,_text_height);
    return _text_height;
    
    
    
}


@end
