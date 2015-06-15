//
//  StepsStatsScreenViewController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/9/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import "StepsStatsScreenViewController.h"

#import "AppConstants.h"

@interface StepsStatsScreenViewController ()
@property (strong, nonatomic) NSTimer *fillupTimer;
@end

@implementation StepsStatsScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.circleProgress = 0;
    [self setupUI];
    
    [self fillChart];
    [self startStepsCounting];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(countSteps:)
                                                 name:@"StartStepsCounting"
                                               object:nil];
    
}

- (void)setupUI
{
    [self addChart];
    [self addGoalLabel];
    
    self.groupStepsLabel.format = @"%d";
    self.groupStepsLabel.method = UILabelCountingMethodEaseInOut;
    
}

- (void)addChart
{
    self.circleChart = [[VAProgressCircle alloc] initWithFrame:CGRectMake(100, 120, 170, 170)];
    
    [self.circleChart setColor:[AppConstants AKPurpleBaseColor]
            withHighlightColor:[AppConstants AKPurpleBaseColor]];
    
    self.circleChart.circleTransitionColor = [AppConstants AKPurpleBaseColor];
    self.circleChart.accentLineTransitionColor = [AppConstants AKOrangeTextColor];
    self.circleChart.transitionType = VAProgressCircleColorTransitionTypeGradual;
    
    [self.view addSubview:self.circleChart];
    [self.view sendSubviewToBack:self.circleChart];
}

- (void)addGoalLabel
{
    UILabel *goalHeader = [[UILabel alloc] initWithFrame:CGRectMake(166, 180, 38, 21)];
    goalHeader.textAlignment = NSTextAlignmentCenter;
    goalHeader.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:13.0];
    goalHeader.textColor = [AppConstants AKOrangeTextColor];
    goalHeader.text = @"goal:";
    
    UILabel *goalAmount = [[UILabel alloc] initWithFrame:CGRectMake(160, 200, 50, 21)];
    goalAmount.textAlignment = NSTextAlignmentCenter;
    goalAmount.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:13.0];
    goalAmount.textColor = [AppConstants AKOrangeTextColor];
    goalAmount.text = @"50,000";
    
    [self.view insertSubview:goalHeader aboveSubview:self.circleChart];
    [self.view insertSubview:goalAmount aboveSubview:self.circleChart];
}

- (void)resetChart {
    self.circleProgress = 0;
    [self.circleChart removeFromSuperview];
    self.circleChart = nil;
    [self addChart];
}

- (void)fillChart {
//    self.circleProgress = 20;
    self.fillupTimer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                                        target:self
                                                      selector:@selector(fillupIncrement)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)countSteps:(NSNotification *)notification
{
    [self.groupStepsLabel countFrom:0 to:52688 withDuration:1.5f];
    [self resetChart];
    [self fillChart];
}

- (void)startStepsCounting
{
    [self.groupStepsLabel countFrom:0 to:52688 withDuration:1.5f];
}

- (void)fillupIncrement
{
    if(arc4random() % 2 == 1)
    {
        [self addProgress];
    }
}

- (void)addProgress
{
    int randomIncrement = self.circleProgress + arc4random_uniform(91 - self.circleProgress) / 3;
    
    if(self.circleProgress != randomIncrement && randomIncrement > self.circleProgress)
    {
        self.circleProgress = randomIncrement;
        [self.circleChart setProgress:self.circleProgress];
    }
    else
    {
        self.circleProgress++;
        [self.circleChart setProgress:self.circleProgress];
    }
}

@end
