//
//  NBAlertDismissFadeOut.m
//  NBAlertController
//
//  Created by NapoleonBai on 16/7/15.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import "NBAlertDismissFadeOut.h"

@implementation NBAlertDismissFadeOut
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.15;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         fromVC.view.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}
@end
