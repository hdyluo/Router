//
//  UIViewController+Router.m
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "UIViewController+Router.h"
#import "UIViewController+Router.h"
#import <objc/runtime.h>

@implementation UIViewController (Router)
static char * extraParKey;
-(void)setLaunchData:(id)extraParameters{
    objc_setAssociatedObject(self, &extraParKey, extraParameters, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(id)launchData{
    return objc_getAssociatedObject(self, &extraParKey);
}
static char * blockKey;
-(void)setRouterBlock:(void (^)(id))callback{
    objc_setAssociatedObject(self, &blockKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void (^)(id))routerBlock{
    return objc_getAssociatedObject(self, &blockKey);
}
@end