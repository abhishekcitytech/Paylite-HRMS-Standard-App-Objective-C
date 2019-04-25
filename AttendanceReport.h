//
//  AttendanceReport.h
//  Paylite HR
//
//  Created by Sandipan on 16/02/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class AppDelegate;

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AttendanceReport : UIViewController<NSXMLParserDelegate,UIWebViewDelegate,MFMailComposeViewControllerDelegate,UITextFieldDelegate>
{
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    UIView *loadingCircle;
    UIView *viewAddcartPopup;
    
    UITextField *Activetxtfld;
    id actvtextbox;
    NSComparisonResult result;
    NSString *strComparedate;
    UIDatePicker *datePicker1 ,*datePicker2;
    
    UIView *mainBg,*bgVwHeader;
    UIButton *btnDonepdf,*btnPrintpdf,*btnEmailpdf,*btnSharepdf;
    UIWebView *webViewPdfReader;
    
    NSString *strMesgCode,*strFileLoctn,*strMesgCodeTEXT;
    
    NSMutableArray *arrMTodaysPunch;
    NSMutableDictionary *dicMTodaysPunch;
    
    UIView *viewDetail1,*viewDetail2;
    UITableView *tblView;
    NSString *strHideUnHide;
    
    UITextField *txtFromDate,*txtToDate;
    UIButton *btnGenerate;
    
}
@property (strong, nonatomic) IBOutlet UIView *vwH;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;


@end
