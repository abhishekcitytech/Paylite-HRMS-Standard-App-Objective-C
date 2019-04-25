//
//  MyLeave.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 30/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
@class AppDelegate;

#import "objLeaveDetails.h"
#import "ApplyLeave.h"


@interface MyLeave : ViewController<NSXMLParserDelegate>
{
    UIView *viewAddcartPopup;
    
    AppDelegate *app5;
    
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
@property (strong, nonatomic) IBOutlet UITableView *tabvLeave;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnApplyLeave;
- (IBAction)pressApplyLeave:(id)sender;


@end
