//
//  ViewController.m
//  DYRouter
//
//  Created by 黄德玉 on 2017/6/1.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "DYMainVC.h"


@interface DYMainVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) NSArray * datas;

@end

@implementation DYMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.datas = @[@"默认导航栏跳转",@"默认导航啦无动画跳转",@"自定义导航栏跳转",@"默认modal跳转",@"默认modal无动画跳转",@"自定义modal跳转"];
  //  self.tabBarController.selectedIndex = 0;
}

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
