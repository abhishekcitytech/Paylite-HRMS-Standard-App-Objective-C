//
//  MyExpenseClaim.h
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
#import "objAdvanceDetails.h"

#import "ExpenseClaim.h"

@interface MyExpenseClaim : UIViewController<NSXMLParserDelegate>
{
    AppDelegate *app643;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSMutableArray *arrMExpenseDetails;
    objExpenseDetails *objex;
    
    UIView *loadingCircle;
    UIView *viewAddcartPopup;
    
    UIView *mainBg,*bgVwHeader;
    UIButton *btnDonepdf;
    UIImageView *webvwImgPopup;

}
@property (strong, nonatomic) IBOutlet UIView *vwH;
@property (strong, nonatomic) IBOutlet UITableView *tabvMyExpense;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnApplyExpense;
- (IBAction)pressApplyExpense:(id)sender;


@end
