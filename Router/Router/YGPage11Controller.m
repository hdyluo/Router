//
//  YGPage11Controller.m
//  Router
//
//  Created by 黄德玉 on 2017/3/14.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "YGPage11Controller.h"

@interface YGPage11Controller ()

@end

@implementation YGPage11Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"page11";
    self.view.backgroundColor = [UIColor greenColor];
}

-(void)dealloc{
    NSLog(@"page11被释放");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [YGRouter sharedRouter]
    .gotoState(@"yg://Page12");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
