//
//  YGPage1Controller.m
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "YGPage1Controller.h"


@interface YGPage1Controller ()
@property(nonatomic,strong) UILabel * label;
@end

@implementation YGPage1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    self.label.text = [self.launchData objectForKey:@"par1"];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.routerBlock(@"navigation转场回调了");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    NSLog(@"page1退出");
}

#pragma mark - 初始化

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        _label.center = self.view.center;
        _label.backgroundColor = [UIColor brownColor];
    }
    return _label;
}

@end
