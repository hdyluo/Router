//
//  YGRouter.h
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+Router.h"
#import "YGRouterState.h"


typedef void(^routerCompletionBlock)(id object);

@interface YGRouter : NSObject

@property(nonatomic,strong,readonly)YGRouterState *                     state;                   //当前状态

@property(nonatomic,strong,readonly) NSMutableArray<YGRouterState *> *  stateList;               //状态堆栈

@property(nonatomic,strong,readonly) NSMutableArray<YGRouterState *> *  rootStates;              //根静态状态列表

+ (instancetype)sharedRouter;

- (NSArray *)registRootStates:(NSArray *)states;             //静态根状态列表注册

- (YGRouter *(^)(NSString *url))openState;              //打开一个根状态

- (YGRouter * (^)(NSString * url))gotoState;            //通过url跳转到指定页面

- (YGRouter * (^)(NSString * url))backToState;          //返回到指定页面

- (YGRouter *(^)())goBack;                              //返回上一级state

- (YGRouter *(^)(id pars))withParmeters;                //传参数

- (void(^)(routerCompletionBlock block))completion;     //页面返回回调

@end
