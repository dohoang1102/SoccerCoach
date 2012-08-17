//
//  SCAppDelegate.m
//  SoccerCoach
//
//  Created by BJ on 8/7/12.
//  Copyright (c) 2012 BJ. All rights reserved.
//

#import "SCAppDelegate.h"
#import "SCTeamIndexViewController.h"

@implementation SCAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

// Override point for customization after application launch.
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

	UIWindow *window  =  [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	window.backgroundColor = [UIColor whiteColor];
	self.window = window;

	SCTeamIndexViewController *teamViewController = [[SCTeamIndexViewController alloc] init];
	teamViewController.managedObjectContext = self.managedObjectContext;

	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:teamViewController];
	self.window.rootViewController = navController;

	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		// ipad
	}
	else {
		// iphone
	}

	[self.window makeKeyAndVisible];

	return YES;

//	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//		//
//		// When running an iPad
//		//
//
//		// Cast the window root view controller to a UISplitViewController.
//		UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
//
//		// Find the last viewController assigned and case to UINavicationController.
//		// [QUESTION] is it just me or is this totally hokey?
//		UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
//
//		// Set the split's delegate to the nav's topViewController
//		// [QUESTION] What is the topViewController?
//		splitViewController.delegate = (id)navigationController.topViewController;
//
//		// Grab the first view controller from the split and assign as master nav controller.
//		UINavigationController *masterNavigationController = [splitViewController.viewControllers objectAtIndex:0];
//
//		// Cast the master nav controller's topViewController to our
//		// SCMasterViewController. This is officially our code.
//		SCMasterViewController *controller = (SCMasterViewController *)masterNavigationController.topViewController;
//
//		// Set our managed object context (data model query engine) to
//		// the one returned by this property.
//		controller.managedObjectContext = self.managedObjectContext;
//	}
//	else
//	{
//		//
//		// When running an iPhone
//		//
//
//		// Cast the window root view controller to a nav controller.
//		UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
//
//		// Cast the nav controller's topViewController to our
//		// SCMasterViewController. This is officially our code.
//		SCMasterViewController *controller = (SCMasterViewController *)navigationController.topViewController;
//
//		// Set our managed object context (data model query engine) to
//		// the one returned by this property.
//		controller.managedObjectContext = self.managedObjectContext;
//	}
//
//	return YES;
}

//
// PAUSE - app is still foreground but becomes inactive and is still running.
//
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state.
	// This can occur for certain types of temporary interruptions (such as an
	// incoming phone call or SMS message) or when the user quits the
	// application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down
	// OpenGL ES frame rates. Games should use this method to pause the game.
}

//
// BACKGROUND - used when user leaves to home screen but app still running.
//
- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate
	// timers, and store enough application state information to restore your
	// application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called
	// instead of applicationWillTerminate: when the user quits.
}

//
// FOREGROUND - reverse applicationDidEnterBackground effects.
//
- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state;
	// here you can undo many of the changes made on entering the background.
}

//
// UNPAUSE (ACTIVE) - reverse applicationWillResignActive effects.
//
- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the
	// application was inactive. If the application was previously in the
	// background, optionally refresh the user interface.
}

//
// SHUTDOWN - do stuff before the app closes.
//
- (void)applicationWillTerminate:(UIApplication *)application
{
	// Saves changes in the application's managed object context before the
	// application terminates.
	[self saveContext];
}

//
// Save the changes to the DataModel. This is called from applicationWillTerminate,
// which is called before the app is shut down (not backgrounded).
//
- (void)saveContext
{
	// Setup an error object to populate in the event of a problem.
	NSError *error = nil;

	// Grab the the data model managing context.
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;

	// If the context is preset, and has changes, call save, passing the
	// NSError from above. If the save fails, the if will be invoked
	// and we can act on the error (probably just NSAlert it).
	if (managedObjectContext != nil) {
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort(); // FIXME need to remove and handle the error at the UI
		} 
	}
}

#pragma mark - Core Data stack

//
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the
// persistent store coordinator for the application.
//
- (NSManagedObjectContext *)managedObjectContext
{
	//
	// Is the context already initialized? If so, return it.
	//
	if (_managedObjectContext != nil) {
		return _managedObjectContext;
	}

	//
	// Get a persistence coordinator. I _think_ this is similar to the
	// socket connection to the database.
	//
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];

	if (coordinator != nil) {
		//
		// Allocate a new managed object context. I _think_ this object is
		// in charge of brokering data back and forth between the coordinator (cnxn)
		// and the object model.
		//
		_managedObjectContext = [[NSManagedObjectContext alloc] init];

		//
		// Assign the coordinator to the context.
		//
		[_managedObjectContext setPersistentStoreCoordinator:coordinator];
	}
	return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
	//
	// Is the model already initialized? If so, return it.
	//
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}

	//
	// Make a URL to the main bundle's SoccerCoach.momd file.
	//
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SoccerCoach" withExtension:@"momd"];

	//
	// Allocate the managed object model backed by the momd file.
	//
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];


	return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	if (_persistentStoreCoordinator != nil) {
		return _persistentStoreCoordinator;
	}

	//
	// Make a URL to the documents directory for our sqlite db file.
	//
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SoccerCoach.sqlite"];


	//
	// DELETE THE STORE
	//	[[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
	//
	
	//
	// Pre-create an error in case the creation of the db fails
	//
	NSError *error = nil;

	//
	// Allocate a new coordinator with our initialized object model.
	//
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];


	//
	// Create the storage space for SQLite at the given URL.
	//
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//
		// FIXME need to more graciously fail here.
		//
		abort();
	}
	
	return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

//
// Returns the URL to the application's Documents directory.
//
- (NSURL *)applicationDocumentsDirectory
{
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
