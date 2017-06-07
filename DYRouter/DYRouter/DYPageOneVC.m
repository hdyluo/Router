//
//  DYPageOne.m
//  DYRouter
//
//  Created by 黄德玉 on 2017/6/1.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "DYPageOneVC.h"
#import "DYRouter.h"

@interface DYPageOneVC ()

@property (nonatomic,strong) UIButton * button;

@end

@implementation DYPageOneVC

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
//    DYRouter.sharedRouter()
//    .backToState(@"DY://Main",YES);
    DYRouter.sharedRouter().back(YES,DYPageShowTypeDismiss);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DYRouter.sharedRouter()
    .goToState(@"DY://PageOne#1",YES,DYPageShowTypePush)
    .withPars(@{@"id":@"123",@"name":@"你好"})
    .completion(^(id object){
        
    });
}

@end
