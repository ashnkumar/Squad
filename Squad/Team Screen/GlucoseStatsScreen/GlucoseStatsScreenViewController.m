//
//  GlucoseStatsScreenViewController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/9/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import "GlucoseStatsScreenViewController.h"

@interface GlucoseStatsScreenViewController ()

@end

@implementation GlucoseStatsScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.teamsCurrentGlucose.format = @"%d";
    self.teamsCurrentGlucose.method = UILabelCountingMethodEaseInOut;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startGlucoseStatsCounting:) name:@"GlucoseStatsCountup"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startGlucoseStatsCounting:(NSNotification *)notification
{
    [self.teamsCurrentGlucose countFrom:0 to:125 withDuration:1.5f];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
