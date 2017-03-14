//
//  YGRouter.m
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "YGRouter.h"


@interface YGRouter ()
@property(nonatomic,strong)YGRouterState *      state;                   //当前状态
@property(nonatomic,strong) NSMutableArray *    stateList;               //状态堆栈
@property(nonatomic,strong) NSMutableArray *    rootStates;

@end

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
    }
    return self;
}


- (NSArray *)registRootStates:(NSArray *)states{
    self.rootStates = [NSMutableArray array];
    NSMutableArray * rootStateEntity = [NSMutableArray array];
    [states enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YGRouterState * state = [YGRouterState stateWithURL:obj];
        //state.stateEntity = obj;
        id  entity = [[NSClassFromString(state.name) alloc] init];
        state.stateEntity = entity;
        [rootStateEntity addObject:entity];
        [self.rootStates addObject:state];
    }];
    
    return rootStateEntity;
}


- (YGRouter *(^)(NSString *))openState{
    return ^id(NSString * stateName){
       [self.rootStates enumerateObjectsUsingBlock:^(YGRouterState * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           if ([stateName isEqualToString:obj.url] || [stateName isEqualToString:obj.name]) {//根据url或者statename判断状态名
               self.state = obj;                            //设置当前状态
               self.stateList = [NSMutableArray array];     //重新设置堆栈状态
               [self.stateList addObject:self.state];
               * stop = YES;
           }
       }];
        return self;
    };
}

- (YGRouter *(^)(NSString *))gotoState{
    return ^id(NSString * url){
        [self _updateStateList];
        YGRouterState * state = [YGRouterState stateWithURL:url];
        if (state.routerType == YGRouterTypePage) {
            Class class = NSClassFromString(state.name);
            if (!class) {
                NSLog(@"当前类不存在");
                return self;
            }
            UIViewController * fromVC = (UIViewController *)self.state.stateEntity
            ;
            UIViewController * toVC = [[class alloc] init];
            state.stateEntity = toVC;
            switch (state.translateType) {
                case YGRouterPageTranslateTypeNavDefault:
                    if (!fromVC.navigationController) {
                        NSLog(@"没有导航栏怎么跳转");
                        return self;
                    }
                    [fromVC.navigationController pushViewController:toVC animated:YES];
                    break;
                case YGRouterPageTranslateTypeNavNoAnimation:
                    if (!fromVC.navigationController) {
                        NSLog(@"没有导航栏怎么跳转");
                        return self;
                    }
                    [fromVC.navigationController pushViewController:toVC animated:nil];
                    break;
                case YGRouterPageTranslateTypeNavCustom:
                    if (!fromVC.navigationController) {
                        NSLog(@"没有导航栏怎么跳转");
                        return self;
                    }
                    fromVC.navigationController.delegate = (UIViewController<UINavigationControllerDelegate> *)toVC;
                    [fromVC.navigationController pushViewController:toVC animated:YES];
                    break;
                case YGRouterPageTranslateTypeModalDefault:
                case YGRouterPageTranslateTypeModalCustom:
                    [fromVC presentViewController:toVC animated:YES completion:nil];
                    break;
                case YGRouterPageTranslateTypeModalNoAnimation:
                    [fromVC presentViewController:toVC animated:NO completion:nil];
                    break;
                default:
                    break;
            }
            self.state = state;
            [self.stateList addObject:self.state];   //state入栈
            NSLog(@"当前state堆栈状态:%@",self.stateList);
        }
        return self;
    };
}

- (YGRouter *(^)(NSString *))backToState{
    return ^id(NSString * state){
        [self _updateStateList];
        [self.stateList enumerateObjectsUsingBlock:^(YGRouterState * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([state isEqualToString:obj.name] || [state isEqualToString:obj.url]) {
                UIViewController * fromVC = (UIViewController *)self.state.stateEntity;
                UIViewController * toVC = (UIViewController *)obj.stateEntity;
                switch (self.state.translateType) {
                    case YGRouterPageTranslateTypeNavDefault:
                    case YGRouterPageTranslateTypeNavNoAnimation:
                    case YGRouterPageTranslateTypeNavCustom:
                        [fromVC.navigationController popToViewController:toVC animated:YES];
                        break;
                    case YGRouterPageTranslateTypeModalCustom:
                    case YGRouterPageTranslateTypeModalDefault:
                    case YGRouterPageTranslateTypeModalNoAnimation:
                        [fromVC dismissViewControllerAnimated:YES completion:nil];
                        break;
                    default:
                        break;
                }
            }
        }];
        return self;
    };
}
- (YGRouter *(^)())goBack{
    return ^id(){
        [self _updateStateList];
         UIViewController * fromVC = (UIViewController *)self.state.stateEntity;
        switch (self.state.translateType) {
                case YGRouterPageTranslateTypeNavDefault:
                case YGRouterPageTranslateTypeNavNoAnimation:
                case YGRouterPageTranslateTypeNavCustom:
                    [fromVC.navigationController popViewControllerAnimated:YES];
                    break;
                case YGRouterPageTranslateTypeModalCustom:
                case YGRouterPageTranslateTypeModalDefault:
                case YGRouterPageTranslateTypeModalNoAnimation:
                    [fromVC dismissViewControllerAnimated:YES completion:nil];
                    break;
                default:
                    break;
        }
        return self;
    };
}

- (void (^)(routerCompletionBlock))completion{
    return ^(routerCompletionBlock block){
        UIViewController * toVC = (UIViewController *)self.state.stateEntity;
        toVC.routerBlock = block;
    };
}

- (YGRouter *(^)(id))withParmeters{
    return ^id(id pars){
        UIViewController * toVC = (UIViewController *)self.state.stateEntity;
        toVC.launchData = pars;
        return self;
    };
}

#pragma mark - private

- (void)_updateStateList{
    __block NSInteger length = 0;
    [self.stateList enumerateObjectsUsingBlock:^(YGRouterState * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.stateEntity) {
            length++;
        }
        if (obj.stateEntity == nil && idx > 0) {
            self.state = self.stateList[idx - 1];       //从当前堆栈中获取当前state
            *stop = YES;
        }
    }];
    if (length > 0) {
        self.stateList = [[self.stateList subarrayWithRange:NSMakeRange(0, length)] mutableCopy];
    }
}



@end
