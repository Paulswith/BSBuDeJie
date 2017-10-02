//
//  BSSaveToolsBox.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSSaveToolsBox.h"

@implementation BSSaveToolsBox

+ (void)setObject:(id)value forKey:(NSString *)key autoSynchronize:(BOOL)synchronize {
    if (key == nil) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    if (synchronize) {
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (id)objectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
