//
//  SCTeamSelectorViewController.m
//  SoccerCoach
//
//  Created by BJ on 8/9/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import "SCTeamIndexViewController.h"

@implementation SCTeamIndexViewController

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

  self.scrollView = [[SCTeamListScrollView alloc] initWithFrame:CGRectMake(0, 105, self.view.bounds.size.width, 250)
                                        andManagedObjectContext:self.managedObjectContext];

  self.scrollView.teamTapped = ^(Team* team, UIGestureRecognizer* gesture) {
    NSLog(@"teamtapped block called");
    SCTeamShowViewController* teamvc = [SCTeamShowViewController viewControllerWithTeam:team];
    [self.navigationController pushViewController:teamvc animated:YES];
  };

  self.scrollView.teamLongPressed = ^(Team* team, UIGestureRecognizer* gesture) {
    NSLog(@"teamtapped block called");
    SCTeamShowViewController* teamvc = [SCTeamShowViewController viewControllerWithTeam:team];
    [self.navigationController pushViewController:teamvc animated:YES];
  };

  UILabel *scheduleTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 375, self.view.bounds.size.width - 10, 75)];
  scheduleTitle.text = @"// upcoming games";
  scheduleTitle.textAlignment = UITextAlignmentRight;
  scheduleTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  scheduleTitle.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65];

  UIButton *addTeamButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  addTeamButton.frame=CGRectMake(20, 20, 50, 35);
  addTeamButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [addTeamButton setTitle:@"Add Team" forState:UIControlStateNormal];
  [addTeamButton addTarget:self action:@selector(showTeamEditView:) forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:self.mainTitle];
  [self.view addSubview:self.scrollView];
  [self.view addSubview:scheduleTitle];
  [self.view addSubview:addTeamButton];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
  [self.scrollView drawTeams];
}

- (void)showTeamEditView:(UITapGestureRecognizer*)tapGesture
{
  int frameStartX = self.view.bounds.size.width + 10;
  int frameStartY = self.scrollView.frame.origin.y;
  int frameWidth = self.scrollView.frame.size.width;
  int frameHeight = self.scrollView.frame.size.height;

  Team *newTeam = (Team*)[NSEntityDescription insertNewObjectForEntityForName:@"Team"
                                                       inManagedObjectContext:self.managedObjectContext];

  CGRect teamFrame = CGRectMake(frameStartX, frameStartY, frameWidth, frameHeight);
  self.teamCreateView = [[SCTeamEditView alloc] initWithFrame:teamFrame
                                                        forTeam:newTeam
                                                     completion:^(Team *team) {
                                                       [self teamEditSaved:team];
                                                     }];

  UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(teamEditViewSwipeClose:)];
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

- (void)teamEditSaved:(Team*)team
{
  [self closeTeamEditView];

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

- (void)teamEditViewSwipeClose:(UISwipeGestureRecognizer*)swipeGesture
{
  [self closeTeamEditView];
}

- (void)closeTeamEditView
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
