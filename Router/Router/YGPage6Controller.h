//
//  YGPage6Controller.h
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGPage6Controller : UIViewController<UIViewControllerTransitioningDelegate>

@end


@interface page6Animator : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign) BOOL type;
- (instancetype)initWithType:(BOOL)type;
@end
