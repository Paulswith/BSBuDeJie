//
//  BSEssenceAllClell.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/18.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSEssenceAllClell.h"
#import "BSEssenceAllModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation BSEssenceAllClell
//- (instancetype)init {
//    return [self initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"BSAllTableView"];
//}


- (void)setAllModelCell:(BSEssenceAllModel *)allModelCell {
//    NSLog(@"%@",allModelCell.text);
    _allModelCell = allModelCell;
    self.textLabel.text= allModelCell.screen_name;
//    self.detailTextLabel.text = allModelCell.text;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:allModelCell.profile_image] placeholderImage:[UIImage imageNotRenderingWithName:@"place"]];
    

}
@end
