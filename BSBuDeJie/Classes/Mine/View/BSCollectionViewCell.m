//
//  BSCollectionViewCell.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/8.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSCollectionViewCell.h"
#import "UIColor+RandomColor.h"
#import "BSMineCollectionItem.h"
#import <UIImageView+WebCache.h>


@interface BSCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
@implementation BSCollectionViewCell


- (void)setCellOfMineItem:(BSMineCollectionItem *)cellOfMineItem {
    _cellOfMineItem = cellOfMineItem;
    NSURL *imageURL = [NSURL URLWithString:cellOfMineItem.icon];
    [_imageView sd_setImageWithURL:imageURL];
    _textLabel.text = cellOfMineItem.name;
    _textLabel.textColor = [UIColor randomColor];
}

@end
