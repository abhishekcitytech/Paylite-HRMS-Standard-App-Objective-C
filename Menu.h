//
//  Menu.h
//  MoonShine
//
//  Created by SANDIPAN on 12/08/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
@class AppDelegate;

#import "TodaysAttendance.h"
#import "PayrollHistory.h"
#import "DownloadDcouments.h"
#import "PublicHoliday.h"
#import "ReportCategory.h"

#import "DashboardE.h"
#import "DashboardMH.h"

#import "AppRequestStatus.h"
#import "AppApprovalCategory.h"


@interface Menu : UIViewController<NSXMLParserDelegate>
{
    UIView *loadingCircle;
    
    NSMutableArray *arrMAll,*arrMAllImage;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    NSString *strLogoutMessageCode,*strLogoutMessegeText;
}
@property (strong, nonatomic) IBOutlet UIView *bggOverALL;


@property (strong, nonatomic) IBOutlet UIView *vwH;
@property (nonatomic, strong) IBOutlet UITableView *tabmenu;

- (IBAction)pressSideMenu:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (strong, nonatomic) IBOutlet UIButton *btnLogout;
- (IBAction)pressLogoutFunction:(id)sender;




@end
