//
//  NSString+BSString_height.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/20.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "NSString+BSString_height.h"

@implementation NSString (BSString_height)

+ (CGFloat)calculatorStringHeight:(NSString *)stringText WithSystemFontSize:(NSInteger)fontSize {
    /*字体高度计算*/
    //提供一个固定宽度 + 无限高度的区域
    CGSize originalSize = CGSizeMake(screenW - 2*allCellSpace, MAXFLOAT);  //宽度 * 无限高
    NSDictionary *attribute = @{
                                NSFontAttributeName:[UIFont systemFontOfSize:fontSize]
                                };
    // 根据字体属性和文本内容,计算. 需要注意文本大小和xib的一致
    CGFloat height = [stringText boundingRectWithSize:originalSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.height;
    return height;
}

//+ (CGFloat)calculatorStringHeight:(NSString *)stringText WithSystemFontSize:(NSInteger)fontSize {
//    return [self calculatorStringHeight:stringText WithSystemFontSize:fontSize];
//}
@end
