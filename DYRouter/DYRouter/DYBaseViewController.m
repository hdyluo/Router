//
//  DYBaseViewController.m
//  DYRouter
//
//  Created by 黄德玉 on 2017/10/31.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "DYBaseViewController.h"
#import "UIViewController+DYRouter.h"

@interface DYBaseViewController ()

@end

@implementation DYBaseViewController

- (instancetype)init{
    if (self = [super init]) {
        NSString * name = NSStringFromClass([self class]);
        self.routerState = [[DYRouterState alloc] init];
        self.routerState.tag = 0;
        self.routerState.name = name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
