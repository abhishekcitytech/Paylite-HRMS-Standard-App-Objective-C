//
//  ApprovalAdvance.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 21/06/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "AppDelegate.h"
@class AppDelegate;
#import "objAdvanceDetails.h"

#import "ApprovalAdvanceDetails.h"


@interface ApprovalAdvance : ViewController<NSXMLParserDelegate>
{
    UIView *viewAddcartPopup;
    
    AppDelegate *app57;
    
    NSMutableArray *arrMAdvanceDetails;
    objAdvanceDetails *objad;
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    UIView *loadingCircle;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tabvApprovalAdvance;


@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UIImageView *selected;
@property (strong, nonatomic) IBOutlet UIButton *btnPending;
@property (strong, nonatomic) IBOutlet UIButton *btnRejected;
@property (strong, nonatomic) IBOutlet UIButton *btnApproved;
- (IBAction)pressPending:(id)sender;
- (IBAction)pressRejected:(id)sender;
- (IBAction)pressApproved:(id)sender;


@end
