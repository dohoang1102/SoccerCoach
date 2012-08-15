//
//  SCTeamBubbleView.h
//  SoccerCoach
//
//  Created by BJ on 8/10/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"

@interface SCTeamShowView : UIView

- (id)initWithFrame:(CGRect)frame
            andTeam:(Team*)aTeam;

- (id)initAsNewTeamButtonWithFrame:(CGRect)frame
                withViewController:(UIViewController*)viewController
                   withTapSelector:(SEL)tapSelector;

@property (nonatomic, retain) Team *team;
@property (nonatomic,retain) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,retain) UILongPressGestureRecognizer *pressRecognizer;
@property BOOL isNewTeamView;

@end
