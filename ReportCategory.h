//
//  ReportCategory.h
//  Paylite HR
//
//  Created by Sandipan on 13/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
@class AppDelegate;
#import "CustomCollectionCell.h"
@class CustomCollectionCell;

#import "Menu.h"

#import "Myprofile.h"
#import "LeaveBalance.h"
#import "LeaveCalanderController.h"
#import "GetOutstandingAdvance.h"
#import "CurrentSalary.h"
#import "ExpiringDocuments.h"
#import "MyDependents.h"

@interface ReportCategory : UIViewController<NSXMLParserDelegate>
{
    NSMutableArray *arrMAll;
    
    
    UIView *loadingCircle;
    UIView *viewAddcartPopup;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    NSString *strLogoutMessageCode,*strLogoutMessegeText;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UITableView *tabvSubcat;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@end
