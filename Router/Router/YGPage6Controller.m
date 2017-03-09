//
//  YGPage6Controller.m
//  Router
//
//  Created by 黄德玉 on 2017/3/9.
//  Copyright © 2017年 黄德玉. All rights reserved.
//

#import "YGPage6Controller.h"

@interface YGPage6Controller ()

@end

@implementation YGPage6Controller

- (instancetype)init{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        //self.modalTransitionStyle = UIModalPresentationCustom;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.view.layer.cornerRadius = 8.0;
    self.view.layer.masksToBounds = YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[page6Animator alloc] initWithType:0];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[page6Animator alloc] initWithType:1];
}

@end


@implementation page6Animator

- (instancetype)initWithType:(BOOL)type{
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return .5;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    if (self.type == 0) {
        [containerView addSubview:toVC.view];
        toVC.view.frame = CGRectMake(0, 0, 100, 100);
        toVC.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width * .5, [UIScreen mainScreen].bounds.size.height * .5);
        toVC.view.alpha = 0.5;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toVC.view.alpha = 1;
            toVC.view.frame = CGRectMake(toVC.view.frame.origin.x, toVC.view.frame.origin.y, 200, 200);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else{
       [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
           fromVC.view.alpha = 0;
       } completion:^(BOOL finished) {
           BOOL isCancel = [transitionContext transitionWasCancelled];
           if (!isCancel) {
               [fromVC.view removeFromSuperview];
               [transitionContext completeTransition:YES];
           }
       }];
    }
 
}


@end
