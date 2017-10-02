//
//  BSPublishViewController.m
//  BSBuDeJie
//
//  Created by v_ljiayili(李嘉艺) on 2017/9/27.
//  Copyright © 2017年 Dobby. All rights reserved.
//

#import "BSPublishViewController.h"
#import "UIColor+RandomColor.h"

@interface BSPublishViewController ()

@end

@implementation BSPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor randomColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//#if DEGUG
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//#enif

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
