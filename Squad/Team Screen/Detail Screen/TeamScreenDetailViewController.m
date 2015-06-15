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
@property (weak, nonatomic) IBOutlet UIView *detailCardHeaderView;
@property (strong, nonatomic) NSTimer *fillupTimer;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

// Stars
@property (assign, nonatomic) BOOL stepsTakenStarPressed;
@property (assign, nonatomic) BOOL caloriesEatenStarPressed;
@property (assign, nonatomic) BOOL glucoseStarPressed;

@end

@implementation TeamScreenDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.circleProgress = 0;
    
    [self setupUI];
    [self fillCircleChart];
    
    self.stepsTakenStarPressed = NO;
    self.caloriesEatenStarPressed = NO;
    self.glucoseStarPressed = NO;
    
    // Start the filling of the bar chart
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(fillBarChart:)
                                   userInfo:nil
                                    repeats:NO];
    [self setupAllCountingLabels];
    [self startCountingLabels];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(30, 58, 315, 540);
    
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    self.profileFace.image = self.myProfileImage;
    self.memberNameLabel.text = self.memberName;
    
    
    [super viewWillAppear:animated];
}

- (void)setupUI
{
    self.detailCardHeaderView.backgroundColor = self.cardBaseColor;
    [self.closeButton setTitleColor:self.cardBaseColor forState:UIControlStateNormal];
    [self setupStars];
    
    [self addPieChart];
    [self addGoalLabel];
    [self addCaloriesChart];
}

- (void)setupAllCountingLabels
{
    self.totalStepsLabel.format = @"%d";
    self.totalStepsLabel.textColor = self.cardBaseColor;
    
    self.totalCaloriesLabel.format = @"%d";
    self.totalCaloriesLabel.textColor = self.cardBaseColor;
    
    self.bloodGlucoseLabel.format = @"%d";
    self.bloodGlucoseLabel.textColor = self.cardBaseColor;
}

- (void)startCountingLabels
{
    [self.totalStepsLabel countFrom:0 to:11300 withDuration:1.5f];
    [self.totalCaloriesLabel countFrom:0 to:1202 withDuration:1.5f];
    [self.bloodGlucoseLabel countFrom:0 to:127 withDuration:1.5f];
}

- (void)setupStars
{
    [self.stepsStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"] forState:UIControlStateNormal];
    [self.stepsStar setBackgroundImage:[UIImage imageNamed:@"starFilled"] forState:UIControlStateHighlighted];
}

#pragma mark - Pie Chart

- (void)addPieChart
{
    self.circleChart = [[VAProgressCircle alloc] initWithFrame:CGRectMake(20, 200, 120, 120)];
    
    [self.circleChart setColor:self.cardBaseColor
            withHighlightColor:self.cardBaseColor];
    
    self.circleChart.circleTransitionColor = self.cardBaseColor;
    self.circleChart.accentLineTransitionColor = self.cardBaseColor;
    self.circleChart.transitionType = VAProgressCircleColorTransitionTypeGradual;
    
    [self.view addSubview:self.circleChart];
    
}

- (void)addGoalLabel
{
    UILabel *goalHeader = [[UILabel alloc] initWithFrame:CGRectMake(67, 234, 29, 21)];
    goalHeader.textAlignment = NSTextAlignmentCenter;
    goalHeader.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:12.0];
    goalHeader.textColor = self.cardBaseColor;
    goalHeader.text = @"goal:";
    
    UILabel *goalAmount = [[UILabel alloc] initWithFrame:CGRectMake(54, 251, 55, 21)];
    goalAmount.textAlignment = NSTextAlignmentCenter;
    goalAmount.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:12.0];
    goalAmount.textColor = self.cardBaseColor;
    goalAmount.text = @"10,000";
    
    [self.view insertSubview:goalHeader aboveSubview:self.circleChart];
    [self.view insertSubview:goalAmount aboveSubview:self.circleChart];
    
    
    UILabel *caloriesGoalHeader = [[UILabel alloc] initWithFrame:CGRectMake(217, 200, 29, 21)];
    caloriesGoalHeader.textAlignment = NSTextAlignmentCenter;
    caloriesGoalHeader.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:12.0];
    caloriesGoalHeader.textColor = self.cardBaseColor;
    caloriesGoalHeader.text = @"goal:";
    
    UILabel *caloriesGoalAmount = [[UILabel alloc] initWithFrame:CGRectMake(215, 215, 29, 21)];
    caloriesGoalAmount.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:12.0];
    caloriesGoalAmount.textAlignment = NSTextAlignmentCenter;
    caloriesGoalAmount.textColor = self.cardBaseColor;
    caloriesGoalAmount.text = @"2,000";
    
    [self.view addSubview:caloriesGoalHeader];
    [self.view addSubview:caloriesGoalAmount];
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



#pragma mark - Bar Chart

- (void)addCaloriesChart
{
    self.caloriesBarChart = [[GKBar alloc] initWithFrame:CGRectMake(180, 200, 100, 125)];
    self.caloriesBarChart.animated = YES;
    self.caloriesBarChart.foregroundColor = self.cardBaseColor;
    self.caloriesBarChart.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0];
    
    [self.view addSubview:self.caloriesBarChart];
    [self.view sendSubviewToBack:self.caloriesBarChart];
}

- (void)fillBarChart:(id)sender
{
    self.caloriesBarChart.percentage += 60;
}


#pragma mark - Stars

- (IBAction)stepsTakenStarPressed:(id)sender
{
    if (self.stepsTakenStarPressed) {
        self.stepsTakenStarPressed = NO;
        [self.stepsStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"]
                                  forState:UIControlStateNormal];
    }
    
    else {
        self.stepsTakenStarPressed = YES;
        [self.stepsStar setBackgroundImage:[UIImage imageNamed:@"starFilled"]
                                  forState:UIControlStateNormal];
    }
}

- (IBAction)caloriesEatenStarPressed:(id)sender
{
    if (self.caloriesEatenStarPressed) {
        self.caloriesEatenStarPressed = NO;
        [self.caloriesStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"]
                                     forState:UIControlStateNormal];
    }
    
    else {
        self.caloriesEatenStarPressed = YES;
        [self.caloriesStar setBackgroundImage:[UIImage imageNamed:@"starFilled"]
                                     forState:UIControlStateNormal];
    }
    
}

- (IBAction)glucoseStarPressed:(id)sender
{
    if (self.glucoseStarPressed) {
        self.glucoseStarPressed = NO;
        [self.glucoseStar setBackgroundImage:[UIImage imageNamed:@"starUnfilled"]
                                    forState:UIControlStateNormal];
    }
    
    else {
        self.glucoseStarPressed = YES;
        [self.glucoseStar setBackgroundImage:[UIImage imageNamed:@"starFilled"]
                                    forState:UIControlStateNormal];
    }
    
}




#pragma mark - Other

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressDismissButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
