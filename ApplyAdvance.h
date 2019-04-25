//
//  ApplyAdvance.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 31/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ViewController.h"

#define ACCEPTABLE_CHARACTERS @".0123456789"

#import "AppDelegate.h"
@class AppDelegate;

#import "objAdvanceType.h"

#import "UIMonthYearPicker.h"
@class UIMonthYearPicker;

#import "MyTextField.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "GetOutstandingAdvance.h"

#import "ThankYou.h"

@interface ApplyAdvance : ViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>
{
    
    UIView *viewAddcartPopup;
    
    UIToolbar *toolbar1;
    UIToolbar *toolbar2;
    
    
    AppDelegate *app7;
    
    UIView *viewDropdown;
    UITableView *tabViewDropdown;
    
    NSArray *arrFeedTblPopup;
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSString *strIDDD;
    NSString *strAdvanceApplyMessageCode,*strAdvanceApplyMessageText;
    
    NSMutableArray *arrMAdvanceType;
    objAdvanceType *objadt;
    
    UIMonthYearPicker *datePicker;
    NSDateFormatter *dateFormatter;
    BOOL IsDatePickerShown;
    UIView *VwDatePick;
    NSDate *selDate;
    NSString *month,*year,*strDateFromPicker;
    
    UIView *loadingCircle;
    
    NSString *strDateSelect;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollApplyAdvance;

@property (strong, nonatomic) IBOutlet MyTextField *txtApplicationDate;
@property (strong, nonatomic) IBOutlet MyTextField *txtEmployeename;
@property (strong, nonatomic) IBOutlet MyTextField *txtAdvancetype;
@property (strong, nonatomic) IBOutlet MyTextField *txtAdvanceamount;
@property (strong, nonatomic) IBOutlet MyTextField *txtNoofinstallment;
@property (strong, nonatomic) IBOutlet MyTextField *txtrepaymentamount;
@property (strong, nonatomic) IBOutlet MyTextField *txtdeductionmonthyear;
@property (strong, nonatomic) IBOutlet UILabel *lblReason;
@property (strong, nonatomic) IBOutlet UITextView *txtvReason;

@property (strong, nonatomic) IBOutlet UIButton *btnApply;
- (IBAction)pressApplyAdvance:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnOutstandingAdvance;
- (IBAction)pressOutstandingAdvance:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@end
