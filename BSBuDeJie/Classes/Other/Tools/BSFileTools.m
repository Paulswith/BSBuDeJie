//
//  BSFileTools.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/11.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSFileTools.h"


@interface BSFileTools()
@end
@implementation BSFileTools
+ (void)calculateDirectorySize:(NSString *)directory complete:(void (^)(NSInteger))complete {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 不存在的目录抛出异常
    if (![fileManager fileExistsAtPath:directory]) {
        NSException *exception = [[NSException alloc] initWithName:@"RemoveDirectoryError" reason:@"Directory not exist" userInfo:nil];
        [exception raise];
        return;
    }
    // 拿到全部子目录,过滤文件夹后计算大小
    NSArray *allSubPaths = [fileManager subpathsAtPath:directory];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSInteger totalSize = 0;
        for (NSString *subPath in allSubPaths) {
            NSString *fullSubPath = [directory stringByAppendingPathComponent:subPath];
            BOOL isDir;
            [fileManager fileExistsAtPath:fullSubPath isDirectory:&isDir];
            if (isDir) {
                continue;
            }
            NSDictionary *dict = [fileManager attributesOfItemAtPath:fullSubPath error:nil];
            NSString *str = dict[@"NSFileSize"];
            totalSize += str.intValue;
        }
        if (complete) {
            dispatch_async(dispatch_get_main_queue(), ^{
            complete(totalSize);
            });
        }
    });
}
+ (void)removeDirectory:(NSString *)directory complete:(void (^)())complete {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:directory]) {
        NSException *exception = [[NSException alloc] initWithName:@"RemoveDirectoryError" reason:@"Directory not exist" userInfo:nil];
        [exception raise];
        return;
    }
    NSError *isGetDirectoryError;
    //获取一级目录
    NSArray *allDirectory = [fileManager contentsOfDirectoryAtPath:directory error:&isGetDirectoryError];
    if (isGetDirectoryError) {
        BSLog(@"isGetDirectoryError : %@",isGetDirectoryError);
    }
    for (NSString *subPath in allDirectory) {
        NSString *shouldRemoveSubPath = [directory stringByAppendingPathComponent:subPath];
        NSError *isRemoveDirectoryError;
        [fileManager removeItemAtPath:shouldRemoveSubPath error:&isRemoveDirectoryError];
        if (isRemoveDirectoryError) {
            BSLog(@"isRemoveDirectoryError : %@",isRemoveDirectoryError);
        }
        if (complete) {
            complete();
        }
    }
}


@end
