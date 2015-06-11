//
//  MyTabBarController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/11/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import "MyTabBarController.h"
#import <QuartzCore/QuartzCore.h>

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBarBackground5"];
    self.tabBar.shadowImage = [[UIImage alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
