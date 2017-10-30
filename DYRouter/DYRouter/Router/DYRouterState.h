//
//  DYRouterState.h
//  DYRouter
//
//  Created by 黄德玉 on 2017/6/1.
//  Copyright © 2017年 黄德玉. All rights reserved.
// 路由状态也是页面状态

#import <Foundation/Foundation.h>


@interface DYRouterState : NSObject

//@property (nonatomic,assign) NSInteger identify;            //状态的唯一标识符，用hash标识
@property (nonatomic,assign) NSInteger tag;                 //状态同名阻止状态，用tag区分
@property (nonatomic,copy) NSString * url;                   //状态url可能一样，但是identify是唯一的,页面的url格式是 DY://home#fragment
@property (nonatomic,copy) NSString * name;                  //状态名字,为控制器名字

+ (instancetype)stateWithURLString:(NSString *)urlStr;



@end
