//
//  DYPageOne.m
//  DYRouter
//
//  Created by 黄德玉 on 2017/6/1.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "DYPageOneVC.h"
#import "UIViewController+DYRouter.h"

@interface DYPageOneVC ()

@property (nonatomic,strong) UIButton * button;

@end

@implementation DYPageOneVC

- (instancetype)init
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    // Do any additional setup after loading the view.
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"点我" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    self.button.frame = CGRectMake(0, 0, 200, 200);
    self.button.center = self.view.center;
    NSLog(@"传入的参数是%@",self.dy_launchData);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.dy_routerBlock) {
        self.dy_routerBlock(@{@"id":@"xxxx",@"name":@"传回的参数"});
    }
}


- (void)btnClicked:(UIButton *)btn{
    [self pushToState:@"dy://PageOne#1" withPars:@{@"id":@"2",@"name":@"pageTwo"} backAction:^(id data) {
        
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self popToState:@"dy://Main" withData:@"你好"];
}

@end
