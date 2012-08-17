//
//  SCTeamBubbleView.h
//  SoccerCoach
//
//  Created by BJ on 8/10/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"
#import "TeamBlocks.h"

@interface SCTeamPartialView : UIView

- (id)initWithFrame:(CGRect)frame
            andTeam:(Team*)aTeam;

@property (nonatomic, retain) Team *team;
@property (assign) BOOL isNewTeamView;

@property (copy) gestureBlock teamTapped;
@property (copy) gestureBlock teamDoubleTapped;
@property (copy) gestureBlock teamLongPressed;


@end
