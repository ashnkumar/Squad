//
//  CardAnimator.h
//  Squad
//
//  Created by Ashwin Kumar on 6/6/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CardAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) BOOL presenting;
@property (nonatomic, assign) CGRect originFrame;

@end
