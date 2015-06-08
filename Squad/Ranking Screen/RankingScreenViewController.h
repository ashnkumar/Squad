//
//  RankingScreenViewController.h
//  Squad
//
//  Created by Ashwin Kumar on 6/7/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVTableView.h"

@interface RankingScreenViewController : UIViewController <HVTableViewDataSource, HVTableViewDelegate>
@property (weak, nonatomic) IBOutlet HVTableView *rankingTableView;
@end
