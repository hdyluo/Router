//
//  ViewController.m
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "YGViewController.h"

@interface YGViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) NSArray * datas;
@end

@implementation YGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.datas = @[@"默认导航栏跳转",@"默认导航啦无动画跳转",@"自定义导航栏跳转",@"默认modal跳转",@"默认modal无动画跳转",@"自定义modal跳转"];
}


#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [YGRouter sharedRouter]
            .gotoState(@"yg://Page1").
            withParmeters(@{@"pars":@"hhahahhaah"})
            .completion(^(id object){
                NSLog(@"从page1回调的内容是:%@",object);
            });
        }
            break;
        case 1:
        {
//            [[YGRouter sharedRouter] openPageWithURLString:@"YG://Page2#NN"
//                                                sourcePage:self
//                                                parameters:@{@"par1":@"传递给page2的数据"}
//                                                    handle:^void(id object) {
//                NSLog(@"page2的回调数据是:%@",object);
//            }];
            [YGRouter sharedRouter]
            .gotoState(@"yg://Page2#NN");
        }
            break;
        case 2:{
//            [[YGRouter sharedRouter] openPageWithURLString:@"YG://Page3#NC"
//                                                sourcePage:self
//                                                parameters:@{@"par1":@"传递给page3的数据"}
//                                                    handle:^void(id object) {
//                                                        NSLog(@"page3的回调数据是:%@",object);
//                                                    }];
            [YGRouter sharedRouter]
            .gotoState(@"yg://Page3#NC");
        }
            break;
        case 3:{
//            [[YGRouter sharedRouter] openPageWithURLString:@"YG://Page4#M"
//                                                sourcePage:self
//                                                parameters:nil
//                                                    handle:nil];
            [YGRouter sharedRouter]
            .gotoState(@"yg://Page4#M");
        }
            break;
        case 4:
        {
//            [[YGRouter sharedRouter] openPageWithURLString:@"YG://Page4#MN"
//                                                sourcePage:self
//                                                parameters:nil
//                                                    handle:nil];
            [YGRouter sharedRouter]
            .gotoState(@"yg://Page4#MN");
        }
            break;
        case 5:
        {
//            [[YGRouter sharedRouter] openPageWithURLString:@"YG://Page6#MC"
//                                                sourcePage:self
//                                                parameters:nil
//                                                    handle:nil];
            [YGRouter sharedRouter]
            .gotoState(@"yg://Page6#MC");
        }
            break;
        default:
            break;
    }
}
#pragma mark  - 初始化
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
