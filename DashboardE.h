//
//  DashboardE.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 30/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "AppDelegate.h"
@class AppDelegate;

#import "Menu.h"

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

#import "TodaysAttendance.h"

#import "MyLeave.h"
#import "MyAdvance.h"
#import "MyExpenseClaim.h"
#import "ChangeProfile.h"

@interface DashboardE : ViewController<XYPieChartDelegate,XYPieChartDataSource,NSXMLParserDelegate>
{
    
    UIControl *ctrlFRCLThanksPop;
    UIView *viewFRCLThanksPopOverall,*viewFRCLThanksPopTop;
    UILabel *lblFRCLMessage;
    UIButton *btnFRCLLogout;

    
    NSString *strAccCheckCode,*strAccCheckText,*strAccPlatform;
    
    NSString *strDVCCheckCode,*strDVCCheckText;
    
    AppDelegate *app2;
    UIView *loadingCircle;
    UIView *viewAddcartPopup;
    
    XYPieChart *pieChartRight;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    //---- Expiry Document -----//
    NSMutableArray *arrMDocList;
    NSMutableDictionary *dicMDoc;
    
    //---- Message Board -----//
    NSString *strBoradMessageAll,*strBoradMessageEmployewise;
    
    //---- Employee Todays in Leave -----//
    NSMutableArray *arrMEmpOnLevaeName;
    NSMutableDictionary *dicMEmpOnLevaeType;
    
    //---- Request Under Processs -----//
    NSMutableArray *slices;
    NSMutableArray *sliceColors;
    NSMutableArray *sliceText;
    
    //---- Todays Punch -----//
    NSMutableArray *arrMTodaysPunch;
    NSMutableDictionary *dicMTodaysPunch;
}


@property (strong, nonatomic) IBOutlet UITableView *tabvOverAllDashboard;

@property (strong, nonatomic) IBOutlet UIView *vwH;
- (IBAction)pressSideMenu:(id)sender;

@end
