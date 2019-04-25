//
//  CurrentSalary.h
//  Paylite HR
//
//  Created by Sandipan on 01/01/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@class AppDelegate;

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>


@interface CurrentSalary : ViewController<NSXMLParserDelegate>
{
    AppDelegate *app334;
    
    UIView *viewAddcartPopup;
    UIView *loadingCircle;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSString *strMessagecode,*strMessagetext;
    
    NSMutableDictionary *dicData;
    
    NSArray *arrMAllowanceNameAndAmount;
    NSArray *arrMDeductionNameAndAmount;
    
    NSMutableArray *arrMSortedData,*arrMSortedData1;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tabvSalaryinfo;






@end
