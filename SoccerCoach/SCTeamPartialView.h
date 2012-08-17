//
//  SCTeamBubbleView.h
//  SoccerCoach
//
//  Created by BJ on 8/10/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"

typedef void (^gestureBlock) (Team* team, UIGestureRecognizer* gesture);

@interface SCTeamPartialView : UIView

- (id)initWithFrame:(CGRect)frame
            andTeam:(Team*)aTeam;

- (id)initAsNewTeamButtonWithFrame:(CGRect)frame
                withViewController:(UIViewController*)viewController
                   withTapSelector:(SEL)tapSelector;

@property (nonatomic, retain) Team *team;
@property (nonatomic,retain) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,retain) UILongPressGestureRecognizer *pressRecognizer;
@property (assign) BOOL isNewTeamView;
@property (copy) gestureBlock teamTapped;
@property (copy) gestureBlock teamDoubleTapped;
@property (copy) gestureBlock teamLongPressed;

@end
