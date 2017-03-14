//
//  YGPage3Controller.m
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "YGPage3Controller.h"

@interface YGPage3Controller ()

@end

@implementation YGPage3Controller


- (instancetype)init{
    if (self = [super init]) {
    //    self.navigationController.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    return [[Page3Animator alloc] init];
}

- (void)dealloc{
    self.navigationController.delegate = nil;
}

@end


@implementation Page3Animator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    toVC.view.transform  =  CGAffineTransformMakeScale(.5, .5);
    toVC.view.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        toVC.view.alpha = 1;
        toVC.view.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}
@end
