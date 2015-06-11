//
//  CaloriesStatsScreenViewController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/9/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import "CaloriesStatsScreenViewController.h"
#import "PNChart.h"
#import "AppConstants.h"

@interface CaloriesStatsScreenViewController ()
@property (nonatomic, strong) PNLineChart *lineChart;
@end

@implementation CaloriesStatsScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLineChart];
}

- (void)setupLineChart
{
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(10,  100, 300, 200)];
    [self.lineChart setXLabels:@[@"1", @"2", @"3", @"4", @"5", @"6"]];
    self.lineChart.backgroundColor = [UIColor clearColor];
    self.lineChart.xLabelColor = [UIColor redColor];
    self.lineChart.yLabelColor = [AppConstants AKOrangeTextColor];
    
    NSArray *lineChartData = @[@40.0, @50.0, @60.0, @70.0, @43.4, @56.4];
    PNLineChartData *data = [PNLineChartData new];
    data.color = [AppConstants AKOrangeTextColor];
    data.itemCount = self.lineChart.xLabels.count;
    data.getData = ^(NSUInteger index) {
        CGFloat yValue = [lineChartData[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[data];
    
    
    [self.view addSubview:self.lineChart];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drawLineGraph:(id)sender
{
    [self.lineChart strokeChart];
    
}


@end
