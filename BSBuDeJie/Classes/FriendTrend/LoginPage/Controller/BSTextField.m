
//
//  BSTextField.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/8.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSTextField.h"
#import "UITextField+BSTextField.h"

@implementation BSTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];
    //占位字颜色处理
    self.placeHolderColor = [UIColor lightGrayColor];
    [self addTarget:self action:@selector(startType) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(endType) forControlEvents:UIControlEventEditingDidEnd];
}
- (void)startType {
    self.placeHolderColor = [UIColor whiteColor];
}
- (void)endType {
    self.placeHolderColor = [UIColor lightGrayColor];
}

@end
