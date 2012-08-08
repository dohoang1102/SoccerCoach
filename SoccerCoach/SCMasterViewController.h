//
//  SCMasterViewController.h
//  SoccerCoach
//
//  Created by BJ on 8/7/12.
//  Copyright (c) 2012 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCDetailViewController;

#import <CoreData/CoreData.h>

@interface SCMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) SCDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
