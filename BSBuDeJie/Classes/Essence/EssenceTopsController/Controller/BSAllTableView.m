//
//  BSAllTableView.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/14.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSAllTableView.h"
#import "BSRefreshView.h"

static NSString * const ID = @"BSAllTableView";
@interface BSAllTableView ()

@end

@implementation BSAllTableView
- (void)doubleReloadData {
//    [self.tableView reloadData];
    [self.tableView.mj_header beginRefreshing];  //里面调用了setneedDisplay
}
@end
