//
//  CardAnimator.m
//  Squad
//
//  Created by Ashwin Kumar on 6/6/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import "CardAnimator.h"

@interface CardAnimator ()

@end

@implementation CardAnimator

- (instancetype)init {
    if (self = [super init]) {
        _duration = 0.2;
        _presenting = YES;
        _originFrame = CGRectZero;
    }
    return self;
}


#pragma mark - Transitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    BOOL presenting = self.presenting;
    
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *cardView = presenting ? toView : [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    CGRect initialFrame = presenting ? self.originFrame : cardView.frame;
    CGRect finalFrame = presenting ? cardView.frame : self.originFrame;

    CGFloat xScaleFactor = presenting ? initialFrame.size.width / finalFrame.size.width : finalFrame.size.width / initialFrame.size.width;
    CGFloat yScaleFactor = presenting ? initialFrame.size.height / finalFrame.size.height : finalFrame.size.height / initialFrame.size.height;
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    
    if (presenting) {
        toView.transform = scaleTransform;
        toView.center = CGPointMake(CGRectGetMidX(initialFrame), CGRectGetMidY(initialFrame));
        toView.clipsToBounds = YES;
    } else {
        cardView.alpha = 1.0;
        fromView.clipsToBounds = YES;
    }

    [containerView addSubview:toView];
    [containerView bringSubviewToFront:toView];
    
    [UIView animateWithDuration:self.duration
                     animations:^{
        
                         if (presenting) {
                             toView.transform = CGAffineTransformIdentity;
                             toView.center = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));
                             fromView.alpha = .5;
                         } else {
                             

                             
                             toView.alpha = 1.0;
                             fromView.transform = scaleTransform;
                             fromView.center = CGPointMake(CGRectGetMidX(self.originFrame), CGRectGetMidY(self.originFrame));
                             
                              [[NSNotificationCenter defaultCenter]
                               postNotificationName:@"DetailCardDismissed"
                               object:self];
                         }

    } completion:^(BOOL finished) {

        [transitionContext completeTransition:YES];
        [containerView addSubview:fromView];
        [containerView sendSubviewToBack:fromView];
        
    }];


}

@end
