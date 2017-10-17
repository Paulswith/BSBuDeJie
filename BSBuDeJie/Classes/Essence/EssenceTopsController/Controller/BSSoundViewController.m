//
//  BSSoundViewController.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/15.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSSoundViewController.h"
#import "BSRefreshView.h"


@interface BSSoundViewController ()

@end

@implementation BSSoundViewController

- (void)doubleReloadData {
//    [self.tableView reloadData];
    [self.tableView.mj_header beginRefreshing];
}
@end
