//
//  SCTeamSelectorViewController.m
//  SoccerCoach
//
//  Created by BJ on 8/9/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import "SCTeamSelectorViewController.h"
//#import "SCNewTeamViewController.h"
#import "SCTeamBubbleView.h"
#import "SCAddTeamView.h"

#define TEAM_BUBBLE_MARGIN_BETWEEN 50

#define TEAM_BUBBLE_FRAME_HEIGHT 200
#define TEAM_BUBBLE_FRAME_HALF_HEIGHT (TEAM_BUBBLE_FRAME_HEIGHT / 2)

#define TEAM_BUBBLE_FRAME_WIDTH 200
#define TEAM_BUBBLE_FRAME_HALF_WIDTH (TEAM_BUBBLE_FRAME_WIDTH / 2)

#define TEAM_BUBBLE_FRAME_WIDTH_WITH_MARGIN (TEAM_BUBBLE_FRAME_WIDTH + TEAM_BUBBLE_MARGIN_BETWEEN)

@interface SCTeamSelectorViewController ()
@property (nonatomic, retain) NSArray* teams;
@property (nonatomic, retain) UIScrollView* scrollView;
@property (nonatomic, retain) UILabel* mainTitle;
@property (nonatomic, retain) SCAddTeamView* addTeamView;
@end

@implementation SCTeamSelectorViewController

@synthesize teams = _teams;
@synthesize scrollView = _scrollView;
@synthesize mainTitle;
@synthesize addTeamView;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)loadView
{
  [super loadView];
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.navigationController.navigationBar.hidden = YES;

  self.mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 75)];
  self.mainTitle.text = @"// teams";
  self.mainTitle.textAlignment = UITextAlignmentRight;
  self.mainTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  self.mainTitle.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65];
  self.mainTitle.tag = 1;

  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 105, self.view.bounds.size.width, 250)];
  self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//  self.scrollView.backgroundColor = [UIColor blueColor];
  self.scrollView.pagingEnabled = YES;

  UILabel* scheduleTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 375, self.view.bounds.size.width, 75)];
  scheduleTitle.text = @"// upcoming games";
  scheduleTitle.textAlignment = UITextAlignmentRight;
  scheduleTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  scheduleTitle.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65];

  [self.view addSubview:mainTitle];
  [self.view addSubview:self.scrollView];
  [self.view addSubview:scheduleTitle];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
  [self drawTeams];
}

- (void)drawTeams
{
  int pageMultipliedWidth = self.scrollView.bounds.size.width * [self pageCountWithScreenWidth:self.scrollView.bounds.size.width];
  self.scrollView.contentSize = CGSizeMake(pageMultipliedWidth, self.scrollView.bounds.size.height);
  
  NSMutableArray* xCoordinates = [self buildXCoordinates];
  int yValue = (self.scrollView.bounds.size.height / 2) - TEAM_BUBBLE_FRAME_HALF_HEIGHT;

  [self.teams enumerateObjectsUsingBlock:^(id team, NSUInteger index, BOOL *stop) {
    //    NSLog(@"%@ card at index %d", team, index);
    NSNumber* xValue = [xCoordinates objectAtIndex:index];
    CGRect frame = CGRectMake([xValue floatValue], yValue, TEAM_BUBBLE_FRAME_WIDTH, TEAM_BUBBLE_FRAME_HEIGHT);
    SCTeamBubbleView* bubbleView = nil;

    if (index < [self.scrollView.subviews count]) {
      bubbleView = [self.scrollView.subviews objectAtIndex:index];
      bubbleView.frame = frame;
    }

    if (bubbleView == nil) {
      if (team == @"+ add team") {
        bubbleView = [[SCTeamBubbleView alloc] initAsNewTeamButtonWithFrame:frame
                                                         withViewController:self
                                                            withTapSelector:@selector(createTeam:)];
      }
      else {
        bubbleView = [[SCTeamBubbleView alloc] initWithFrame:frame
                                                     andTeam:(NSString*)team];
      }

      [self.scrollView addSubview:bubbleView];
    }
  }];
}

- (NSArray*)teams
{
  if (_teams == nil) {
    NSArray* theTeams = @[
//    @"Real Salt Lake",
    @"+ add team"
    ];
    _teams = theTeams;
  }
  return _teams;
}

- (NSMutableArray*)buildXCoordinates
{
  NSMutableArray* coords = [[NSMutableArray alloc] init];
  int xCenter = self.scrollView.contentSize.width / 2;

  int teamFullWidth = [self calculateTeamWidth];
  int teamFullCenter = teamFullWidth / 2;
  int xOffset = xCenter - teamFullCenter;

  NSLog(@"Building coords for %d teams", [self.teams count]);
  for (int i = 0; i < [self.teams count]; i++) {
    NSNumber* xCoord = [NSNumber numberWithInt:((i * TEAM_BUBBLE_FRAME_WIDTH_WITH_MARGIN) + xOffset)];
    NSLog(@"For index %d Found xCoord %@", i, xCoord);
    [coords addObject:xCoord];
  }

  return coords;
}

- (int)calculateTeamWidth
{
  return ([self.teams count] * TEAM_BUBBLE_FRAME_WIDTH) + (([self.teams count] - 1) * TEAM_BUBBLE_MARGIN_BETWEEN);
}

- (int)pageCountWithScreenWidth:(int)screenWidth
{
  return (int) (floor([self calculateTeamWidth] / screenWidth) + 1);
}

- (void)createTeam:(UITapGestureRecognizer*)tapGesture
{
//  SCNewTeamViewController* vc = [[SCNewTeamViewController alloc] init];
//  [self.navigationController pushViewController:vc animated:YES];
  int frameStartX = self.view.bounds.size.width + 10;
  int frameStartY = self.scrollView.frame.origin.y;
  int frameWidth = self.scrollView.frame.size.width;
  int frameHeight = self.scrollView.frame.size.height;

  self.addTeamView = [[SCAddTeamView alloc] initWithFrame:CGRectMake(frameStartX, frameStartY, frameWidth, frameHeight)];
  self.addTeamView.backgroundColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.7 alpha:1.0f];

  UISwipeGestureRecognizer* swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeAddTeamView:)];
  swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
  [self.addTeamView addGestureRecognizer:swipeGesture];

  [self.view addSubview:self.addTeamView];

  [UIView beginAnimations:@"SlideInAddView" context:NULL];
  [UIView setAnimationDuration:0.35];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

  self.mainTitle.text = @"// add team";
  self.addTeamView.frame = CGRectMake(0, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);

  [UIView commitAnimations];
}

- (void)closeAddTeamView:(UISwipeGestureRecognizer*)swipeGesture
{
  int frameEndX = self.view.bounds.size.width + 10;
  int frameEndY = self.scrollView.frame.origin.y;
  int frameWidth = self.scrollView.frame.size.width;
  int frameHeight = self.scrollView.frame.size.height;

  [UIView beginAnimations:@"SlideOutAddView" context:NULL];
  [UIView setAnimationDuration:0.35];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

  
  self.mainTitle.text = @"// teams";
  self.addTeamView.frame = CGRectMake(frameEndX, frameEndY, frameWidth, frameHeight);

  [UIView commitAnimations];
}

@end
