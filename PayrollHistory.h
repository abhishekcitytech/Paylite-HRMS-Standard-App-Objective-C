//
//  PayrollHistory.h
//  Paylite HR
//
//  Created by Sabnam Nasrin on 06/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
@class AppDelegate;

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


#import "Menu.h"

@interface PayrollHistory : UIViewController<NSXMLParserDelegate,UIWebViewDelegate,MFMailComposeViewControllerDelegate>
{
    UIView *viewAddcartPopup;
    UIView *loadingCircle;
    
    NSMutableArray *arrPayroll;
    NSMutableDictionary *dicPayroll;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSString *strPayslipUrl,*strPayslipMessageCode;

    UIView *mainBg,*bgVwHeader;
    UIButton *btnDonepdf,*btnPrintpdf,*btnEmailpdf,*btnSharepdf;
    UIWebView *webViewPdfReader;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tablePayroll;

@end
