//
//  TeamGameSetting.h
//  SoccerCoach
//
//  Created by BJ on 8/12/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Team;

@interface TeamGameSetting : NSManagedObject

@property (nonatomic, retain) NSNumber * numFieldPlayers;
@property (nonatomic, retain) NSNumber * numPeriods;
@property (nonatomic, retain) NSNumber * periodLengthInMinutes;
@property (nonatomic, retain) Team *team;

@end
