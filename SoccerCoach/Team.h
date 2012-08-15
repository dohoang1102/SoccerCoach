//
//  Team.h
//  SoccerCoach
//
//  Created by BJ on 8/12/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game, Player;

@interface Team : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * season;
@property (nonatomic, retain) Game *games;
@property (nonatomic, retain) Player *players;
@property (nonatomic, retain) NSManagedObject *teamGameSettings;

@end
