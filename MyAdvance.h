//
//  MyAdvance.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 31/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
@class AppDelegate;

#import "objAdvanceDetails.h"

#import "ApplyAdvance.h"

@interface MyAdvance : ViewController<NSXMLParserDelegate>
{
    UIView *viewAddcartPopup;
    
    AppDelegate *app6;
    
    NSMutableArray *arrMAdvanceDetails;
    objAdvanceDetails *objad;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    UIView *loadingCircle;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;
@property (strong, nonatomic) IBOutlet UITableView *tabvAdvance;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnApplyAdvance;
- (IBAction)pressApplyAdvance:(id)sender;

@end
