//
//  BSEssenceAllModel.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/18.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceAllModel.h"



@implementation BSEssenceAllModel


- (CGFloat)text_height {

    if (_text_height) {
        BSLog(@"当前对象<%p>-已有高度为->[%f], 直接返回",self,_text_height);
        return _text_height;
    }  //有缓存就返回
    _text_height =  50; //相当于是y值, 40的topheight + label的间距10 = 50
    _text_height += 40; //底部bottomHeight 40 + 间距10
    _text_height += allCellSpace * 2;  //这是早期cell划分减去的10高度 莫名其妙的还要再加10
    /*字体高度计算*/
    NSUInteger originalHeight = _text_height;
    CGFloat infoLabelHeight = [NSString calculatorStringHeight:_text WithSystemFontSize:17];
    _text_height += infoLabelHeight;
//    _text_height += [NSString calculatorStringHeight:_text WithSystemFontSize:17];
    /*计算最佳评论部分的高度*/
    NSUInteger bestHeight = 0;
    if (_top_cmt.count > 0) {//说明有最佳评论,要展示和计算,仅soundView
        bestHeight= bestCommontViewHeight;
    }
    _text_height += bestHeight;
    /*计算占位view高度,仅joke不需要处理*/
    CGFloat frameHeight = 0;
    if (_type.integerValue != BSEssenceTypeJoke) {
        CGFloat width = screenW - 2*allCellSpace;
//        NSInteger filtrationWidth = _height.integerValue < 1000 ? _height.integerValue : 1000.0;   //过滤下巨图
//        CGFloat height = (filtrationWidth / _width.integerValue) * width;
        NSLog(@"%ld,%ld",_height.integerValue,_width.integerValue);
//        CGFloat height = (_height.integerValue / _width.integerValue) * width;  //  h/w  = Sh/Sw;  与屏幕等比scale
//       CGFloat height = (_height.integerValue / width) * _width.integerValue;
        CGFloat height = (_height.integerValue * width) / _width.integerValue;
        CGFloat x = allCellSpace;
        CGFloat y = infoLabelHeight + 10 + 10; //textLabel上方间距10 + 与下方间距10
        _contentViewFrame = CGRectMake(x, y, width, height);
        frameHeight = height; //叠加间距
    }
    _text_height += frameHeight;
    NSLog(@"当前类型为[%@],原始高度为[%zd], 计算后文字得[%f], 计算最佳评论View得[%zd], 计算内容View得[%f], 最终得到->[%f]",_type,originalHeight,infoLabelHeight,bestHeight,frameHeight,_text_height);
    return _text_height;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"height=%@->tyle=%@->is_git=%@->ImageURL=%@",_height,_type,_is_gif,_cdn_img];
}

@end
