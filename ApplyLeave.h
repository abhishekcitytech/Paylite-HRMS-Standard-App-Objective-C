//
//  ApplyLeave.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 30/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@class AppDelegate;
#import "objLeaveType.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "MyTextField.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#import "ThankYou.h"

#import "MyLeave.h"

#import "DashboardE.h"
#import "DashboardMH.h"

#import "Decode64.h"
#import "Base64.h"

@interface ApplyLeave : ViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,UIWebViewDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIView *viewAddcartPopup;
    
    AppDelegate *app4;
    
    UITextField *Activetxtfld;
    id actvtextbox;
    
    UIDatePicker *datePicker1 ,*datePicker2;

    UITableView *tblView;
    NSArray *arrFeedTblPopup;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    NSMutableArray *arrMLeaveType;
    
     NSMutableArray *arrMSubordinates;
    NSMutableDictionary *DictSubordinates;
    
    objLeaveType *objlt;
    
    NSString *strIDDD;
    

    NSString *strSubordIDD;
    
    
    NSString *strLeaveApplyMessageCode,*strLeaveApplyMessageText;
    
    
    UIView *loadingCircle;
    
    int countDays;
    NSComparisonResult result;
    NSString *strComparedate;
    
    NSString *strFullHalf;
    
    
    NSString *strnoofMessagecode,*strnoofdaysvalue;
    
    NSString *strlevablanceMessagecode,*strleavefilelocation,*strgetsubordinateCode;
    
    UIView *mainBg,*bgVwHeader;
    UIButton *btnDonepdf,*btnPrintpdf,*btnEmailpdf,*btnSharepdf;
    UIWebView *webViewPdfReader;
    
    
    CGFloat currX;
    NSMutableArray *arrImages;
    UIImagePickerController* imagePickerController;
    
    UIImage *image;
    NSData *imageData;
}

@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollLeave;

@property (strong, nonatomic) IBOutlet MyTextField *txtEmployeename;
@property (strong, nonatomic) IBOutlet MyTextField *txtfromDate;
@property (strong, nonatomic) IBOutlet MyTextField *txtToDate;
@property (strong, nonatomic) IBOutlet MyTextField *txtNoofDays;
@property (strong, nonatomic) IBOutlet MyTextField *txtLeaveType;
@property (strong, nonatomic) IBOutlet UITextView *txtvReason;

@property (strong, nonatomic) IBOutlet UIButton *btnApply;
- (IBAction)pressApply:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnLeaveBalance;
- (IBAction)pressLeaveBalance:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressback:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewFullHalf;
@property (strong, nonatomic) IBOutlet UILabel *lblFullDay;
@property (strong, nonatomic) IBOutlet UILabel *lblHalfDay;
@property (strong, nonatomic) IBOutlet UIButton *btnFull;
@property (strong, nonatomic) IBOutlet UIButton *btnHalf;
- (IBAction)pressFullHalfMethod:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnEmployeename;
- (IBAction)pressEmployeename:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollDocument;
@property (weak, nonatomic) IBOutlet UIButton *btnDocument;
- (IBAction)pressDocument:(id)sender;

@end
