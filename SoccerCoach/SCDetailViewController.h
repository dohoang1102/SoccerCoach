//
//  SCDetailViewController.h
//  SoccerCoach
//
//  Created by BJ on 8/7/12.
//  Copyright (c) 2012 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
