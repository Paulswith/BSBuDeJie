//
//  BSDownloadKey.h
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/18.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BsdownloadKeyword : NSObject

UIKIT_EXTERN NSString * const Essence_all_new;
UIKIT_EXTERN NSString * const Essence_all_more;
UIKIT_EXTERN NSString * const Essence_video_new;
UIKIT_EXTERN NSString * const Essence_video_more;
UIKIT_EXTERN NSString * const Essence_photo_new;
UIKIT_EXTERN NSString * const Essence_photo_more;
UIKIT_EXTERN NSString * const Essence_sound_new;
UIKIT_EXTERN NSString * const Essence_sound_more;
UIKIT_EXTERN NSString * const Essence_joke_new;
UIKIT_EXTERN NSString * const Essence_joke_more;

@end

@interface BSDownload : NSObject

+ (NSDictionary *)downloadParametersWithkey:(NSString *)key;

@end
