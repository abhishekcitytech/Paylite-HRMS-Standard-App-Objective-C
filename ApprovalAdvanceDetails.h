//
//  ApprovalAdvanceDetails.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 21/06/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@class AppDelegate;
#import "objAdvanceDetails.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "MyTextField.h"

#import "ThankYou.h"

@interface ApprovalAdvanceDetails : ViewController<NSXMLParserDelegate>
{
    UIView *viewAddcartPopup;
    
    AppDelegate *app667;
    
    objAdvanceDetails *objadssss;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSString *strAdvanceMsgCode,*strAdvanceMsgText;
    
    int Useraction;
    
    UIView *loadingCircle;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;


@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property(nonatomic,retain)objAdvanceDetails *objadssss;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollAdvance;

@property (strong, nonatomic) IBOutlet MyTextField *txtApplicationDate;
@property (strong, nonatomic) IBOutlet MyTextField *txtEmployeename;
@property (strong, nonatomic) IBOutlet MyTextField *txtAdvancetype;
@property (strong, nonatomic) IBOutlet MyTextField *txtAdvanceamount;
@property (strong, nonatomic) IBOutlet MyTextField *txtNoofinstallment;
@property (strong, nonatomic) IBOutlet MyTextField *txtrepaymentamount;
@property (strong, nonatomic) IBOutlet MyTextField *txtdeductionmonthyear;
@property (strong, nonatomic) IBOutlet UILabel *lblReason;
@property (strong, nonatomic) IBOutlet UITextView *txtvReason;


@property (strong, nonatomic) IBOutlet UIButton *btnApprove;
- (IBAction)pressApprove:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnReject;
- (IBAction)pressReject:(id)sender;

@end
