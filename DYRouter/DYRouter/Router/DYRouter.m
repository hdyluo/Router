//
//  DYRouter.m
//  DYRouter
//
//  Created by 黄德玉 on 2017/6/1.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "DYRouter.h"



@interface DYRouter ()
@property (nonatomic,strong) NSMutableArray<DYRouterState *> * rootStateList;       //持有根页面
@property (nonatomic,strong) NSMutableArray<DYRouterState *> * stateLists;          //状态堆栈列表
@property (nonatomic,strong) DYRouterState * currentRootState;                      //当前根状态
@property (nonatomic,strong) DYRouterState * currentState;                          //当前状态


@property (nonatomic,copy) NSString * transitionURL;
@property (nonatomic,strong) id transitionPars;
@property (nonatomic,assign) BOOL animated;
@property (nonatomic,copy) routerCompletionBlock backAction;
@end

@implementation DYRouter

+ (DYRouter *(^)())sharedRouter{
    static DYRouter * router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[DYRouter alloc] init];
        router.stateLists = [NSMutableArray array];
        router.rootStateList = [NSMutableArray array];
    });
    return ^DYRouter *(){
        return router;
    };
}

- (NSMutableArray *)registRootStates:(NSArray *)states{
    typeof(self) weakSelf = self;
    [states enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DYRouterState * stateTmp = [DYRouterState stateWithURLString:obj];
        if (!stateTmp) {
            RRLog(@"当前数组有不能被解析的路由类型,idx=%ld",idx);
            * stop = YES;
        }
        [weakSelf.rootStateList addObject:stateTmp];
    }];
    
    NSMutableArray * stateEnditys = [NSMutableArray array];
    for (int i = 0; i < self.rootStateList.count; i++) {
        UIViewController * vc = [NSClassFromString(self.rootStateList[i].name) new];
        self.rootStateList[i].stateEntity = vc;
        [stateEnditys addObject:vc];
    }
    [self.stateLists addObject:self.rootStateList[0]];                          //先默认指定状态列表
    self.currentState = self.stateLists.lastObject;                             //默认指定当前状态
    return stateEnditys;
}

- (DYRouter *(^)(id))switchToRootState{
    self.stateLists = [NSMutableArray array];                                   //切换根状态的时候，清空状态列表
    return ^DYRouter * (id stateEntity){
        if (!stateEntity || ![stateEntity isKindOfClass:[UIViewController class]]) {
            RRLog(@"切换根状态失败");
            return self;
        }
        [self.rootStateList enumerateObjectsUsingBlock:^(DYRouterState * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:stateEntity]) {
                * stop = YES;
                self.currentRootState = obj;
                [self.stateLists addObject:self.currentRootState];
            }
        }];
        return self;
    };
}

- (DYRouter *(^)(NSString *,BOOL))goToState{
    return ^ DYRouter *(NSString * urlStr,BOOL animated){
        self.transitionURL = urlStr;
        self.animated = YES;
        return self;
    };
}

- (DYRouter *(^)(id))withPars{
    return ^DYRouter *(id pars){
        self.transitionPars = pars;
        return self;
    };
}

- (DYRouter *(^)(routerCompletionBlock))withBackAction{
    return ^(routerCompletionBlock block){
        if (block) {
            self.backAction = block;
        }
        return self;
    };
}


- (void(^)())push{
    [self _updateStateList];
    return ^void(){
        DYRouterState * state = [DYRouterState stateWithURLString:self.transitionURL];
        for (int i = 0; i < self.stateLists.count; i++) {
            if ([self.stateLists[i].name isEqualToString:state.name] && self.stateLists[i].tag == state.tag) {
                RRLog(@"同名状态不能跳转，请指定不同的fragment");
                return;
            }
        }
        
        UIViewController * vc = [NSClassFromString(state.name) new];
        state.stateEntity = vc;
        [self.stateLists addObject:state];
        UIViewController * currentVC = self.currentState.stateEntity;
        [currentVC.navigationController pushViewController:vc animated:self.animated];
        if (self.transitionPars) {
            vc.dy_launchData = self.transitionPars;
        }
        if (self.backAction) {
            vc.dy_routerBlock = self.backAction;
        }
        self.currentState = self.stateLists.lastObject;         //更新当前状态
        
        self.transitionURL = nil;
        self.transitionPars = nil;
        self.animated = YES;
        self.backAction = nil;
    };
}

- (void (^)())present{
    [self _updateStateList];
    return ^void(){
        DYRouterState * state = [DYRouterState stateWithURLString:self.transitionURL];
        for (int i = 0; i < self.stateLists.count; i++) {
            if ([self.stateLists[i].name isEqualToString:state.name] && self.stateLists[i].tag == state.tag) {
                RRLog(@"同名状态不能跳转，请指定不同的fragment");
                return;
            }
        }
        UIViewController * vc = [NSClassFromString(state.name) new];
        state.stateEntity = vc;
        [self.stateLists addObject:state];
        UIViewController * currentVC = self.currentState.stateEntity;
        [currentVC presentViewController:vc animated:self.animated completion:nil];
        if (self.transitionPars) {
            vc.dy_launchData = self.transitionPars;
        }
        if (self.backAction) {
            vc.dy_routerBlock = self.backAction;
        }
        self.currentState = self.stateLists.lastObject;         //更新当前状态
        
        self.transitionURL = nil;
        self.transitionPars = nil;
        self.animated = YES;
        self.backAction = nil;
    };
}

- (void (^)())pop{
    
    return ^(){
        [self _backTips];
        UIViewController * currentVC = self.currentState.stateEntity;
        [currentVC.navigationController popViewControllerAnimated:self.animated];
    };
}

- (void (^)())dismiss{
    return ^(){
        [self _backTips];
        UIViewController * currentVC = self.currentState.stateEntity;
        [currentVC dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void (^)(NSString *))popTo{
    return ^(NSString * urlStr){
        [self _backTips];
        UIViewController * currentVC = self.currentState.stateEntity;
        DYRouterState * state = [DYRouterState stateWithURLString:urlStr];
        
        for (int i = 0 ; i < self.stateLists.count; i++) {
            if ([self.stateLists[i].name isEqualToString:state.name] && self.stateLists[i].tag == state.tag) {
                [currentVC.navigationController popToViewController:self.stateLists[i].stateEntity animated:YES];
                break;
            }
        }
    };
}

- (void (^)())popToRoot{
    return ^(){
        [self _backTips];
        UIViewController * currentVC = self.currentState.stateEntity;
        [currentVC.navigationController popToRootViewControllerAnimated:YES];
    };
}


- (void)_updateStateList{
    [self.stateLists enumerateObjectsUsingBlock:^(DYRouterState * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.stateEntity) {
            if (idx == 0) {             //这种情况应该不会发生
                return;
            }
            self.stateLists = [[self.stateLists subarrayWithRange:NSMakeRange(0, idx)] mutableCopy];
            self.currentState = self.stateLists.lastObject;
            * stop = YES;
        }
    }];
}

- (void)_backTips{
    if (self.transitionPars) {
        self.transitionPars = nil;
        RRLog(@"返回操作，你不应该调用 withPars");
    }
    if (self.transitionURL) {
        self.transitionURL = nil;
        RRLog(@"返回操作不应该调用goToState");
    }
    if (self.backAction) {
        self.backAction = nil;
        RRLog(@"返回操作不应该调用withBackAction");
    }
}

@end
