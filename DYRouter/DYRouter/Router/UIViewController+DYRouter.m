//
//  UIViewController+DYRouter.m
//  DYRouter
//
//  Created by 黄德玉 on 2017/6/1.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "UIViewController+DYRouter.h"
#import <objc/runtime.h>
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

@implementation UIViewController (DYRouter)


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

static char * extraParKey;
static char * blockKey;
static char * routerStateKey;

- (void)setDy_launchData:(id)dy_launchData{
    objc_setAssociatedObject(self, &extraParKey, dy_launchData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)dy_launchData{
    return objc_getAssociatedObject(self, &extraParKey);
}

- (void)setDy_routerBlock:(void (^)(id))dy_routerBlock{
    objc_setAssociatedObject(self, &blockKey, dy_routerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id))dy_routerBlock{
    return objc_getAssociatedObject(self, &blockKey);
}

- (DYRouterState *)routerState{
   return objc_getAssociatedObject(self, &routerStateKey);
}
- (void)setRouterState:(DYRouterState *)routerState{
    objc_setAssociatedObject(self, &routerStateKey, routerState, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)pushToState:(NSString *)state withPars:(id)data backAction:(void (^)())action{
    if (!self.navigationController) {
        DLog(@"没有导航栏无法做跳转");
        return;
    }
    
    DYRouterState * s = [DYRouterState stateWithURLString:state];
    if (!s) {
        DLog(@"解析状态失败");
        return;
    }
    UIViewController * vc = [NSClassFromString(s.name) new];
    if (!vc) {
        DLog(@"当前控制器不存在，无法跳转");
        return;
    }
    
    __block BOOL needReturn = NO;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.routerState.tag == vc.routerState.tag) {
            DLog(@"存在同名的状态，请修改fragment,原因也可能是你连续点击造成的");
            *stop = YES;
            needReturn = YES;
        }
    }];
    if (needReturn) {
        return;
    }

    vc.dy_launchData = data;    //为下级页面指定启动数据
    vc.dy_routerBlock = action; //为下级页面指定路由回调
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)popToState:(NSString *)state{
    if (!self.navigationController) {
        DLog(@"没有导航栏无法做跳转");
        return;
    }
    DYRouterState * s = [DYRouterState stateWithURLString:state];
    if (!s) {
        DLog(@"解析状态失败");
        return;
    }
    __block UIViewController * popVC = nil;
    __block BOOL needReturn = YES;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.routerState.name isEqualToString:s.name]) {
            *stop = YES;
            popVC = obj;
            needReturn = NO;
        }
    }];
    if (needReturn) {
        DLog(@"没有找到相应控制器");
        return;
    }
    
    [self.navigationController popToViewController:popVC animated:YES];
}

- (void)presentState:(NSString *)state withPars:(id)data backAction:(void (^)())action{
    DYRouterState * s = [DYRouterState stateWithURLString:state];
    if (!s) {
        DLog(@"解析状态失败");
        return;
    }
    UIViewController * vc = [NSClassFromString(s.name) new];
    if (!vc) {
        DLog(@"当前控制器不存在，无法跳转");
        return;
    }
    [self presentViewController:vc animated:YES completion:nil];
}


@end

