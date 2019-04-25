//
//  GetOutstandingAdvance.h
//  Paylite HRMS
//
//  Created by Sandipan on 10/07/17.
//  Copyright © 2017 SANDIPAN. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"
@class AppDelegate;
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "MyTextField.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>



@interface GetOutstandingAdvance : ViewController<NSXMLParserDelegate,UIWebViewDelegate,MFMailComposeViewControllerDelegate>
{
    
    UIView *viewAddcartPopup;
    
    NSString *strIdentifier;
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    
    UIView *loadingCircle;
    
    UITextField *Activetxtfld;
    id actvtextbox;
    
    NSComparisonResult result;
    NSString *strComparedate;
    
    UIDatePicker *datePicker1 ,*datePicker2;
    
    UIView *mainBg,*bgVwHeader;
    UIButton *btnDonepdf,*btnPrintpdf,*btnEmailpdf,*btnSharepdf;
    UIWebView *webViewPdfReader;
    
    
    NSString *strMesgCode,*strFileLoctn;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIView *viewBox;


@property (strong, nonatomic) IBOutlet MyTextField *txtFromDate;
@property (strong, nonatomic) IBOutlet MyTextField *txtToDate;

@property (strong, nonatomic) IBOutlet UIButton *btnGenerate;
- (IBAction)pressGenerate:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@end
