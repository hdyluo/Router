//
//  YGRouter.h
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGRouterModel.h"
#import "YGRouterParser.h"
#import "UIViewController+Router.h"

@interface YGRouter : NSObject

@property(nonatomic,strong) YGRouterModel * routerModel;

@property(nonatomic,strong) YGRouterParser * parser;

+ (instancetype)sharedRouter;

- (void)openPageWithURLString:(NSString *)str sourcePage:(UIViewController *)vc parameters:(id)pars handle:(void (^)(id object))callback;

@end
