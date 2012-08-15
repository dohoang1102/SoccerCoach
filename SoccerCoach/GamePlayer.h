//
//  GamePlayer.h
//  SoccerCoach
//
//  Created by BJ on 8/12/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface GamePlayer : NSManagedObject

@property (nonatomic, retain) NSNumber * goals;
@property (nonatomic, retain) Game *game;
@property (nonatomic, retain) NSManagedObject *player;
@property (nonatomic, retain) NSManagedObject *playingTimes;

@end
