//
//  BSDownloadKey.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/18.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSDownload.h"
#import "BSEssenceAllModel.h"

@implementation BsdownloadKeyword

NSString * const Essence_all_new = @"all_essence_new";
NSString * const Essence_all_more = @"all_essence_more";
NSString * const Essence_video_new = @"video_essence_new";
NSString * const Essence_video_more = @"video_essence_more";
NSString * const Essence_photo_new = @"photo_essence_new";
NSString * const Essence_photo_more = @"photo_essence_more";
NSString * const Essence_sound_new = @"sound_essence_new";
NSString * const Essence_sound_more = @"sound_essence_more";
NSString * const Essence_joke_new = @"joke_essence_new";
NSString * const Essence_joke_more = @"joke_essence_more";

@end

@implementation BSDownload

- (void)exit:(int (^)(int, int))task {
    
}

+ (NSDictionary *)downloadParametersWithkey:(NSString *)key {
    //区分
    BOOL isGetRefresh = [key hasSuffix:@"new"]; //区分是否加载更多
    NSNumber *type = [self typeWithString:key]; //
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                                        @"a":@"list",
                                                                                        @"c":@"data",
                                                                                        @"type":type
                                                                                            }];
    // 仅是加载更多的时候才需要该参数
    if (!isGetRefresh) {
        NSString *maxTime = [BSSaveToolsBox objectForKey:BSEssenceMaxTime];
        if (maxTime) {
            parameters[@"maxtime"] = maxTime;
        }
    }
    BSLog(@"downloadParameters : %@",parameters);
    return parameters;
}
                                                                 
+ (NSNumber *)typeWithString:(NSString *)key {
    // 1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
    if ([key hasPrefix:@"all"]) {
        return @(BSEssenceTypeAll);
    }else if ([key hasPrefix:@"photo"]) {
        return @(BSEssenceTypePhoto);
    }else if ([key hasPrefix:@"joke"]) {
        return @(BSEssenceTypeJoke);
    }else if ([key hasPrefix:@"sound"]) {
        return @(BSEssenceTypeSound);
    }else if ([key hasPrefix:@"video"]) {
        return @(BSEssenceTypeVideo);
    }else {
        return @(BSEssenceTypeDefault);
    }
}
@end
