//
//  YGRouterParser.h
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//  解析器决定路由的类型，是页面跳转，还是功能模块调用

#import <Foundation/Foundation.h>
#import "YGRouterModel.h"

typedef NS_ENUM(NSInteger,YGRouterType) {
    YGRouterTypeNone = 0,
    YGRouterTypePage,   //页面跳转的路由方式
    YGRouterTypeFunc,        //功能模块调用的路由方式
    YGRouterTypeServer       //服务h5页面的方式
};

typedef NS_ENUM(NSInteger,YGRouterPageTranslateType) {
    YGRouterPageTranslateTypeNavDefault = 0,  //启动模块所需转场方式
    YGRouterPageTranslateTypeNavNoAnimation,
    YGRouterPageTranslateTypeNavCustom,
    YGRouterPageTranslateTypeModalDefault,
    YGRouterPageTranslateTypeModalNoAnimation,
    YGRouterPageTranslateTypeModalCustom
};

@interface YGRouterParser : NSObject

@property(nonatomic,assign) YGRouterType routerType;
@property(nonatomic,assign) YGRouterPageTranslateType translateType;
@property(nonatomic,copy) NSString *  toClassStr;
- (void)parseWithURL:(NSURL *)url;
@end
