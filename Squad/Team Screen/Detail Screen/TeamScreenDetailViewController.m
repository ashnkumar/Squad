//
//  TeamScreenDetailViewController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/6/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import "TeamScreenDetailViewController.h"

#import "AppConstants.h"

@interface TeamScreenDetailViewController ()
@property (strong, nonatomic) NSTimer *fillupTimer;
@end

@implementation TeamScreenDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.circleProgress = 0;
    
    [self setupUI];
    [self fillCircleChart];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(30, 58, 315, 540);
    
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    
    [super viewWillAppear:animated];
}

- (void)setupUI
{
    [self addChart];
    [self addGoalLabel];
}

- (void)addChart
{
    self.circleChart = [[VAProgressCircle alloc] initWithFrame:CGRectMake(20, 200, 120, 120)];
    
    [self.circleChart setColor:[AppConstants CardsDarkOrangeTextColor]
            withHighlightColor:[AppConstants CardsDarkOrangeTextColor]];
    
    self.circleChart.circleTransitionColor = [AppConstants CardsDarkOrangeTextColor];
    self.circleChart.accentLineTransitionColor = [AppConstants CardsDarkOrangeTextColor];
    self.circleChart.transitionType = VAProgressCircleColorTransitionTypeGradual;
    
    [self.view addSubview:self.circleChart];
    
}

- (void)addGoalLabel
{
    UILabel *goalHeader = [[UILabel alloc] initWithFrame:CGRectMake(67, 234, 29, 21)];
    goalHeader.textAlignment = NSTextAlignmentCenter;
    goalHeader.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:12.0];
    goalHeader.textColor = [AppConstants CardsDarkOrangeTextColor];
    goalHeader.text = @"goal:";
    
    UILabel *goalAmount = [[UILabel alloc] initWithFrame:CGRectMake(54, 251, 55, 21)];
    goalAmount.textAlignment = NSTextAlignmentCenter;
    goalAmount.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:12.0];
    goalAmount.textColor = [AppConstants CardsDarkOrangeTextColor];
    goalAmount.text = @"10,000";
    
    [self.view insertSubview:goalHeader aboveSubview:self.circleChart];
    [self.view insertSubview:goalAmount aboveSubview:self.circleChart];
}


- (void)fillCircleChart
{
    self.fillupTimer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                                        target:self
                                                      selector:@selector(fillupIncrement)
                                                      userInfo:nil
                                                       repeats:YES];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressDismissButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
