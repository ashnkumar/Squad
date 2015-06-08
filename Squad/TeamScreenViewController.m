//
//  TeamScreenViewController.m
//  Squad
//
//  Created by Ashwin Kumar on 6/5/15.
//  Copyright (c) 2015 Ashwin Kumar. All rights reserved.
//

#define REUSE_ID @"collectionViewReuse"
const double INITIAL_SCROLL_OFFSET = 40.0;
const double ENDING_SCROLL_OFFSET = 640.0;

#import "TeamScreenViewController.h"

#import "RGCollectionViewCell.h"
#import "AppConstants.h"
#import "TeamScreenDetailViewController.h"
#import "CardAnimator.h"

@interface TeamScreenViewController () <UIViewControllerTransitioningDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *teamMembersList;
@property (strong, nonatomic) NSDictionary *colorMappingDic;

// Card animations
@property (strong, nonatomic) CardAnimator *transition;
@property (assign, nonatomic) CGRect cardOriginalFrame;
@property (assign, nonatomic) CGPoint centerCardPoint;
@property (assign, nonatomic) int currentCenterIndex;
@property (strong, nonatomic) NSIndexPath *centerCardIndexPath;

@end

@implementation TeamScreenViewController

// Ensures that the CardAnimator transition is available as soon as this VC
// is loaded on the storyboard
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _transition = [CardAnimator new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.teamMembersList = [@[@"clearColor", @"lightBlue", @"orange", @"teal", @"pink", @"gold", @"clearColor"] mutableCopy];

    self.colorMappingDic = @{@"clearColor": [UIColor clearColor],
                             @"lightBlue": [AppConstants AKLightBlueColor],
                             @"orange": [AppConstants AKOrangeColor],
                             @"teal": [AppConstants AKTealColor],
                             @"pink": [AppConstants AKPinkColor],
                             @"gold": [AppConstants AKGoldColor] };
    
    
    // Set up card animations
    self.centerCardPoint = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-100);
    self.centerCardIndexPath = [[NSIndexPath alloc] init];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGPoint currentOffset = self.collectionView.contentOffset;
    if (currentOffset.x < INITIAL_SCROLL_OFFSET) {
        [self.collectionView setContentOffset:CGPointMake(INITIAL_SCROLL_OFFSET, 0)];
    }
}

- (IBAction)didTapPresentButton:(id)sender
{

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

#pragma mark - UICollectionView Delegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self calculateCenterIndex];

    // Only the card in the center can be selected
    if ([indexPath isEqual:self.centerCardIndexPath]) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RGCollectionViewCell *cell = (RGCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];

    // Find the original frame for the card (starting off point)
    self.cardOriginalFrame = [self.collectionView convertRect:cell.frame
                                                       toView:self.view];

    // Make the detail view and present it when this card is selected
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TeamScreenDetailViewController *tdvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"TeamScreenDetailView"];
    
    tdvc.transitioningDelegate = self;
    
    [self presentViewController:tdvc animated:YES completion:nil];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Did end decelearting");
    NSLog(@"Offset is: %@", NSStringFromCGPoint(self.collectionView.contentOffset));
    
    [self moveToRightPosition];
    [self calculateCenterIndex];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.x < INITIAL_SCROLL_OFFSET) {
        CGPoint offset = scrollView.contentOffset;
        offset.x = INITIAL_SCROLL_OFFSET;
        scrollView.contentOffset = offset;
    }
    
    else if (scrollView.contentOffset.x > ENDING_SCROLL_OFFSET) {
        CGPoint offset = scrollView.contentOffset;
        offset.x = ENDING_SCROLL_OFFSET;
        scrollView.contentOffset = offset;
    }
    
    else {

        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self moveToRightPosition];
    NSLog(@"didEndDragging");
    NSLog(@"Offset is: %@", NSStringFromCGPoint(self.collectionView.contentOffset));
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    self.transition.originFrame = self.cardOriginalFrame;
    self.transition.presenting = YES;

    return self.transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.transition.originFrame = self.cardOriginalFrame;
    self.transition.presenting = NO;
    return self.transition;
}

#pragma mark - Helpers

- (void)calculateCenterIndex
{
    // Find the indexpath for the card in the center, currently
    self.centerCardIndexPath = [self.collectionView
                                indexPathForItemAtPoint:[self.view convertPoint:self.centerCardPoint
                                                                         toView:self.collectionView]];
}

- (void)moveToRightPosition
{
    int necessaryMultiple = [self calculateNecessaryOffsetMultiple];
    //  @TODO: GENERICIZE:
    CGFloat cardWidth = 150.0;
    CGFloat necessaryOffset = INITIAL_SCROLL_OFFSET + (necessaryMultiple * cardWidth);
    [UIView animateWithDuration:0.2 animations:^{
        [self.collectionView setContentOffset:CGPointMake(necessaryOffset, 0.0) animated:YES];
    }];
    
    
}

- (int)calculateNecessaryOffsetMultiple
{
    CGPoint currentOffset = self.collectionView.contentOffset;
    
//  @TODO: GENERICIZE:
    CGFloat cardWidth = 150.0;

    CGFloat currentOffsetNormalized = currentOffset.x - INITIAL_SCROLL_OFFSET;
    int roundedOffset = lroundf(currentOffsetNormalized/cardWidth);
    return roundedOffset;
}

@end


























