//
//  YGRouter.m
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "YGRouter.h"


@implementation YGRouter

+ (instancetype)sharedRouter{
    static YGRouter * router =  nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[YGRouter alloc] init];
    });
    return router;
}

- (instancetype)init{
    if (self = [super init]) {
        self.routerModel = [[YGRouterModel alloc] init];
        self.parser = [[YGRouterParser alloc] init];
    }
    return self;
}


- (void)openPageWithURLString:(NSString *)str sourcePage:(UIViewController *)vc parameters:(id)pars handle:(void (^)(id))callback{
    if (!str) {
        NSLog(@"路由地址为空");
        return;
    }
    NSURL * url = [NSURL URLWithString:str];
    if (!url) {
        NSLog(@"url不合法");
        return;
    }
    [self.parser parseWithURL:url];
    if (self.parser.routerType == YGRouterTypePage) {
        Class class = NSClassFromString(self.parser.toClassStr);
        if (!class) {
            NSLog(@"当前类不存在");
            return;
        }
        UIViewController * toVC = [[class alloc] init];
        if (pars) {
            toVC.launchData = pars;
        }
        if (callback) {
            toVC.routerBlock = callback;
        }
        switch (self.parser.translateType) {
            case YGRouterPageTranslateTypeNavDefault:   //默认导航栏跳转
                if (!vc.navigationController) {
                    NSLog(@"当前页面不存在导航栏无法跳转");
                    return;
                }
                [vc.navigationController pushViewController:toVC animated:YES];
                break;
            case YGRouterPageTranslateTypeNavCustom:    //自定义导航栏跳转
                if (!vc.navigationController) {
                    NSLog(@"当前页面不存在导航啦无法跳转");
                    return;
                }
                vc.navigationController.delegate = (UIViewController<UINavigationControllerDelegate> *)toVC;
                [vc.navigationController pushViewController:toVC animated:YES];
                break;
            case YGRouterPageTranslateTypeNavNoAnimation:   //导航栏跳转无动画
                if (!vc.navigationController) {
                    NSLog(@"当前页面不存在导航啦无法跳转");
                    return;
                }
                [vc.navigationController pushViewController:toVC animated:NO];
                break;
            case YGRouterPageTranslateTypeModalCustom:      //modal转场
            case YGRouterPageTranslateTypeModalDefault:
                [vc presentViewController:toVC animated:YES completion:nil];
                break;
            case YGRouterPageTranslateTypeModalNoAnimation: //modal转场无动画
                [vc presentViewController:toVC animated:NO completion:nil];
                break;
            default:
                break;
        }
    }
}
@end
