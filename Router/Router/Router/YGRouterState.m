//
//  YGRouterState.m
//  YGBaseFramework
//
//  Created by 黄德玉 on 2017/3/13.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "YGRouterState.h"


@interface YGRouterState ()
@property(nonatomic,copy) NSString * scheme;
@property(nonatomic,copy) NSString * host;
@property(nonatomic,copy) NSString * frament;
@property(nonatomic,copy) NSString * parameters;
@end

@implementation YGRouterState


+ (instancetype)stateWithURL:(NSString *)urlStr{
    YGRouterState * state = [[YGRouterState alloc] init];
    state.routerType = YGRouterTypeNone;
    state.translateType = YGRouterPageTranslateTypeNavDefault;
    state.name = @"";
    if (!urlStr) {
        NSLog(@"url不能为空");
    }
    NSURL * url = [NSURL URLWithString:urlStr];
    if (!url) {
        NSLog(@"url解析失败");
    }
    state.url = urlStr;
    state.scheme = url.scheme;
    state.host = url.host;
    state.frament = url.fragment;
    state.parameters = url.parameterString;
    [state _parseWithScheme];
    [state _parseWithHost];
    [state _parseWithFragment];
    
    return state;
}

- (void)_parseWithScheme{
    if (!self.scheme) {
        self.routerType = YGRouterTypeNone;
        NSLog(@"不能解析的路由类型");
        return;
    }
    if ([self.scheme.uppercaseString isEqualToString:@"YG"]) {  //页面模块
        self.routerType = YGRouterTypePage;
        return;
    }
    if ([self.scheme.uppercaseString isEqualToString:@"HTTP"] || [self.scheme.uppercaseString isEqualToString:@"HTTPS"]) {
        self.routerType = YGRouterTypeServer;
        return;
    }
    if ([self.scheme.uppercaseString isEqualToString:@"YGF"]) {
        self.routerType = YGRouterTypeFunc;
    }
}

- (void)_parseWithHost{
    switch (self.routerType) {
        case YGRouterTypePage:{
            NSString * vcStr = [NSString stringWithFormat:@"%@%@Controller",self.scheme.uppercaseString,self.host];
            self.name = vcStr;
        }
            break;
        case YGRouterTypeFunc:
            break;
        case YGRouterTypeNone:
            break;
        default:
            break;
    }
}
- (void)_parseWithFragment{
    if (self.routerType == YGRouterTypePage) {
        if (!self.frament) {
            self.translateType = YGRouterPageTranslateTypeNavDefault;
            return;
        }
        if ([self.frament.uppercaseString isEqualToString:@"NC"]) { //模块需要自定义nav转场过去
            self.translateType = YGRouterPageTranslateTypeNavCustom;
            return;
        }
        if ([self.frament.uppercaseString isEqualToString:@"NN"]) { //模块所需跳转无动画方式
            self.translateType = YGRouterPageTranslateTypeNavNoAnimation;
        }
        if ([self.frament.uppercaseString isEqualToString:@"M"]) {
            self.translateType = YGRouterPageTranslateTypeModalDefault;
            return;
        }
        if ([self.frament.uppercaseString isEqualToString:@"MC"]) {
            self.translateType = YGRouterPageTranslateTypeModalCustom;
        }
        if ([self.frament.uppercaseString isEqualToString:@"MN"]) {
            self.translateType = YGRouterPageTranslateTypeModalNoAnimation;
        }
    }
}
@end
