//
//  SCTeamSelectorViewController.m
//  SoccerCoach
//
//  Created by BJ on 8/9/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import "SCTeamViewController.h"
#import "SCTeamShowView.h"

#define TEAM_BUBBLE_MARGIN_BETWEEN 50

#define TEAM_BUBBLE_FRAME_HEIGHT 200
#define TEAM_BUBBLE_FRAME_HALF_HEIGHT (TEAM_BUBBLE_FRAME_HEIGHT / 2)

#define TEAM_BUBBLE_FRAME_WIDTH 200
#define TEAM_BUBBLE_FRAME_HALF_WIDTH (TEAM_BUBBLE_FRAME_WIDTH / 2)

#define TEAM_BUBBLE_FRAME_WIDTH_WITH_MARGIN (TEAM_BUBBLE_FRAME_WIDTH + TEAM_BUBBLE_MARGIN_BETWEEN)

@implementation SCTeamViewController

@synthesize teams = _teams;
@synthesize scrollView = _scrollView;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)loadView
{
  [super loadView];
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.navigationController.navigationBar.hidden = YES;

  self.mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width - 10, 75)];
  self.mainTitle.text = @"// teams";
  self.mainTitle.textAlignment = UITextAlignmentRight;
  self.mainTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  self.mainTitle.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65];
  self.mainTitle.tag = 1;

  self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 105, self.view.bounds.size.width, 250)];
  self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  self.scrollView.pagingEnabled = YES;

  UILabel *scheduleTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 375, self.view.bounds.size.width - 10, 75)];
  scheduleTitle.text = @"// upcoming games";
  scheduleTitle.textAlignment = UITextAlignmentRight;
  scheduleTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  scheduleTitle.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65];

  UIButton *addTeamButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  addTeamButton.frame=CGRectMake(20, 20, 50, 35);
  addTeamButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [addTeamButton setTitle:@"Add Team" forState:UIControlStateNormal];
  [addTeamButton addTarget:self action:@selector(showNewTeamView:) forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:self.mainTitle];
  [self.view addSubview:self.scrollView];
  [self.view addSubview:scheduleTitle];
  [self.view addSubview:addTeamButton];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
  [self drawTeams];
}

- (void)drawTeams
{
  int pageMultipliedWidth = self.scrollView.bounds.size.width * [self pageCountWithScreenWidth:self.scrollView.bounds.size.width];
  self.scrollView.contentSize = CGSizeMake(pageMultipliedWidth, self.scrollView.bounds.size.height);
  
  NSMutableArray *xCoordinates = [self buildXCoordinatesForTeamViews];
  int yValue = (self.scrollView.bounds.size.height / 2) - TEAM_BUBBLE_FRAME_HALF_HEIGHT;

  NSLog(@"drawing %d teams", [self.teams count]);

  [self.teams enumerateObjectsUsingBlock:^(id team, NSUInteger index, BOOL *stop) {
    //    NSLog(@"%@ card at index %d", team, index);
    NSNumber *xValue = [xCoordinates objectAtIndex:index];
    CGRect frame = CGRectMake([xValue floatValue], yValue, TEAM_BUBBLE_FRAME_WIDTH, TEAM_BUBBLE_FRAME_HEIGHT);
    SCTeamShowView *bubbleView = nil;

    if (index < [self.scrollView.subviews count]) {
      bubbleView = [self.scrollView.subviews objectAtIndex:index];
      bubbleView.frame = frame;
    }

    if (bubbleView == nil) {
      if (team == @"+ add team") {
        bubbleView = [[SCTeamShowView alloc] initAsNewTeamButtonWithFrame:frame
                                                         withViewController:self
                                                            withTapSelector:@selector(showNewTeamView:)];
      }
      else {
        bubbleView = [[SCTeamShowView alloc] initWithFrame:frame
                                                     andTeam:(Team*)team];
      }

      [self.scrollView addSubview:bubbleView];
    }
  }];
}

- (NSArray*)teams
{
  if (_teams == nil) {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Team"];

    NSSortDescriptor *alphaSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:alphaSort];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSError *error = nil;
    _teams = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (_teams == nil) {
      NSLog(@"Fetched teams returned an error: %@", error);
    }
  }
  return _teams;
}

- (NSMutableArray*)buildXCoordinatesForTeamViews
{
  NSMutableArray *coords = [[NSMutableArray alloc] init];
  int xCenter = self.scrollView.contentSize.width / 2;

  int teamFullWidth = [self calculateTeamWidth];
  int teamFullCenter = teamFullWidth / 2;
  int xOffset = xCenter - teamFullCenter;

  NSLog(@"Building coords for %d teams", [self.teams count]);
  for (int i = 0; i < [self.teams count]; i++) {
    NSNumber *xCoord = [NSNumber numberWithInt:((i * TEAM_BUBBLE_FRAME_WIDTH_WITH_MARGIN) + xOffset)];
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

- (void)showNewTeamView:(UITapGestureRecognizer*)tapGesture
{
  int frameStartX = self.view.bounds.size.width + 10;
  int frameStartY = self.scrollView.frame.origin.y;
  int frameWidth = self.scrollView.frame.size.width;
  int frameHeight = self.scrollView.frame.size.height;

  Team *newTeam = (Team*)[NSEntityDescription insertNewObjectForEntityForName:@"Team"
                                                       inManagedObjectContext:self.managedObjectContext];

  CGRect teamFrame = CGRectMake(frameStartX, frameStartY, frameWidth, frameHeight);
  self.teamCreateView = [[SCTeamCreateView alloc] initWithFrame:teamFrame
                                                forTeam:newTeam
                                             completion:^(Team *team) {
                                               [self newTeamSaved:team];
                                             }];
                                        
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(newTeamSaved:)
                                               name:@"teamSaved"
                                             object:self.teamCreateView];

  UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(addTeamViewSwipeClose:)];
  swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
  [self.teamCreateView addGestureRecognizer:swipeGesture];

  [self.view addSubview:self.teamCreateView];

  [UIView beginAnimations:@"SlideInAddView" context:NULL];
  [UIView setAnimationDuration:0.35];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

  self.mainTitle.text = @"// add team";
  self.teamCreateView.frame = CGRectMake(0, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);

  [UIView commitAnimations];
}

- (void)newTeamSaved:(Team*)team
{
  [self closeAddTeamView];

  self.hudAlert = [[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width / 2) - 150, (self.view.bounds.size.width / 2) - 150, 300, 300)];
  self.hudAlert.backgroundColor = [UIColor colorWithWhite:0.33f alpha:1.0f];
//  hudAlert.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//  hudAlert.alpha = 0.0f;

  UILabel *saveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 138, self.hudAlert.frame.size.width, self.hudAlert.frame.size.height)];
  saveLabel.textAlignment = UITextAlignmentCenter;
  saveLabel.backgroundColor = [UIColor blueColor];
  saveLabel.text = @"Team Saved";
  saveLabel.textColor = [UIColor whiteColor];
  saveLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

  [self.hudAlert addSubview:saveLabel];
  [self.view addSubview:self.hudAlert];

  [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(closeHudAlert:) userInfo:nil repeats:NO];
}

- (void)addTeamViewSwipeClose:(UISwipeGestureRecognizer*)swipeGesture
{
  [self closeAddTeamView];
}

- (void)closeAddTeamView
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
  self.teamCreateView.frame = CGRectMake(frameEndX, frameEndY, frameWidth, frameHeight);

  [UIView commitAnimations];
}

- (void)closeHudAlert:(NSTimer*)timer
{
  NSLog(@"closeHudAlert called");
  [self.hudAlert removeFromSuperview];
}

@end
