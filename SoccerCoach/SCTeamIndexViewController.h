//
//  SCTeamSelectorViewController.h
//  SoccerCoach
//
//  Created by BJ on 8/9/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTeamCreateView.h"

@interface SCTeamIndexViewController : UIViewController
@property (nonatomic, retain) NSArray *teams;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UILabel *mainTitle;
@property (nonatomic, retain) SCTeamCreateView *teamCreateView;
@property (nonatomic, retain) UIView *hudAlert;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
