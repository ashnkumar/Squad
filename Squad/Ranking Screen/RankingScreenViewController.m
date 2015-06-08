//
//  RankingScreenViewController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/7/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#define CELL_REUSE_ID @"rankingCell"

#import "RankingScreenViewController.h"

#import "RankingTableViewCell.h"
#import "AppConstants.h"

@interface RankingScreenViewController ()
@property (nonatomic, strong) NSMutableArray *allTeams;
@end

@implementation RankingScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allTeams = [@[@"KAYE'S SQUAD", @"THE DAYES", @"PYE  & CO", @"ROBINS", @"OTRIES", @"BOBBY", @"SHWINS TEAM"] mutableCopy];
    
    self.rankingTableView.HVTableViewDataSource = self;
    self.rankingTableView.HVTableViewDelegate = self;
    self.rankingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rankingTableView.backgroundColor = [AppConstants AKBaseGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.teamNameLabel.text = self.allTeams[indexPath.row];
    cell.teamRankingLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    cell.teamImageView.image = [UIImage imageNamed:@"teamPic"];
    
    // Gradient for the background
    int baseColorRGB = 57;
    int modifiedColor = baseColorRGB + (indexPath.row * 15);
    cell.contentView.backgroundColor = [UIColor colorWithRed:modifiedColor/255.0
                                                       green:modifiedColor/255.0
                                                        blue:modifiedColor/255.0 alpha:1.0];
}

-(void)tableView:(UITableView *)tableView
      expandCell:(UITableViewCell*)cell
   withIndexPath:(NSIndexPath*)indexPath
{
//    UIImageView *glucoseDropIcon = [UIImageView alloc] initWithFrame:CGRectMake(65, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}

-(void)tableView:(UITableView *)tableView
    collapseCell:(UITableViewCell*)cell
   withIndexPath:(NSIndexPath*)indexPath
{
    
}

@end
