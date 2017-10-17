//
//  BSPhotoTableView.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/14.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSPhotoTableView.h"
#import "BSRefreshView.h"


@interface BSPhotoTableView ()

@end

@implementation BSPhotoTableView


- (void)doubleReloadData {
//    [self.tableView reloadData];
    [self.tableView.mj_header beginRefreshing];
}
@end
