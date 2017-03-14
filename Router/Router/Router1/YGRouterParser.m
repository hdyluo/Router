//
//  YGRouterParser.m
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "YGRouterParser.h"


@interface YGRouterParser ()
@property(nonatomic,copy) NSString * scheme;
@property(nonatomic,copy) NSString * host;
@property(nonatomic,copy) NSString * frament;
@property(nonatomic,copy) NSString * parameters;
@end

@implementation YGRouterParser

- (void)parseWithURL:(NSURL *)url{
    self.scheme = url.scheme;
    self.host = url.host;
    self.frament = url.fragment;
    self.parameters = url.parameterString;
    [self _parseWithScheme];
    [self _parseWithHost];
    [self _parseWithFragment];
}

- (void)_parseWithScheme{
    if (!self.scheme) {
        self.routerType = YGRouterTypeNone;
        NSLog(@"不能解析的路由类型");
        return;
    }
    if ([self.scheme isEqualToString:@"YG"]) {  //页面模块
        self.routerType = YGRouterTypePage;
        return;
    }
    if ([self.scheme isEqualToString:@"Http"] || [self.scheme isEqualToString:@"Https"]) {
        self.routerType = YGRouterTypeServer;
        return;
    }
    if ([self.scheme isEqualToString:@"YGF"]) {
        self.routerType = YGRouterTypeFunc;
    }
}

- (void)_parseWithHost{
    switch (self.routerType) {
        case YGRouterTypePage:{
            NSString * vcStr = [NSString stringWithFormat:@"%@%@Controller",self.scheme,self.host];
            self.toClassStr = vcStr;
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
        if ([self.frament isEqualToString:@"NC"]) { //模块需要自定义nav转场过去
            self.translateType = YGRouterPageTranslateTypeNavCustom;
            return;
        }
        if ([self.frament isEqualToString:@"NN"]) { //模块所需跳转无动画方式
            self.translateType = YGRouterPageTranslateTypeNavNoAnimation;
        }
        if ([self.frament isEqualToString:@"M"]) {
            self.translateType = YGRouterPageTranslateTypeModalDefault;
            return;
        }
        if ([self.frament isEqualToString:@"MC"]) {
            self.translateType = YGRouterPageTranslateTypeModalCustom;
        }
        if ([self.frament isEqualToString:@"MN"]) {
            self.translateType = YGRouterPageTranslateTypeModalNoAnimation;
        }
    }
}

@end
