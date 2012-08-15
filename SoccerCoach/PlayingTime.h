//
//  PlayingTime.h
//  SoccerCoach
//
//  Created by BJ on 8/12/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GamePlayer;

@interface PlayingTime : NSManagedObject

@property (nonatomic, retain) NSNumber * pauseDurationInSeconds;
@property (nonatomic, retain) NSDate * start;
@property (nonatomic, retain) NSDate * stop;
@property (nonatomic, retain) GamePlayer *gamePlayer;

@end
