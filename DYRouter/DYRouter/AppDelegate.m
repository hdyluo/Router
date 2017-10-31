//
//  AppDelegate.m
//  DYRouter
//
//  Created by 黄德玉 on 2017/6/1.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "AppDelegate.h"
#import "UIViewController+DYRouter.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[UIViewController urlInstance:@"dy://Main#0"]];
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
