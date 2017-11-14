//
//  DYRouterState.m
//  DYRouter
//
//  Created by 黄德玉 on 2017/6/1.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "DYRouterState.h"

@interface DYRouterState ()

@property(nonatomic,copy) NSString * scheme;
@property(nonatomic,copy) NSString * host;
@property(nonatomic,copy) NSString * frament;
@property(nonatomic,copy) NSString * parameters;


@end

@implementation DYRouterState

static NSMutableArray * uriTypes;

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self registerWithScheme:@"DY" tail:@"VC"];
    });
}


+ (void)registerWithScheme:(NSString *)scheme tail:(NSString *)tail{
    if (!uriTypes) {
        uriTypes = [NSMutableArray array];
    }
    id data = @{
                @"scheme":scheme,
                @"tail":tail
                };
    __block BOOL needAddData = YES;
    [uriTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * schemeT = [obj objectForKey:@"scheme"];
        NSString * tailT = [obj objectForKey:@"tail"];
        if ([scheme isEqualToString:schemeT] && [tail isEqualToString:tailT]) {
            needAddData = NO;
            * stop = YES;
        }
    }];
    if (needAddData) {
        [uriTypes addObject:data];
    }
}

+ (instancetype)stateWithURLString:(NSString *)urlStr{
    if (!urlStr) {
        NSLog(@"状态不能为空");
        return nil;
    }
    NSURL * url = [NSURL URLWithString:urlStr];
    if (!url) {
        NSLog(@"url解析失败");
        return nil;
    }
    
    DYRouterState * state = [[DYRouterState alloc] init];
    state.url = urlStr;
    state.scheme = url.scheme;
    state.frament = url.fragment;
    state.host = url.host;
    state.parameters = url.parameterString;
    [state _parseWithScheme];
    [state _parseWithFrament];
    return state;
}

- (void)_parseWithScheme{
    if (!self.scheme) {
        return;
    }
    [uriTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * schemeT = [obj objectForKey:@"scheme"];
        NSString * tailT = [obj objectForKey:@"tail"];
        if ([self.scheme.uppercaseString isEqualToString:schemeT]) {
            NSString * vcStr = [NSString stringWithFormat:@"%@%@%@",self.scheme.uppercaseString,self.host,tailT];
            self.name = vcStr;
            *stop = YES;
        }
    }];
}

- (void)_parseWithFrament{
    if (!self.frament) {
        self.tag = 0;
        return;
    }
    NSInteger tag = self.frament.integerValue;
    self.tag = tag;
}

@end
