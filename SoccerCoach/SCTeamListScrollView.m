//
//  SCTeamListScrollView.m
//  SoccerCoach
//
//  Created by BJ on 8/16/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import "SCTeamListScrollView.h"

#define TEAM_BUBBLE_MARGIN_BETWEEN 50

#define TEAM_BUBBLE_FRAME_HEIGHT 200
#define TEAM_BUBBLE_FRAME_HALF_HEIGHT (TEAM_BUBBLE_FRAME_HEIGHT / 2)

#define TEAM_BUBBLE_FRAME_WIDTH 200
#define TEAM_BUBBLE_FRAME_HALF_WIDTH (TEAM_BUBBLE_FRAME_WIDTH / 2)

#define TEAM_BUBBLE_FRAME_WIDTH_WITH_MARGIN (TEAM_BUBBLE_FRAME_WIDTH + TEAM_BUBBLE_MARGIN_BETWEEN)

@implementation SCTeamListScrollView

@synthesize teams = _teams;

- (id)initWithFrame:(CGRect)frame andManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext
{
  self = [super initWithFrame:frame];
  if (self) {
    self.managedObjectContext = aManagedObjectContext;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.pagingEnabled = YES;
  }
  return self;
}

- (void)drawTeams
{
  [[self subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [obj removeFromSuperview];
  }];
  
  int pageMultipliedWidth = self.bounds.size.width * [self pageCountWithScreenWidth:self.bounds.size.width];
  self.contentSize = CGSizeMake(pageMultipliedWidth, self.bounds.size.height);

  NSMutableArray *xCoordinates = [self buildXCoordinatesForTeamViews];
  int yValue = (self.bounds.size.height / 2) - TEAM_BUBBLE_FRAME_HALF_HEIGHT;

  NSLog(@"drawing %d teams", [self.teams count]);

  [self.teams enumerateObjectsUsingBlock:^(id team, NSUInteger index, BOOL *stop) {
    //    NSLog(@"%@ card at index %d", team, index);
    NSNumber *xValue = [xCoordinates objectAtIndex:index];
    CGRect frame = CGRectMake([xValue floatValue], yValue, TEAM_BUBBLE_FRAME_WIDTH, TEAM_BUBBLE_FRAME_HEIGHT);
    SCTeamPartialView *teamPartial = nil;

    if (index < [self.subviews count]) {
      teamPartial = [self.subviews objectAtIndex:index];
      teamPartial.frame = frame;
    }

    if (teamPartial == nil) {
        teamPartial = [[SCTeamPartialView alloc] initWithFrame:frame
                                                       andTeam:(Team*)team];
      teamPartial.teamTapped = ^(Team* team, UIGestureRecognizer* gesture) {
        NSLog(@"scrollview saw team tap");
        self.teamTapped(team, gesture);
      };

      teamPartial.teamLongPressed = ^(Team* team, UIGestureRecognizer* gesture) {
        NSLog(@"scrollview saw team long press");
        self.teamLongPressed(team, gesture);
      };

      [self addSubview:teamPartial];
    }
  }];
}

- (NSArray*)teams
{
  if (_teams == nil) {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Team"];

    NSSortDescriptor *alphaSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:alphaSort];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSError *error = nil;
    _teams = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (_teams == nil) {
      NSLog(@"Fetched teams returned an error: %@", error);
    }
  }
  return _teams;
}

- (NSMutableArray*)buildXCoordinatesForTeamViews
{
  NSMutableArray *coords = [[NSMutableArray alloc] init];
  int xCenter = self.contentSize.width / 2;

  int teamFullWidth = [self calculateTeamWidth];
  int teamFullCenter = teamFullWidth / 2;
  int xOffset = xCenter - teamFullCenter;

  NSLog(@"Building coords for %d teams", [self.teams count]);
  for (int i = 0; i < [self.teams count]; i++) {
    NSNumber *xCoord = [NSNumber numberWithInt:((i * TEAM_BUBBLE_FRAME_WIDTH_WITH_MARGIN) + xOffset)];
    NSLog(@"For index %d Found xCoord %@", i, xCoord);
    [coords addObject:xCoord];
  }

  return coords;
}

- (int)calculateTeamWidth
{
  return ([self.teams count] * TEAM_BUBBLE_FRAME_WIDTH) + (([self.teams count] - 1) * TEAM_BUBBLE_MARGIN_BETWEEN);
}

- (int)pageCountWithScreenWidth:(int)screenWidth
{
  return (int) (floor([self calculateTeamWidth] / screenWidth) + 1);
}


@end
