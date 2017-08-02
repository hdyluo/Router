//
//  AppDelegate.m
//  DYRouter
//
//  Created by 黄德玉 on 2017/6/1.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "AppDelegate.h"
#import "DYRouter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UITabBarController * tabVC = [[UITabBarController alloc] init];
    NSArray * vcs = [DYRouter.sharedRouter() registRootStates:@[@"DY://Main#0",@"DY://Main#1"]];
    NSMutableArray * navs = [NSMutableArray array];
    [vcs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:obj];
        [navs addObject:nav];
    }];
    [tabVC setViewControllers:navs];
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = tabVC;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
