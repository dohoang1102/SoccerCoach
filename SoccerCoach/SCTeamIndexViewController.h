//
//  SCTeamSelectorViewController.h
//  SoccerCoach
//
//  Created by BJ on 8/9/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTeamListScrollView.h"

@interface SCTeamIndexViewController : UIViewController
@property (nonatomic, retain) SCTeamListScrollView *scrollView;
@property (nonatomic, retain) UILabel *mainTitle;
@property (nonatomic, retain) SCTeamEditView *teamCreateView;
@property (nonatomic, retain) UIView *hudAlert;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
