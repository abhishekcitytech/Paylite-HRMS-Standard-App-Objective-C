//
//  ExpenseClaim.h
//  Paylite HR
//
//  Created by Sabnam Nasrin on 04/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ACCEPTABLE_CHARACTERS @".0123456789"

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "MyTextField.h"
#import "ImageViewCat.h"
#import "ThankYou.h"

#import "AppDelegate.h"
@class AppDelegate;

#import "objExpenseType.h"

#import "Decode64.h"

@interface ExpenseClaim : UIViewController<NSXMLParserDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIToolbar *toolbar1;
    UIDatePicker *datePicker1 ,*datePicker2;
    
    UITableView *tabViewDropdown;
    NSArray *arrFeedTblPopup;

    UIView *viewAddcartPopup;
    UIView *loadingCircle;
    
    AppDelegate *app4;

    CGFloat currX;
    NSMutableArray *arrImages;
    UIImagePickerController* imagePickerController;
    
    
    NSString *strPayCash;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSString *strIDDD;
   
    NSMutableArray *arrMExpenseType;
    objExpenseType *objept;
    
    NSString *strExpenseApplyMessageCode,*strExpenseApplyMessageText;
    
    
    UIImage *image;
    NSData *imageData;
}

- (IBAction)pressBack:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollExpense;
@property (weak, nonatomic) IBOutlet MyTextField *txtVoucherDate;
@property (weak, nonatomic) IBOutlet MyTextField *txtEmployee;
@property (weak, nonatomic) IBOutlet MyTextField *txtExpenseHead;
@property (weak, nonatomic) IBOutlet MyTextField *txtExpenseDate;
@property (weak, nonatomic) IBOutlet MyTextField *txtAmount;
@property (weak, nonatomic) IBOutlet UITextView *txtRemarks;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollDocument;
@property (weak, nonatomic) IBOutlet UIButton *btnDocument;
- (IBAction)pressDocument:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewPayinCash;
@property (strong, nonatomic) IBOutlet UILabel *lblPayCash;
@property (weak, nonatomic) IBOutlet UIButton *btnPayCash;
- (IBAction)pressPayCash:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)pressSave:(id)sender;

@end
