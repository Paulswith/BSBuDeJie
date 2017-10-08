//
//  BSLoginAndRegisterView.m
//  BSBuDeJie
//
//  Created by Dobby on 2017/10/3.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSLoginAndRegisterView.h"
#import "UITextField+BSTextField.h"


@interface BSLoginAndRegisterView()
//@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation BSLoginAndRegisterView

+ (instancetype)loginView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][1];
}

+ (instancetype)registerView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // mark踩坑: xib绑定了view,就不要去绑定类,不然会直接在类查找报错
    [self stretBtnBGImage];
    [_textField addTarget:self action:@selector(startBla) forControlEvents:UIControlEventEditingDidBegin];
    
    
    
    
}
- (void)startBla {
    _textField.placeHolderColor = [UIColor redColor];
    BSLog(@"%@",_textField.placeHolderColor);
}
#pragma mark - 按钮拉伸修复
- (void)stretBtnBGImage {
    UIImage *loginBGImage = _loginButton.currentBackgroundImage;
    loginBGImage = [loginBGImage stretchableImageWithLeftCapWidth:loginBGImage.width/2 topCapHeight:loginBGImage.height/2];
    [_loginButton setBackgroundImage:loginBGImage forState:UIControlStateNormal];

    UIImage *registerBGImage = _registerBtn.currentBackgroundImage;
    registerBGImage = [registerBGImage stretchableImageWithLeftCapWidth:registerBGImage.width/2 topCapHeight:registerBGImage.height/2];
    [_registerBtn setBackgroundImage:loginBGImage forState:UIControlStateNormal];
}
@end
