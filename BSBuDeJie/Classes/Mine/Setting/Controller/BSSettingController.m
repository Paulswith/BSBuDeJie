//
//  BSSettingController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSSettingController.h"
#import "BSFileTools.h"

@interface BSSettingController ()

@property (assign, nonatomic) NSInteger totalSize;

@end


static NSString * const cellIdentifier = @"setting";
@implementation BSSettingController

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self calculateCachesSize];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if (_totalSize > (1000 * 1000)) {
        float newSize = _totalSize / (1000.0 * 1000.0);
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(%.1fMB)",newSize];
    }else if (_totalSize > 1000) {
        float newSize = _totalSize / 1000.0;
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(%.1fKB)",newSize];
    }else if (_totalSize > 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(%ldB)",_totalSize];
    }else {
        cell.textLabel.text = @"清除缓存(0.0B)";
    }
    return cell;
}
- (void)calculateCachesSize {
    //计算文件大小
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    [BSFileTools calculateDirectorySize:cachesDir complete:^(NSInteger totalSize) {
        _totalSize = totalSize;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}
#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //取消选中
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    [BSFileTools removeDirectory:cachesDir complete:^{
         _totalSize = 0 ;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
//    [[NSNotificationCenter defaultCenter] postNotificationName:BSSettingsCleanCacheNoti object:nil];
    
}


@end
