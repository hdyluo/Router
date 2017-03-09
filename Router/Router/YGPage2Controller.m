//
//  YGPage2Controller.m
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "YGPage2Controller.h"

@interface YGPage2Controller ()
@property(nonatomic,strong) UILabel * label;
@end

@implementation YGPage2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    self.label.text = [self.launchData objectForKey:@"par1"];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.routerBlock) {
        self.routerBlock(@"page2数据返回了");
    }
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
