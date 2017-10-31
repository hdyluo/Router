//
//  UIViewController+DYRouter.h
//  DYRouter
//
//  Created by 黄德玉 on 2017/6/1.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRouterState.h"

@interface UIViewController (DYRouter)

@property(nonatomic,copy) void (^dy_routerBlock)(id object);    //给来源模块的数据回调，object为回调数据模型
@property(nonatomic,strong) id  dy_launchData;                  //启动模块所需数据模型
@property (nonatomic,strong) DYRouterState *routerState;        //关联一个路由状态对象,需要在基类初始化的时候，为状态创建一个默认值，或者直接用urlInstance 初始化

+ (instancetype)urlInstance:(NSString *)urlStr;

- (void)pushToState:(NSString *)state withPars:(id)data backAction:(void (^)(id data))action;

//多级页面跳转，如何更改状态，
- (void)popToState:(NSString *)state;

- (void)presentState:(NSString *)state withPars:(id)data backAction:(void (^)(id data))action;

@end
