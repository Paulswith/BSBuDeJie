//
//  BSTabBar.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/1.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSTabBar.h"
#import "BSPublishViewController.h"

@interface BSTabBar()

@property (strong, nonatomic) UIButton *plusBtn;
//@property (strong, nonatomic) CABasicAnimation *clockwiseRotation;
//@property (strong, nonatomic) CABasicAnimation *cClockwiseRotation;

@property (assign, nonatomic,getter=isPlusRotation) BOOL rotation;
@property (assign, nonatomic,getter=isChangeLayout) BOOL layout;

@end
@implementation BSTabBar
- (UIButton *)plusBtn {
    if (!_plusBtn) {
        _plusBtn = [[UIButton alloc] init];
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [_plusBtn sizeToFit];
        [self addSubview:_plusBtn];
        [_plusBtn addTarget:self action:@selector(rotation:) forControlEvents:UIControlEventTouchDown];
    }
    return _plusBtn;
}
#pragma mark - 加号动画与跳转逻辑
- (void)rotation:(UIButton *)btn {
    if (self.isPlusRotation == NO) {
        [self.plusBtn.layer addAnimation:[self rotationWithValue:@(M_PI_2)] forKey:@"basic"];
        self.rotation = YES;
    }else {
        [self.plusBtn.layer addAnimation:[self rotationWithValue:@(-M_PI_2)] forKey:@"basic"];
        self.rotation = NO;
    }
#warning tempDo
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[BSPublishViewController new] animated:YES completion:nil];
}
- (CABasicAnimation *)rotationWithValue:(NSNumber *)value {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z"; //transform.
    animation.toValue = value;
    animation.duration = 0.2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}

#pragma mark - 添加加号按钮
- (void)layoutSubviews {
//    NSLog(@"%s",__func__);
    [super layoutSubviews];
//    NSLog(@"布局");
    NSInteger itemCount = self.items.count + 1;
    //    NSLog(@"%ld",itemCount);
    //    NSLog(@"%@",NSStringFromCGRect(self.frame));
    CGFloat itemWidth = self.width/itemCount;
    CGFloat itemHeight = self.height;
    NSInteger i = 0;
    
    for (UIView *tabbarBtn in self.subviews) {
        if ([tabbarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i++;
            }
            tabbarBtn.frame = CGRectMake(i * itemWidth, 0, itemWidth, itemHeight);
            i++;
        }
    }
    self.plusBtn.center = CGPointMake(self.width/2, self.height/2);
}

@end
