//
//  SCDetailViewController.m
//  SoccerCoach
//
//  Created by BJ on 8/7/12.
//  Copyright (c) 2012 BJ. All rights reserved.
//

#import "SCDetailViewController.h"

@interface SCDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation SCDetailViewController

#pragma mark - Managing the detail item

/*
 * Takes an Event object and populates the view with it.
 */
- (void)setDetailItem:(id)newDetailItem
{
	if (_detailItem != newDetailItem) {
		_detailItem = newDetailItem;
		[self configureView];
	}

	if (self.masterPopoverController != nil) {
		[self.masterPopoverController dismissPopoverAnimated:YES];
	}
}

/*
 * Update the user interface for the detail item.
 */
- (void)configureView
{
	if (self.detailItem) {
		self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
	}
}

/*
 * View has been loaded.
 */
- (void)viewDidLoad
{
	[super viewDidLoad];
	[self configureView];
}

/*
 * View unloaded. Release any subviews we are managing.
 */
- (void)viewDidUnload
{
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
		return YES;
	}
}

#pragma mark - Split view

/*
 * Popover view controller will take over, so set the "Back" button text
 */
- (void)splitViewController:(UISplitViewController *)splitController
     willHideViewController:(UIViewController *)viewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)popoverController
{
	barButtonItem.title = NSLocalizedString(@"Master", @"Master");
	[self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
	self.masterPopoverController = popoverController;
}

/*
 * Popover controller dismissed, our split comes back into view.
 */
- (void)splitViewController:(UISplitViewController *)splitController
     willShowViewController:(UIViewController *)viewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	// Called when the view is shown again in the split view, invalidating the button and popover controller.
	[self.navigationItem setLeftBarButtonItem:nil animated:YES];
	self.masterPopoverController = nil;
}

@end
