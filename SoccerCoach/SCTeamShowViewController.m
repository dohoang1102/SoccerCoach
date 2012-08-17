//
//  SCTeamShowViewController.m
//  SoccerCoach
//
//  Created by BJ on 8/16/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import "SCTeamShowViewController.h"

@interface SCTeamShowViewController ()

@end

@implementation SCTeamShowViewController

+ (SCTeamShowViewController *)viewControllerWithTeam:(Team *)aTeam
{
  SCTeamShowViewController* showvc = [[SCTeamShowViewController alloc] init];
  showvc.team = aTeam;
  return showvc;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)loadView
{
  [super loadView];

  self.view.backgroundColor = [UIColor whiteColor];

  UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width - 10, 75)];
  title.text = [NSString stringWithFormat:@"// %@", self.team.name];
  title.textAlignment = UITextAlignmentRight;
  title.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  title.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight"
                               size:65];

  UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  backButton.frame=CGRectMake(20, 20, 50, 35);
  backButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [backButton setTitle:@"Back"
              forState:UIControlStateNormal];
  [backButton addTarget:self
                 action:@selector(backToTeamIndex)
       forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:title];
  [self.view addSubview:backButton];
}

- (void)backToTeamIndex
{
  [self.navigationController popViewControllerAnimated:YES];
}

@end
