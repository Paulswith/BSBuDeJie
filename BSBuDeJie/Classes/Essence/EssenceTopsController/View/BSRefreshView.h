//
//  BSRefreshView.h
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/17.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface BSRefreshView : MJRefreshGifHeader
/*
 //1 设置展示
 self.tableView.mj_header = [BSRefreshView headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
 //2 且同事启动进入刷新状态
 [self.tableView.mj_header beginRefreshing];
 //3
 loadNewData中, 在结束后调用
 [tableView.mj_header endRefreshing];
 */
@end
