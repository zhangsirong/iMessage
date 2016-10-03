//
//  ViewController.m
//  MyImessage2
//
//  Created by zsr on 2016/10/2.
//  Copyright © 2016年 zsr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"请打开信息应用加载Imessage扩展";
    label.center = self.view.center;
    [self.view addSubview:label];
}
@end
