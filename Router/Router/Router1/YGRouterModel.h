//
//  YGRouterModel.h
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
// 

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YGRouterModel : NSObject

@property(nonatomic,copy) NSArray * mainPageModules;                    //并行主模块列表

@property(nonatomic,strong) UIViewController * currentPageModule;       //当前所处页面模块

@property(nonatomic,strong) NSMutableArray * logs;                    //路由日志

@property(nonatomic,strong) NSDictionary * routerMap;                   //路由表维护的路由类型

@end
