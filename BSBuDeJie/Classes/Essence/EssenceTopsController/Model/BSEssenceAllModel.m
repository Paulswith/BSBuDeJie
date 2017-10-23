//
//  BSEssenceAllModel.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/18.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceAllModel.h"



@implementation BSEssenceAllModel


- (CGFloat)row_height {

    if (_row_height) {
//        BSLog(@"当前对象<%p>-已有高度为->[%f], 直接返回",self,_row_height);
        return _row_height;
    }  //有缓存就返回
    _row_height =  40; //y
    _row_height += allCellSpace;  //topView 和 infoLabel 的 10间距
    /*字体高度计算*/
    _row_height += [NSString calculatorStringHeight:_text WithSystemFontSize:17];

    
    
    /*计算占位view高度,仅joke不需要处理*/
    CGFloat frameHeight = 0;
    if (_type != BSEssenceTypeJoke) {
        CGFloat x = allCellSpace;
        CGFloat y = _row_height + 10; //目前为止计算的高度为y, 和infoLbel的间距补10
        CGFloat defaultWidth = screenW - 2 * allCellSpace;
        CGFloat frame_width = defaultWidth;
        CGFloat frame_height = (frame_width/_width) * _height;
        if (_height > (screenH * 3/4)) {
            // 图片类型, 且长图(height大于屏幕宽度3/4的), 裁剪为固定高度300
            frame_height = 300;
            
            //对高>宽视频处理,  公式为: 当前高/下发高, 得到缩小比例 .      该比例 * 下发宽 , 得到需要展示的宽度, 但是部分需要过滤
            frame_width = (frame_height/_height) * _width;
            // 宽超默认宽的长视频, 指定默认宽
            if (frame_width > defaultWidth) {
                frame_width = defaultWidth;
            }
            // 图片类型的长图 , 默认宽
            if (_type == BSEssenceTypePhoto) {
                frame_width = defaultWidth;
            }
//            BSLog(@"找到一个长图,调整为:(%f,%f)",frame_width,frame_height);
            _larger_pic = YES;
        }
        _contentViewFrame = CGRectMake(x, y, frame_width, frame_height);
        frameHeight = _contentViewFrame.size.height ;
    }
    /*计算最佳评论部分的高度*/
    if (_top_cmt.count > 0) {//说明有最佳评论,要展示和计算,仅soundView
        BSLog(@"有最佳评论");
        _row_height += bestCommontViewHeight;
        _hasBestCommont = YES;
    }
    _row_height += frameHeight + 10 + 10; //加上计算后的高度和间距  补10到bottomView间距
//    NSLog(@"当前类型为[%ld],(w=%ld,h=%ld)计算内容View得[%f], 最终得到->[%f]",_type,_width,_height,frameHeight,_row_height);
    _row_height += (30 + 10); //底部bottomHeight:30 +cell之间的10 + 不知道哪来的10~~
    return _row_height;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"tyle=%ld,frame=%@->cnd_image=%@,video_url=%@",_type,NSStringFromCGRect(_contentViewFrame),_cdn_img,_videouri];
}

@end
