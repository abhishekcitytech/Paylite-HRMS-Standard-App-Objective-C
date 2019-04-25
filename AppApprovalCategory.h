//
//  AppApprovalCategory.h
//  Paylite HR
//
//  Created by Sandipan on 16/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
@class AppDelegate;

#import "Menu.h"

#import "ApprovalLeave.h"
#import "ApprovalAdvance.h"
#import "ApprovalExpense.h"


@interface AppApprovalCategory : UIViewController
{
    NSMutableArray *arrMAll;
}

@property (strong, nonatomic) IBOutlet UIView *vwH;
@property (strong, nonatomic) IBOutlet UITableView *tabvSubcat;

@property (strong, nonatomic) IBOutlet UIButton *btnSlideMenu;
- (IBAction)pressSlideMenu:(id)sender;
@end
