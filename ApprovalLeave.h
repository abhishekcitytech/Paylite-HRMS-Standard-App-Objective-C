//
//  ApprovalLeave.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 21/06/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"
@class AppDelegate;

#import "objLeaveDetails.h"
#import "ApprovalLeaveDetails.h"

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ApprovalLeave : ViewController<NSXMLParserDelegate>
{
    UIView *viewAddcartPopup;
    
    AppDelegate *app56;
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    NSMutableArray *arrMLeaveDetails;
    
    objLeaveDetails *objldt;
    
    UIView *loadingCircle;
    
    UIView *mainBg,*bgVwHeader;
    UIButton *btnDonepdf;
    UIImageView *webvwImgPopup;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tabvApprovalLeave;

@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UIImageView *selected;
@property (strong, nonatomic) IBOutlet UIButton *btnPending;
@property (strong, nonatomic) IBOutlet UIButton *btnRejected;
@property (strong, nonatomic) IBOutlet UIButton *btnApproved;
- (IBAction)pressPending:(id)sender;
- (IBAction)pressRejected:(id)sender;
- (IBAction)pressApproved:(id)sender;



@end
