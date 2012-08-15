//
//  Player.h
//  SoccerCoach
//
//  Created by BJ on 8/12/12.
//  Copyright (c) 2012 rand9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GamePlayer;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) GamePlayer *gamesPlayed;
@property (nonatomic, retain) NSManagedObject *team;

@end
