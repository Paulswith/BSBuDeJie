//
//  BSEssenceBisicTableViewController.h
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/15.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSEssenceBisicTableViewController : UITableViewController
//双击刷新 交给子类来实现 
- (void)doubleReloadData;
/*下拉加载*/
- (void)loadNewData NS_REQUIRES_SUPER;
/*上啦加载*/
- (void)loadMoreData NS_REQUIRES_SUPER;
/*
 - (void)loadNewData {
 self.data +=2;
 [super loadNewData];
 }
 
 - (void)loadMoreData {
 self.data +=2;
 [super loadMoreData];
 }
实现自己步骤,调用即可,会自己刷新数据
 
 */
@end
