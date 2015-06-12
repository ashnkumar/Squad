//
//  CardSwipeInteractionController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/11/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import "CardSwipeInteractionController.h"

@interface CardSwipeInteractionController()
@property (nonatomic, assign) BOOL shouldCompleteTransition;
@end

@implementation CardSwipeInteractionController

//- (void)wireToViewController:(UIViewController *)viewController
//{
//    NSLog(@"Trying to wire");
//    [self prepareGestureRecognizerInView:viewController.view];
//}

- (void)wireToView:(UIView *)view
{
    NSLog(@"Trying to wire to a view");
    [self prepareGestureRecognizerInView:view];
}

- (void)prepareGestureRecognizerInView:(UIView *)view
{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

- (CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    
    NSLog(@"translation: %@", NSStringFromCGPoint(translation));
    
    if (translation.y < 0) {
        switch (gestureRecognizer.state) {
            case UIGestureRecognizerStateBegan:
                self.interactionInProgress = YES;
                NSLog(@"Began gesture recognizer");
                break;
                
            case UIGestureRecognizerStateChanged:
                NSLog(@"CHANGED GESTURE RECOGNIZER");
                break;
                
            default:
                break;
        }
    }
    
    
}

@end
