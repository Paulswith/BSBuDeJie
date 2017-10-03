//
//  BSQuickLogin.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/3.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSQuickLogin.h"

@implementation BSQuickLogin


+ (instancetype)quickLoginView {
    BSQuickLogin *b = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    BSLog(@"%@",b);
    return b;
}
@end
