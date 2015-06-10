//
//  GlucoseStatsScreenViewController.h
//  Squad
//
//  Created by Ashwin Kumar on 6/9/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"

@interface GlucoseStatsScreenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICountingLabel *teamsCurrentGlucose;

- (void)startGlucoseStatsCounting;
@end
