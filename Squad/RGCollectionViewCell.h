//
//  RGCollectionViewCell.h
//  RGPaperLayout
//
//  Created by ROBERA GELETA on 2/25/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGCollectionViewCell : UICollectionViewCell

//@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *cardHeaderBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardStatsLabel;


@end
