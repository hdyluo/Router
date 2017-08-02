//
//  DYRouter.h
//  DYRouter
//
//  Created by 黄德玉 on 2017/6/1.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRouterState.h"
#import "UIViewController+DYRouter.h"


#ifdef DEBUG
#define RRLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define RRLog(...)
#endif

typedef void(^routerCompletionBlock)(id object);

@interface DYRouter : NSObject

+ (DYRouter *(^)())sharedRouter;

/**
 注册根状态

 @param states 路由表
 @return 状态实例
 */
- (NSMutableArray *)registRootStates:(NSArray *)states;

/**
 stateEntity是控制器，或者路由
 */
- (DYRouter *(^)(id stateEntity))switchToRootState;

- (DYRouter *(^)(NSString *url,BOOL animated))goToState;

- (DYRouter *(^)(id pars))withPars;

- (DYRouter * (^)(routerCompletionBlock block))withBackAction;

- (void (^)())push;

- (void(^)())pop;

- (void(^)(NSString * name))popTo;

- (void(^)())popToRoot;

- (void(^)())present;

- (void(^)())dismiss;








@end
