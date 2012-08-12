//
//  SCAddTeamView.m
//  SoccerCoach
//
//  Created by BJ on 8/12/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import "SCAddTeamView.h"

#define TEXT_FIELD_WIDTH 300
#define TEXT_FIELD_HEIGHT 35
#define BUTTON_WIDTH 140
#define INPUT_GAP 15

@implementation SCAddTeamView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];

  if (self) {
//    UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancelButton.frame = CGRectMake(20, 40, 100, 35);
//    cancelButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
//    cancelButton.titleLabel.textAlignment = UITextAlignmentCenter;
//    cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25];
//    [cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
//    [cancelButton setTitleColor:[UIColor colorWithWhite:0.33 alpha:1.0] forState:UIControlStateNormal];
//    [cancelButton addTarget:self action:@selector(handleCancelTap:) forControlEvents:UIControlEventTouchUpInside];

    int formWidth = (TEXT_FIELD_WIDTH + INPUT_GAP + BUTTON_WIDTH);
    int formHeight = (TEXT_FIELD_HEIGHT + INPUT_GAP + TEXT_FIELD_HEIGHT);
    int formX = (frame.size.width / 2) - (formWidth / 2);
    int formY = (frame.size.height / 2) - (formHeight / 2);

    UIView* formContainer = [[UIView alloc] initWithFrame:CGRectMake(formX, formY, formWidth, formHeight)];
    formContainer.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

    UIView* leftPad = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 35)];
    leftPad.backgroundColor = [UIColor clearColor];

    UITextField* nameInput = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT)];
    nameInput.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    nameInput.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    nameInput.placeholder = @"team name";
    nameInput.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25];
    nameInput.leftView = leftPad;
    nameInput.leftViewMode = UITextFieldViewModeAlways;

    UITextField* seasonInput = [[UITextField alloc] initWithFrame:CGRectMake(0, (TEXT_FIELD_HEIGHT + INPUT_GAP), TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT)];
    seasonInput.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    seasonInput.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    seasonInput.placeholder = @"season, like \"fall 2012\"";
    seasonInput.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25];
    seasonInput.leftView = leftPad;
    seasonInput.leftViewMode = UITextFieldViewModeAlways;

    UIButton* saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake((TEXT_FIELD_WIDTH + INPUT_GAP), 0, BUTTON_WIDTH, formHeight);
    saveButton.backgroundColor = [UIColor colorWithWhite:0.80 alpha:1.0];
    saveButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    saveButton.titleLabel.textAlignment = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    saveButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25];
    [saveButton setTitle:@"add" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor colorWithWhite:0.33 alpha:1.0] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(handleSaveTap:) forControlEvents:UIControlEventTouchUpInside];

//    [self addSubview:cancelButton];
    [formContainer addSubview:nameInput];
    [formContainer addSubview:seasonInput];
    [formContainer addSubview:saveButton];
    [self addSubview:formContainer];
  }

  return self;
}

- (void)handleCancelTap:(UIGestureRecognizer *)tapRecognizer
{
  NSLog(@"handleCancelTap called");
//  [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleSaveTap:(UIGestureRecognizer *)tapRecognizer
{
  NSLog(@"handleSaveTap called");
//  [self.navigationController popViewControllerAnimated:YES];
}


@end
