//
//  YGRouterState.h
//  YGBaseFramework
//
//  Created by 黄德玉 on 2017/3/13.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,YGRouterType) {
    YGRouterTypeNone = 0,
    YGRouterTypePage,           //页面跳转的路由方式
    YGRouterTypeFunc,           //功能模块调用的路由方式
    YGRouterTypeServer          //服务h5页面的方式
};

typedef NS_ENUM(NSInteger,YGRouterPageTranslateType) {
    YGRouterPageTranslateTypeNavDefault = 0,  //启动模块所需转场方式
    YGRouterPageTranslateTypeNavNoAnimation,
    YGRouterPageTranslateTypeNavCustom,
    YGRouterPageTranslateTypeModalDefault,
    YGRouterPageTranslateTypeModalNoAnimation,
    YGRouterPageTranslateTypeModalCustom
};


@interface YGRouterState : NSObject

@property(nonatomic,copy) NSString *                    name;              //state对应的name,也是className

@property(nonatomic,copy) NSString *                    url;               //state对应的url

@property(nonatomic,weak) id                            stateEntity;       //state的实体，可以是一个控制器，可以是一个功能模块

@property(nonatomic,assign) YGRouterType                routerType;

@property(nonatomic,assign) YGRouterPageTranslateType   translateType;

+ (instancetype)stateWithURL:(NSString *)url;

@end
