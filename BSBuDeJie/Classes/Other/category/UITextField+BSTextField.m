//
//  UITextField+BSTextField.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/8.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "UITextField+BSTextField.h"
#import <objc/message.h>


#define placeholderColor @"placeholderColor"
#define placeholderLabel @"placeholderLabel"
@implementation UITextField (BSTextField)

+ (void)load {
    //在这里交换方法
    Method systemMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method customMethod = class_getInstanceMethod(self, @selector(setBSPlaceHolder:));
    method_exchangeImplementations(systemMethod, customMethod);
}

- (UIColor *)placeHolderColor {
    // 获取成员属性
    return objc_getAssociatedObject(self, placeholderColor);
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    // 新增一个成员属性, 设置值为color strong
    objc_setAssociatedObject(self, placeholderColor, placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *textFieldLabel = [self valueForKey:placeholderLabel];
    textFieldLabel.textColor = placeHolderColor;
}

- (void)setBSPlaceHolder:(NSString *)placeHolder {
    // 交换方法后,此代码保存到setPlaceholder:, 所以改为当前的, 就不会死循环了
    [self setBSPlaceHolder:placeHolder];
    self.placeHolderColor = self.placeHolderColor;
}
@end
