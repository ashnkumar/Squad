//
//  RankingScreenViewController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/7/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#define CELL_REUSE_ID @"rankingCell"
#define STATS_HEADER_LABEL_FONT @"Ubuntu-Light";
#define STATS_MINI_HEADER_LABEL_FONT @"UbuntuCondensed-Regular";
const float STATS_HEADER_LABEL_FONT_SIZE = 20.0;
const float STATS_MINI_HEADER_LABEL_FONT_SIZE = 15.0;


#import "RankingScreenViewController.h"

#import "RankingTableViewCell.h"
#import "AppConstants.h"

@interface RankingScreenViewController ()
@property (nonatomic, strong) NSMutableArray *allTeams;
@property (nonatomic, strong) NSArray *allTeamInfo;
@end

@implementation RankingScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allTeams = [@[@"KAYE'S SQUAD", @"THE DAYES", @"PYE  & CO", @"ROBINS", @"OTRIES", @"BOBBY", @"SHWINS TEAM"] mutableCopy];
    
    NSArray *teamInfo1 = @[[UIImage imageNamed:@"teamPic1"], @125, @55445, @222];
    NSArray *teamInfo2 = @[[UIImage imageNamed:@"teamPic2"], @122, @50445, @202];
    NSArray *teamInfo3 = @[[UIImage imageNamed:@"teamPic3"], @115, @45445, @192];
    NSArray *teamInfo4 = @[[UIImage imageNamed:@"teamPic4"], @145, @25445, @322];
    NSArray *teamInfo5 = @[[UIImage imageNamed:@"teamPic5"], @125, @55445, @422];
    NSArray *teamInfo6 = @[[UIImage imageNamed:@"teamPic6"], @135, @15425, @542];
    NSArray *teamInfo7 = @[[UIImage imageNamed:@"teamPic7"], @126, @10445, @852];
    
    self.allTeamInfo = @[teamInfo1, teamInfo2, teamInfo3, teamInfo4, teamInfo5, teamInfo6, teamInfo7];
    
    self.rankingTableView.HVTableViewDataSource = self;
    self.rankingTableView.HVTableViewDelegate = self;
    self.rankingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rankingTableView.backgroundColor = [UIColor colorWithRed:140/255.0
                                                            green:140/255.0
                                                             blue:140/255.0 alpha:1.0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)magicButtonPressed:(id)sender
{
//    NSIndexPath *indexPath0 = [NSIndexPath indexPathForItem:0 inSection:0];
//    NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:1 inSection:0];
//
//    [self.rankingTableView moveRowAtIndexPath:indexPath1 toIndexPath:indexPath0];
//    
//    RankingTableViewCell *cell0 = (RankingTableViewCell *)[self.rankingTableView
//                                                           cellForRowAtIndexPath:indexPath0];
//    
//    RankingTableViewCell *cell1 = (RankingTableViewCell *)[self.rankingTableView
//                                                           cellForRowAtIndexPath:indexPath1];
//    cell0.teamRankingLabel.text = @"1";
//    cell1.teamRankingLabel.text = @"2";
    
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTeams.count;
}


#pragma mark - HVTableView DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
          isExpanded:(BOOL)isExpanded
{
    if (isExpanded) {
        return 285.0;
    }
    
    else {
        return 97.0;
    }
}

- (RankingTableViewCell *)tableView:(UITableView *)tableView
              cellForRowAtIndexPath:(NSIndexPath *)indexPath
                         isExpanded:(BOOL)isExpanded {
    
    static NSString* cellIdentifier = CELL_REUSE_ID;
    
    RankingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[RankingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [self configureCell:cell withIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(RankingTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    NSArray *teamInfoArray = [self.allTeamInfo objectAtIndex:indexPath.row];
    
    cell.teamNameLabel.text = self.allTeams[indexPath.row];
    cell.teamRankingLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    cell.teamImageView.image = (UIImage *)teamInfoArray[0];
    
    // Gradient for the background
    int baseColorRGB = 140;
    int modifiedColor = baseColorRGB + (indexPath.row * 15);
    cell.contentView.backgroundColor = [UIColor colorWithRed:modifiedColor/255.0
                                                       green:modifiedColor/255.0
                                                        blue:modifiedColor/255.0 alpha:1.0];
}

-(void)tableView:(UITableView *)tableView
      expandCell:(UITableViewCell*)cell
   withIndexPath:(NSIndexPath*)indexPath
{
    NSArray *teamInfoArray = self.allTeamInfo[indexPath.row];
    
    // Icons
    UIImageView *glucoseDropIcon = [[UIImageView alloc] initWithFrame:CGRectMake(69, 106, 15, 32)];
    glucoseDropIcon.image = [UIImage imageNamed:@"glucoseIcon2"];
    [cell.contentView addSubview:glucoseDropIcon];
    
    UIImageView *shoeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(62, 162, 32, 26)];
    shoeIcon.image = [UIImage imageNamed:@"shoeIcon2"];
    [cell.contentView addSubview:shoeIcon];
    
    UIImageView *forkIcon = [[UIImageView alloc] initWithFrame:CGRectMake(71, 216, 12, 35)];
    forkIcon.image = [UIImage imageNamed:@"forkIcon2"];
    [cell.contentView addSubview:forkIcon];
    
    // Heading Labels
    UILabel *glucoseHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 100, 100, 21)];
    glucoseHeaderLabel.text = @"Glucose";
    glucoseHeaderLabel.textColor = [AppConstants AKPurpleBaseColor];
    glucoseHeaderLabel.font = [UIFont fontWithName:@"Ubuntu-Light" size:STATS_HEADER_LABEL_FONT_SIZE];
    [cell.contentView addSubview:glucoseHeaderLabel];
    
    UILabel *stepsHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 156, 100, 20)];
    stepsHeaderLabel.text = @"Steps";
    stepsHeaderLabel.textColor = [AppConstants AKPurpleBaseColor];
    stepsHeaderLabel.font = [UIFont fontWithName:@"Ubuntu-Light" size:STATS_HEADER_LABEL_FONT_SIZE];
    [cell.contentView addSubview:stepsHeaderLabel];
    
    UILabel *caloriesHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 209, 100, 23)];
    caloriesHeaderLabel.text = @"Calories";
    caloriesHeaderLabel.textColor = [AppConstants AKPurpleBaseColor];
    caloriesHeaderLabel.font = [UIFont fontWithName:@"Ubuntu-Light" size:STATS_HEADER_LABEL_FONT_SIZE];
    [cell.contentView addSubview:caloriesHeaderLabel];
    
    // Mini-heading labels
    UILabel *avgGlucoseLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 120, 124, 23)];
    avgGlucoseLabel.text = @"average glucose level:";
    avgGlucoseLabel.textColor = [AppConstants AKBaseGrayColor];
    avgGlucoseLabel.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:STATS_MINI_HEADER_LABEL_FONT_SIZE];
    [cell.contentView addSubview:avgGlucoseLabel];
    
    UILabel *stepsTakenLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 176, 87, 17)];
    stepsTakenLabel.text = @"steps taken:";
    stepsTakenLabel.textColor = [AppConstants AKBaseGrayColor];
    stepsTakenLabel.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:STATS_MINI_HEADER_LABEL_FONT_SIZE];
    [cell.contentView addSubview:stepsTakenLabel];
    
    UILabel *caloriesLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 230, 125, 17)];
    caloriesLabel.text = @"average kCal per meal:";
    caloriesLabel.textColor = [AppConstants AKBaseGrayColor];
    caloriesLabel.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:STATS_MINI_HEADER_LABEL_FONT_SIZE];
    [cell.contentView addSubview:caloriesLabel];
    
    // Purple stats labels
    UILabel *glucoseStatsLabel = [[UILabel alloc] initWithFrame:CGRectMake(248, 120, 126, 23)];
    glucoseStatsLabel.text = [NSString stringWithFormat:@"%@", (NSString *)teamInfoArray[1]];
    glucoseStatsLabel.textColor = [UIColor whiteColor];
    glucoseStatsLabel.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:STATS_MINI_HEADER_LABEL_FONT_SIZE];
    [cell.contentView addSubview:glucoseStatsLabel];
    
    UILabel *stepsStatsLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 174, 126, 23)];
    stepsStatsLabel.text = [NSString stringWithFormat:@"%@", (NSString *)teamInfoArray[2]];
    stepsStatsLabel.textColor = [UIColor whiteColor];
    stepsStatsLabel.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:STATS_MINI_HEADER_LABEL_FONT_SIZE];
    [cell.contentView addSubview:stepsStatsLabel];
    
    UILabel *calsStatsLabel = [[UILabel alloc] initWithFrame:CGRectMake(253, 228, 126, 23)];
    calsStatsLabel.text = [NSString stringWithFormat:@"%@", (NSString *)teamInfoArray[3]];
    calsStatsLabel.textColor = [UIColor whiteColor];
    calsStatsLabel.font = [UIFont fontWithName:@"UbuntuCondensed-Regular" size:STATS_MINI_HEADER_LABEL_FONT_SIZE];
    [cell.contentView addSubview:calsStatsLabel];
    
    
    
}

-(void)tableView:(UITableView *)tableView
    collapseCell:(UITableViewCell*)cell
   withIndexPath:(NSIndexPath*)indexPath
{
    
    if ([cell.contentView subviews]){
        for (UIView *subview in [cell.contentView subviews]) {
            if (!subview.tag) {
                [subview removeFromSuperview];
            }
        }
    }
}

@end
