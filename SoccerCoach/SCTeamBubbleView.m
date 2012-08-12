//
//  SCTeamBubbleView.m
//  SoccerCoach
//
//  Created by BJ on 8/10/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import "SCTeamBubbleView.h"

@implementation SCTeamBubbleView

@synthesize teamName;
@synthesize tapRecognizer;
@synthesize pressRecognizer;

- (id)initWithFrame:(CGRect)frame
            andTeam:(NSString*)name
{
  self = [super initWithFrame:frame];
  
  if (self) {
    self.isNewTeamView = NO;
    self.teamName = name;
    self.backgroundColor = [UIColor clearColor];

    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(handleTapGesture:)];

    self.pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(handleLongPressGesture:)];
    
    [self addGestureRecognizer:tapRecognizer];
    [self addGestureRecognizer:pressRecognizer];

    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ((self.frame.size.height / 2) - 10), self.frame.size.width, 20)];
    nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    nameLabel.textAlignment = UITextAlignmentCenter;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = self.teamName;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    [self addSubview:nameLabel];

  }

  return self;
}

- (id)initAsNewTeamButtonWithFrame:(CGRect)frame
                withViewController:(UIViewController*)viewController
                   withTapSelector:(SEL)tapSelector
{
  self = [self initWithFrame:frame andTeam:@"+ Add Team"];

  if (self) {
    self.isNewTeamView = YES;
    [self removeGestureRecognizer:self.tapRecognizer];

    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:viewController
                                                                 action:tapSelector];
    [self addGestureRecognizer:tapRecognizer];
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

- (void)handleTapGesture:(UITapGestureRecognizer *)tapRecognizer
{
  NSLog(@"received a tap gesture on %@", self.teamName);
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)tapRecognizer
{
  NSLog(@"received a long press gesture on %@", self.teamName);
}

@end
