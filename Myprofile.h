//
//  Myprofile.h
//  Paylite HRMS
//
//  Created by Sandipan on 15/06/17.
//  Copyright © 2017 SANDIPAN. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "AppDelegate.h"
@class AppDelegate;

#import "DownloadDcouments.h"

@interface Myprofile : UIViewController
{
    UIView *loadingCircle;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tabvProfile;
-(IBAction)pressLogout:(id)sender;

@end
