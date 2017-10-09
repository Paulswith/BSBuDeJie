//
//  BSSystemInfoTool.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/9.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSSystemInfoTool.h"

@implementation BSSystemInfoTool
+ (double)getSystemVersion {
    NSString *version = [UIDevice currentDevice].systemVersion;
    return version.doubleValue;
}
@end
