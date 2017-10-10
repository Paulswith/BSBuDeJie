//
//  BSFileTools.h
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/11.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSFileTools : NSObject
+ (void)calculateDirectorySize:(NSString *)Directory complete:(void(^)(NSInteger totalSize))complete;

+ (void)removeDirectory:(NSString *)directory complete:(void(^)())complete;
@end
