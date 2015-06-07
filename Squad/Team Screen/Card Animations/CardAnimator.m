//
//  CardAnimator.m
//  Squad
//
//  Created by Ashwin Kumar on 6/6/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import "CardAnimator.h"

@interface CardAnimator ()
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) BOOL presenting;
@property (nonatomic, assign) CGRect originalFrame;
@end

@implementation CardAnimator

- (instancetype)init {
    if (self = [super init]) {
        _duration = 1.0;
        _presenting = YES;
        _originalFrame = CGRectZero;
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
    
}

@end
