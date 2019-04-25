//
//  LeaveBalance.h
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
#import "MyTextField.h"

#import "objLeaveType.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface LeaveBalance : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,UIWebViewDelegate,MFMailComposeViewControllerDelegate>
{
    UITableView *tblView;
    
    UIView *viewAddcartPopup;
    UIView *loadingCircle;
    
    UITextField *Activetxtfld;
    id actvtextbox;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    NSMutableArray *arrMLeaveType;
    
    objLeaveType *objlt;
    NSString *strIDDD;
    
    NSString *strlevablanceMessagecode,*strleavefilelocation;
    
    UIView *mainBg,*bgVwHeader;
    UIButton *btnDonepdf,*btnPrintpdf,*btnEmailpdf,*btnSharepdf;
    UIWebView *webViewPdfReader;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;
@property (strong, nonatomic) IBOutlet UIView *viewBox;

@property (strong, nonatomic) IBOutlet MyTextField *txtLeaveType;
@property (strong, nonatomic) IBOutlet UIButton *btnGenerate;
- (IBAction)pressGenerate:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@end
