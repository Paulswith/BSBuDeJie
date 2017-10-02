//
//  BSSaveToolsBox.h
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSSaveToolsBox : NSObject

+ (void)setObject:(id)value forKey:(NSString *)key autoSynchronize:(BOOL)synchronize;
+ (id)objectForKey:(NSString *)key;
@end
