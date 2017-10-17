//
//  BSLoadMoreView.h
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/17.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>


@interface BSLoadMoreView : MJRefreshAutoGifFooter

/*
 //1
 self.tableView.mj_footer = [BSLoadMoreView footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
 //2 在数据拉取结束处,
 loadMoreData ->[tableView.mj_footer endRefreshing];
 
 */
@end
