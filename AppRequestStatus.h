//
//  AppRequestStatus.h
//  Paylite HR
//
//  Created by Sandipan on 13/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
@class AppDelegate;

#import "Menu.h"

#import "MyLeave.h"
#import "MyAdvance.h"
#import "MyExpenseClaim.h"
#import "ChangeProfile.h"

@interface AppRequestStatus : UIViewController
{
    NSMutableArray *arrMAll;
}

@property (strong, nonatomic) IBOutlet UIView *vwH;
@property (strong, nonatomic) IBOutlet UITableView *tabvSubcat;

@property (strong, nonatomic) IBOutlet UIButton *btnSlideMenu;
- (IBAction)pressSlideMenu:(id)sender;

@end
