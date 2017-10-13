//
//  BSEssenceTableView.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/14.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceTableView.h"

@interface BSEssenceTableView ()

@end

@implementation BSEssenceTableView

static NSString * const ID = @"EssenceCell";
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor randomColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text=NSStringFromClass([self class]);
    return cell;
}




@end
