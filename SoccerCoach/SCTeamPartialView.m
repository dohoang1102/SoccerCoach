//
//  SCTeamBubbleView.m
//  SoccerCoach
//
//  Created by BJ on 8/10/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import "SCTeamPartialView.h"

@implementation SCTeamPartialView

@synthesize team;

- (id)initWithFrame:(CGRect)frame
            andTeam:(Team*)aTeam
{
  self = [super initWithFrame:frame];

  if (self) {
    team = aTeam;
    self.isNewTeamView = NO;
    self.backgroundColor = [UIColor clearColor];

    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTapGesture:)];
    
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleDoubleTapGesture:)];
    doubleTap.numberOfTapsRequired = 2;
    
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handleLongPressGesture:)];

    [tap requireGestureRecognizerToFail:longPress];
    [tap requireGestureRecognizerToFail:doubleTap];

    [self addGestureRecognizer:tap];
    [self addGestureRecognizer:doubleTap];
    [self addGestureRecognizer:longPress];

    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ((self.frame.size.height / 2) - 10), self.frame.size.width, 20)];
    nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    nameLabel.textAlignment = UITextAlignmentCenter;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = team.name;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                     size:18];

    UILabel *seasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLabel.frame.origin.y + 25, self.frame.size.width, 20)];
    seasonLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    seasonLabel.textAlignment = UITextAlignmentCenter;
    seasonLabel.backgroundColor = [UIColor clearColor];
    seasonLabel.text = team.season;
    seasonLabel.textColor = [UIColor grayColor];
    seasonLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight"
                                       size:14];

    [self addSubview:nameLabel];
    [self addSubview:seasonLabel];
  }

  return self;
}

- (void)drawRect:(CGRect)rect
{
  CGContextRef ctx = UIGraphicsGetCurrentContext();


  // Set stroke width and color.
  CGContextSetLineWidth(ctx, 3);

  if (self.isNewTeamView) {
    // adjust the Rect size/origin so the stroke isn't clipped.
    float oldWidth = rect.size.width;
    float oldHeight = rect.size.height;
    float newWidth = rect.size.width * 0.7;
    float newHeight = rect.size.height * 0.7;
    rect.size = CGSizeMake(newWidth, newHeight);
    rect.origin.x += (oldWidth - newWidth) / 2;
    rect.origin.y += (oldHeight - newHeight) / 2;

    // Setup an ellipse in rect.
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetStrokeColor(ctx, CGColorGetComponents([[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0] CGColor]));
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0] CGColor]));
  }
  else {
    // adjust the Rect size/origin so the stroke isn't clipped.
    rect.size = CGSizeMake(rect.size.width - 6, rect.size.height - 6);
    rect.origin.x += 3;
    rect.origin.y += 3;

    // Setup an ellipse in rect.
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetStrokeColor(ctx, CGColorGetComponents([[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.3] CGColor]));
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.1] CGColor]));
  }

  // Draw all the things.
  CGContextDrawPath(ctx, kCGPathFillStroke);
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tap
{
  NSLog(@"received a tap gesture on %@", team.name);
  if (self.teamTapped != nil) {
    self.teamTapped(self.team, tap);
  }
}

- (void)handleDoubleTapGesture:(UITapGestureRecognizer *)doubleTap
{
  NSLog(@"received a double tap gesture on %@", team.name);
  if (self.teamDoubleTapped != nil) {
    self.teamDoubleTapped(self.team, doubleTap);
  }
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)press
{
  NSLog(@"received a long press gesture on %@", team.name);
  if (self.teamLongPressed != nil) {
    self.teamLongPressed(self.team, press);
  }
}

@end
