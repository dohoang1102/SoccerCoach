//
//  SCAddTeamView.h
//  SoccerCoach
//
//  Created by BJ on 8/12/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"

typedef void (^teamBlock) (Team *team);

@interface SCTeamEditView : UIView
@property (nonatomic, retain) Team *team;
@property (nonatomic, retain) UIView *formContainer;
@property (nonatomic, retain) UITextField *nameInput;
@property (nonatomic, retain) UITextField *seasonInput;
@property (nonatomic, retain) UIButton *saveButton;

- (id)initWithFrame:(CGRect)frame
            forTeam:(Team *)aTeam
         completion:(teamBlock) completionBlock;
@end
