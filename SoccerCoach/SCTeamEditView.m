//
//  SCAddTeamView.m
//  SoccerCoach
//
//  Created by BJ on 8/12/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SCTeamEditView.h"

#define TEXT_FIELD_WIDTH 300
#define TEXT_FIELD_HEIGHT 35
#define BUTTON_WIDTH 140
#define INPUT_GAP 15

@interface SCTeamEditView ()

@property (copy,nonatomic) teamBlock completion;

@end

@implementation SCTeamEditView

- (id)initWithFrame:(CGRect)frame forTeam:(Team *)aTeam completion:(teamBlock) completionBlock
{
  self = [super initWithFrame:frame];

  if (self) {
    self.completion = completionBlock;

    self.backgroundColor = [UIColor colorWithRed:0.69
                                           green:0.87
                                            blue:0.94
                                           alpha:1.0f];

    int formWidth = (TEXT_FIELD_WIDTH + INPUT_GAP + BUTTON_WIDTH);
    int formHeight = (TEXT_FIELD_HEIGHT + INPUT_GAP + TEXT_FIELD_HEIGHT);
    int formX = (frame.size.width / 2) - (formWidth / 2);
    int formY = (frame.size.height / 2) - (formHeight / 2);

    self.team = aTeam;

    self.formContainer = [[UIView alloc] initWithFrame:CGRectMake(formX, formY, formWidth, formHeight)];
    self.formContainer.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

    self.nameInput = [self buildTextFieldWithFrame:CGRectMake(0, 0, TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT)
                                andPlaceholderText:@"team name"];
    self.nameInput.text = self.team.name;
    self.seasonInput.text = self.team.season;

    self.seasonInput = [self buildTextFieldWithFrame:CGRectMake(0, (TEXT_FIELD_HEIGHT + INPUT_GAP), TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT)
                                  andPlaceholderText:@"season, like \"fall 2012\""];

    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.frame = CGRectMake((TEXT_FIELD_WIDTH + INPUT_GAP), 0, BUTTON_WIDTH, formHeight);
    self.saveButton.backgroundColor = [UIColor colorWithWhite:0.80
                                                        alpha:1.0];
    self.saveButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    self.saveButton.titleLabel.textAlignment = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.saveButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight"
                                                      size:25];
    [self.saveButton setTitle:@"add" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor colorWithWhite:0.33
                                                     alpha:1.0]
                          forState:UIControlStateNormal];
    [self.saveButton addTarget:self
                        action:@selector(handleSaveTap:)
              forControlEvents:UIControlEventTouchUpInside];

    [self.formContainer addSubview:self.nameInput];
    [self.formContainer addSubview:self.seasonInput];
    [self.formContainer addSubview:self.saveButton];
    [self addSubview:self.formContainer];
  }

  return self;
}

- (UITextField*)buildTextFieldWithFrame:(CGRect)frame
                     andPlaceholderText:(NSString*)placeholderText
{
  UIView *leftPad = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, frame.size.height)];
  leftPad.backgroundColor = [UIColor clearColor];

  UITextField *textField = [[UITextField alloc] initWithFrame:frame];
  textField.leftView = leftPad;
  textField.leftViewMode = UITextFieldViewModeAlways;
  textField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

  textField.backgroundColor = [UIColor colorWithWhite:1.0
                                                alpha:0.8];
  textField.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight"
                                   size:25];
  textField.placeholder = placeholderText;

  return textField;
}

- (void)handleSaveTap:(UIGestureRecognizer *)tapRecognizer
{
  NSLog(@"handleSaveTap called");
  [self endEditing:YES]; // close the keyboard

  // Update the unsaved team
  self.team.name = self.nameInput.text;
  self.team.season = self.seasonInput.text;

  // Save the managed object
  NSError *error = nil;
  if (! [self.team.managedObjectContext save:&error]) {
    NSLog(@"Save failed with error: %@", error);
    [self saveFailedWithError:error];
  }
  else {
    // Invoke the completion block
    self.completion(self.team);
  }
}

// Shake the formContainer to indicate an error occurred.
- (void)saveFailedWithError:(NSError*)error
{
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
  [animation setDuration:0.08];
  [animation setRepeatCount:3];
  [animation setAutoreverses:YES];
  [animation setFromValue:[NSValue valueWithCGPoint:
                           CGPointMake([self.formContainer center].x - 20.0f, [self.formContainer center].y)]];
  [animation setToValue:[NSValue valueWithCGPoint:
                         CGPointMake([self.formContainer center].x + 20.0f, [self.formContainer center].y)]];
  [[self.formContainer layer] addAnimation:animation
                                    forKey:@"position"];
}

@end
