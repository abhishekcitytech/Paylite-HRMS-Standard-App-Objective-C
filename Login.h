//
//  Login.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 29/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
@class AppDelegate;
#import "DashboardE.h"
#import "DashboardMH.h"
#import "objCompanydetails.h"
#import "CompanySelection.h"
#import "MyTextField.h"

@interface Login : ViewController<NSXMLParserDelegate,UITextFieldDelegate>
{
    UIView *viewAddcartPopup;
    
    NSMutableArray *arrMcompdtls;
    objCompanydetails *objcompdtls;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
 NSString*strMessageCode,*strMessageText,*strEmployeeID,*strEmployeeName,*strDepartment,*strDesignation,*strDateOfJoin,*strEmployeeCode,*strUsername,*strPassword,*strImage;
    
    NSString *strMessageCodeComapny,*strMessageTextComapny;
    
    NSString *strIdentifier;
    AppDelegate *app1;
    
    UIView *loadingCircle;

    NSString *struserinfoMessagecode,*struserinfoMessagetext,*struserinfoisManager,*struserinfoisHR,*struserinfoisGeoLocation;
    //
    UIControl *ctrlPop;
    UIView *viewPop,*viewPop1;
    UIImageView *imgvPop1;
    UITextField *txtfpop1;
    UIButton *btnSubmitAcc,*btnGetAcc;
    NSString *strFetchAccMessacode,*strFetchAccMessatext,*strFetchAccUrl,*strFetchAccPName;
    
    
    UIView *ctrlThanksPop;
    UIView *viewThanksPopTop,*viewThanksPopOverall;
    UIImageView *imgvThanks;
    
    UIButton *btnWebsite;
    UIButton *btnFacebook,*btnTwitter,*btnLinkedIn,*btnThanksBackarrow;
    
    
    UIView *mainBg;
    UITextField *txtPOPEmail;
    UIButton *btnPOPSubmit;
    
    NSString *strFetchEmailPOPMessageCode,*strFetchEmailPOPMessageText;
    
    
    UIControl *ctrlPopReset;
    UIView *viewPopReset;
    UIImageView *imgvPop1Reset;
    UITextField *txtfpop1Reset;
    UIButton *btnSubmitAccReset,*btnBackAccReset;
    
    NSString *strFetchAccMessacodeRR,*strFetchAccMessatextRR,*strFetchAccUrlRR,*strFetchAccPNameRR;
    
    BOOL isKeyBoardAnimated;
    
}

@property (strong, nonatomic) IBOutlet UIView *viewSupported;
@property (strong, nonatomic) IBOutlet UILabel *lblsupported;
@property (strong, nonatomic) IBOutlet UIImageView *imgvSupported;
@property (strong, nonatomic) IBOutlet UIImageView *imgvBanner;


@property (strong, nonatomic) IBOutlet UIView *viewbglog;
@property (strong, nonatomic) IBOutlet MyTextField *txtUsername;
@property (strong, nonatomic) IBOutlet MyTextField *txtPassword;

@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
- (IBAction)pressLogin:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnResetAccNumber;
- (IBAction)pressResetAccNumber:(id)sender;





@end
