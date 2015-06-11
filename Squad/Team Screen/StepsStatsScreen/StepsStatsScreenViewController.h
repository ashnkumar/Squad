//
//  StepsStatsScreenViewController.h
//  Squad
//
//  Created by Ashwin Kumar on 6/9/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VAProgressCircle.h"
#import "UICountingLabel.h"

@interface StepsStatsScreenViewController : UIViewController
@property (strong, nonatomic) VAProgressCircle *circleChart;
@property int circleProgress;
@property (weak, nonatomic) IBOutlet UICountingLabel *groupStepsLabel;
@end
