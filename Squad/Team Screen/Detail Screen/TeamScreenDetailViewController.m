//
//  TeamScreenDetailViewController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/6/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import "TeamScreenDetailViewController.h"

@interface TeamScreenDetailViewController ()

@end

@implementation TeamScreenDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(40, 80, 295, 350);
    
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressDismissButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
