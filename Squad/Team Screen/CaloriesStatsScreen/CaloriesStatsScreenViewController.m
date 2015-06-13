//
//  CaloriesStatsScreenViewController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/9/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import "CaloriesStatsScreenViewController.h"
#import "AppConstants.h"

@interface CaloriesStatsScreenViewController ()
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *labels;
@end

@implementation CaloriesStatsScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startDrawingLineGraph:) name:@"DrawLineGraph"
                                               object:nil];
    
    [self setupLineChart];
}

- (void)setupLineChart
{
    self.data = @[@100, @150, @200, @150, @170, @100];
    self.labels = @[@"9am", @"10am", @"11am", @"12pm", @"1pm", @"2pm"];
    self.lineGraph.dataSource = self;
    self.lineGraph.lineWidth = 3.0;
    self.lineGraph.valueLabelCount = 4;
    self.lineGraph.lineWidth = 6.0f;
}

#pragma mark - GKLineGraphDataSource

- (NSInteger)numberOfLines
{
    return 1;
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index
{
    return [AppConstants AKPurpleBaseColor];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index
{
    return self.data;
}

- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index {
    return 2.0;
}

- (NSString *)titleForLineAtIndex:(NSInteger)index {
    return [self.labels objectAtIndex:index];
}


#pragma mark - Other

- (void)startDrawingLineGraph:(NSNotification *)notification
{
    [self.lineGraph draw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
