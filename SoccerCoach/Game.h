//
//  Game.h
//  SoccerCoach
//
//  Created by BJ on 8/12/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Game : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * goalsAgainst;
@property (nonatomic, retain) NSNumber * goalsFor;
@property (nonatomic, retain) NSNumber * isEnded;
@property (nonatomic, retain) NSNumber * isStarted;
@property (nonatomic, retain) NSNumber * numFieldPlayers;
@property (nonatomic, retain) NSNumber * numPeriods;
@property (nonatomic, retain) NSNumber * periodLengthInMinutes;
@property (nonatomic, retain) NSManagedObject *gamePlayers;
@property (nonatomic, retain) NSManagedObject *team;

@end
