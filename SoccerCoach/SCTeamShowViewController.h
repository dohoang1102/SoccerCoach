//
//  SCTeamShowViewController.h
//  SoccerCoach
//
//  Created by BJ on 8/16/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTeamShowViewController : UIViewController
@property (nonatomic, retain) Team* team;

+ (SCTeamShowViewController *)viewControllerWithTeam:(Team *)aTeam;
@end
