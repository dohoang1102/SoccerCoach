//
//  SCTeamListScrollView.h
//  SoccerCoach
//
//  Created by BJ on 8/16/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTeamEditView.h"
#import "SCTeamPartialView.h"
#import "SCTeamShowViewController.h"
#import "TeamBlocks.h"

@interface SCTeamListScrollView : UIScrollView

  @property (nonatomic, retain) NSArray *teams;
  @property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
  @property (copy) gestureBlock teamTapped;
  @property (copy) gestureBlock teamDoubleTapped;
  @property (copy) gestureBlock teamLongPressed;

  - (id)initWithFrame:(CGRect)frame andManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;
  - (void)drawTeams;

@end
