//
//  YGPage12Controller.m
//  Router
//
//  Created by 黄德玉 on 2017/3/14.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "YGPage12Controller.h"

@interface YGPage12Controller ()

@end

@implementation YGPage12Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"page12";
    self.view.backgroundColor = [UIColor brownColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  //  [YGRouter sharedRouter].goBack();
    [YGRouter sharedRouter].backToState(@"yg://View");
}

- (void)dealloc{
    NSLog(@"page12被释放了");
}

@end
