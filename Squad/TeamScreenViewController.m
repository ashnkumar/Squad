//
//  TeamScreenViewController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/5/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#define REUSE_ID @"collectionViewReuse"

#import "TeamScreenViewController.h"

#import "RGCollectionViewCell.h"
#import "AppConstants.h"

@interface TeamScreenViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *teamMembersList;
@property (strong, nonatomic) NSDictionary *colorMappingDic;

@end

@implementation TeamScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.teamMembersList = [@[@"lightBlue", @"orange", @"teal", @"pink", @"gold"] mutableCopy];

    self.colorMappingDic = @{@"lightBlue": [AppConstants AKLightBlueColor],
                             @"orange": [AppConstants AKOrangeColor],
                             @"teal": [AppConstants AKTealColor],
                             @"pink": [AppConstants AKPinkColor],
                             @"gold": [AppConstants AKGoldColor] };
    
}

#pragma mark - UICollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.teamMembersList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
              cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_ID forIndexPath:indexPath];
    [self configureCell:cell forItemAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(RGCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *nameOfImage = self.teamMembersList[indexPath.section];
    cell.backgroundColor = (UIColor *)self.colorMappingDic[nameOfImage];
}

@end
