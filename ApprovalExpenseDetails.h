//
//  ApprovalExpenseDetails.h
//  Paylite HR
//
//  Created by Sandipan on 10/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "AppDelegate.h"
@class AppDelegate;

#import "objExpenseDetails.h"
#import "MyTextField.h"

#import "ThankYou.h"

@interface ApprovalExpenseDetails : UIViewController<NSXMLParserDelegate>
{
    UIToolbar *toolbar1;
    
    NSString *strExpenseMsgCode,*strExpenseMsgText;

    objExpenseDetails *objldtsss;
    
    int Useraction;
    
    UIView *viewAddcartPopup;
    UIView *loadingCircle;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    UIButton *btnAttch,*btnAttchGrayOut;
    
    UIView *mainBg,*bgVwHeader;
    UIButton *btnDonepdf;
    UIImageView *webvwImgPopup;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollExpense;
@property (weak, nonatomic) IBOutlet MyTextField *txtVoucherDate;
@property (weak, nonatomic) IBOutlet MyTextField *txtEmployee;
@property (weak, nonatomic) IBOutlet MyTextField *txtExpenseHead;
@property (weak, nonatomic) IBOutlet MyTextField *txtExpenseDate;
@property (weak, nonatomic) IBOutlet MyTextField *txtAmount;

@property (weak, nonatomic) IBOutlet UITextView *txtRemarks;

@property (strong, nonatomic) IBOutlet UIView *viewpaycash;
@property (weak, nonatomic) IBOutlet UIButton *btnPayCash;
- (IBAction)pressPayCash:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnApprove;
- (IBAction)pressApprove:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnReject;
- (IBAction)pressReject:(id)sender;

@property(nonatomic,retain)objExpenseDetails *objldtsss;

@end
