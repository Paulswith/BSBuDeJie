//
//  BSFrequency.h
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/15.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSFrequency : NSObject

// ----------------通知key部分-----------------------------------
UIKIT_EXTERN NSString * const BSTabBarRepeastDidTap; // 点击tabbar的通知
UIKIT_EXTERN NSString * const BSTabBarNotiKey; // tabbar通知的info-key
UIKIT_EXTERN NSString * const BSSettingsCleanCacheNoti; // 清除缓存的通知
// ----------------通知key部分-end----------------------------------

UIKIT_EXTERN CGFloat const BSEssenseHeaderViewHeight;
UIKIT_EXTERN NSString * const BSEssenceMaxTime; //二次加载的缓存key
UIKIT_EXTERN NSString * const BSMainRUL;   // 后台接口的主域名
UIKIT_EXTERN NSUInteger const bestCommontViewHeight; // Essence最佳评论View的高度
UIKIT_EXTERN NSUInteger const allCellSpace; //essence设计的通用间距
//UIKIT_EXTERN CGFloat const defaultCellWidth; //cell的默认宽度

@end
