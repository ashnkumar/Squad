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
#import "VAProgressCircle.h"
#import "TTScrollSlidingPagesController.h"
#import "TTSliddingPageDelegate.h"
#import "TTSlidingPage.h"
#import "CaloriesStatsScreenViewController.h"
#import "GlucoseStatsScreenViewController.h"
#import "StepsStatsScreenViewController.h"
#import "DDPageControl.h"

@interface TeamScreenViewController () <UIViewControllerTransitioningDelegate, UICollectionViewDataSource, UICollectionViewDelegate, TTSliddingPageDelegate, TTSlidingPagesDataSource>

// Cards
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *teamMembersList;
@property (strong, nonatomic) NSDictionary *colorMappingDic;

// Card animations
@property (strong, nonatomic) CardAnimator *transition;
@property (assign, nonatomic) CGRect cardOriginalFrame;
@property (assign, nonatomic) CGPoint centerCardPoint;
@property (assign, nonatomic) int currentCenterIndex;
@property (strong, nonatomic) NSIndexPath *centerCardIndexPath;

// Sliding VC
@property (strong, nonatomic) TTScrollSlidingPagesController *slider;
//@property (weak, nonatomic) IBOutlet UIPageControl *myPageControl;
@property (weak, nonatomic) IBOutlet UIPageControl *myPageControl;

@end

@implementation TeamScreenViewController


#pragma mark - UIViewController Lifecycle
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

    [self setupCards];
    [self setupCardAnimations];
    [self setupSlider];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGPoint currentOffset = self.collectionView.contentOffset;
    if (currentOffset.x < INITIAL_SCROLL_OFFSET) {
        [self.collectionView setContentOffset:CGPointMake(INITIAL_SCROLL_OFFSET, 0)];
    }
}

- (void)setupCards
{
    self.teamMembersList = [@[@"clearColor", @"lightBlue", @"orange", @"teal", @"pink", @"gold", @"clearColor"] mutableCopy];
    
    self.colorMappingDic = @{@"clearColor": [UIColor clearColor],
                             @"lightBlue": [AppConstants AKLightBlueColor],
                             @"orange": [AppConstants AKOrangeColor],
                             @"teal": [AppConstants AKTealColor],
                             @"pink": [AppConstants AKPinkColor],
                             @"gold": [AppConstants AKGoldColor] };
}

- (void)setupCardAnimations
{
    self.centerCardPoint = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-100);
    self.centerCardIndexPath = [[NSIndexPath alloc] init];
}

- (void)setupSlider
{
    self.slider = [[TTScrollSlidingPagesController alloc] init];

    // https://github.com/TomThorpe/UIScrollSlidingPages
    self.slider.titleScrollerHidden = YES;
    self.slider.zoomOutAnimationDisabled = YES;
    self.slider.disableUIPageControl = YES;
    
    self.slider.dataSource = self;
    self.slider.delegate = self;
    self.slider.initialPageNumber = 2;
    self.slider.view.frame = CGRectMake(0, 100, self.view.frame.size.width, 350);
    NSLog(@"My frame size width is: %@", NSStringFromCGSize(self.view.frame.size));
    [self.view addSubview:self.slider.view];
    [self addChildViewController:self.slider];
    
    // Add the page control
    self.myPageControl.numberOfPages = 3;
    self.myPageControl.currentPageIndicatorTintColor = [AppConstants AKOrangeTextColor];
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


#pragma mark - TTSlidingPagesDataSource

-(int)numberOfPagesForSlidingPagesViewController:(TTScrollSlidingPagesController *)source{
    return 3; //just return 7 pages as an example
}

-(TTSlidingPage *)pageForSlidingPagesViewController:(TTScrollSlidingPagesController*)source atIndex:(int)index{
    
    UIViewController *viewController;
    
    if (index == 0) {
        viewController = [[StepsStatsScreenViewController alloc] init];
    }
    
    else if (index == 1) {
        viewController = [[CaloriesStatsScreenViewController alloc] init];
    }
    
    else {
        viewController = [[GlucoseStatsScreenViewController alloc] init];
    }
    
    
    return [[TTSlidingPage alloc] initWithContentViewController:viewController];
}

-(TTSlidingPageTitle *)titleForSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index{
    TTSlidingPageTitle *title = nil;
    return title;
}

#pragma mark - TTSlidingPagesDelegate

-(void)didScrollToViewAtIndex:(NSUInteger)index
{
    self.myPageControl.currentPage = index;
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


























