//
//  ApprovalExpense.h
//  Paylite HR
//
//  Created by Sandipan on 10/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class AppDelegate;

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "objExpenseDetails.h"

#import "ApprovalExpenseDetails.h"

@interface ApprovalExpense : UIViewController<NSXMLParserDelegate>
{
    UIView *viewAddcartPopup;
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSMutableArray *arrMExpenseDetails;
    objExpenseDetails *objexp;
    
    UIView *loadingCircle;
    
    UIView *mainBg,*bgVwHeader;
    UIButton *btnDonepdf;
    UIImageView *webvwImgPopup;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tabvApprovalExpense;

@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UIImageView *selected;
@property (strong, nonatomic) IBOutlet UIButton *btnPending;
@property (strong, nonatomic) IBOutlet UIButton *btnRejected;
@property (strong, nonatomic) IBOutlet UIButton *btnApproved;
- (IBAction)pressPending:(id)sender;
- (IBAction)pressRejected:(id)sender;
- (IBAction)pressApproved:(id)sender;


@end
