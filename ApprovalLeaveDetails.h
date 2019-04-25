//
//  ApprovalLeaveDetails.h
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
#import "objLeaveDetails.h"
#import "MyTextField.h"

#import "ThankYou.h"

@interface ApprovalLeaveDetails : ViewController<NSXMLParserDelegate,UIWebViewDelegate>
{
    UIView *viewAddcartPopup;
    
    AppDelegate *app666;
    objLeaveDetails *objldtsss;
    
    UITextField *Activetxtfld;
    id actvtextbox;
    UIDatePicker *datePicker1 ,*datePicker2;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSString *strLeaveIDapproval,*strMessageCodeapproval;
    int Useraction;
    UIView *loadingCircle;
    
    NSString *strFullHalf;
    
    NSString *strnoofMessagecode,*strMessageTextapproval,*strnoofdaysvalue;
    
    UIButton *btnAttch,*btnAttchGrayOut;
    
    UIView *mainBg,*bgVwHeader;
    UIButton *btnDonepdf;
    UIImageView *webvwImgPopup;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property(nonatomic,retain)objLeaveDetails *objldtsss;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollLeave;

@property (strong, nonatomic) IBOutlet MyTextField *txtEmployeename;
@property (strong, nonatomic) IBOutlet MyTextField *txtfromDate;
@property (strong, nonatomic) IBOutlet MyTextField *txtToDate;
@property (strong, nonatomic) IBOutlet MyTextField *txtNoofDays;
@property (strong, nonatomic) IBOutlet MyTextField *txtLeaveType;

@property (strong, nonatomic) IBOutlet UITextView *txtvReason;


@property (strong, nonatomic) IBOutlet UIButton *btnApprove;
- (IBAction)pressApprove:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnReject;
- (IBAction)pressReject:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewFullHalf;
@property (strong, nonatomic) IBOutlet UILabel *lblFullDay;
@property (strong, nonatomic) IBOutlet UILabel *lblHalfDay;
@property (strong, nonatomic) IBOutlet UIButton *btnFull;
@property (strong, nonatomic) IBOutlet UIButton *btnHalf;
- (IBAction)pressFullHalfMethod:(id)sender;


@end
