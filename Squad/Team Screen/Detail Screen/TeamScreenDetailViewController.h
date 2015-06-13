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
#import "GraphKit.h"

@interface TeamScreenDetailViewController : UIViewController

@property (strong, nonatomic) UIColor *cardBaseColor;
@property (weak, nonatomic) IBOutlet UIImageView *profileFace;
@property (strong, nonatomic) UIImage *myProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *memberNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberStatusLabel;
@property (strong, nonatomic) NSString *memberName;

// Steps circle
@property (strong, nonatomic) VAProgressCircle *circleChart;
@property int circleProgress;
@property (weak, nonatomic) IBOutlet UICountingLabel *totalStepsLabel;


// Calories chart
@property (weak, nonatomic) IBOutlet UICountingLabel *totalCaloriesLabel;
@property (strong, nonatomic) GKBar *caloriesBarChart;

// bloodGlucoseSection
@property (weak, nonatomic) IBOutlet UICountingLabel *bloodGlucoseLabel;


// Stars
@property (weak, nonatomic) IBOutlet UIButton *stepsStar;
@property (weak, nonatomic) IBOutlet UIButton *caloriesStar;
@property (weak, nonatomic) IBOutlet UIButton *glucoseStar;


@end
    