//
//  TeamScreenDetailViewController.h
//  Squad
//
//  Created by Ashwin Kumar on 6/6/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VAProgressCircle.h"
#import "UICountingLabel.h"

@interface TeamScreenDetailViewController : UIViewController

// Steps circle
@property (strong, nonatomic) VAProgressCircle *circleChart;
@property int circleProgress;
@property (weak, nonatomic) IBOutlet UICountingLabel *totalStepsLabel;


// Calories chart
@property (weak, nonatomic) IBOutlet UICountingLabel *totalCaloriesLabel;



// bloodGlucoseSection
@property (weak, nonatomic) IBOutlet UICountingLabel *bloodGlucoseLabel;

@end
    