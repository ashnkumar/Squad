//
//  CaloriesStatsScreenViewController.h
//  Squad
//
//  Created by Ashwin Kumar on 6/9/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphKit.h"

@interface CaloriesStatsScreenViewController : UIViewController <GKLineGraphDataSource>
@property (weak, nonatomic) IBOutlet GKLineGraph *lineGraph;
@end
