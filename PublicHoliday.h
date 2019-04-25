//
//  PublicHoliday.h
//  Paylite HR
//
//  Created by Sandipan on 02/01/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#define kViolet [UIColor colorWithRed:170/255.0 green:114/255.0 blue:219/255.0 alpha:1.0]

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
@class AppDelegate;
#import "objHolidayList.h"
#import "Menu.h"

#import "FSCalendar.h"

@interface PublicHoliday : ViewController<NSXMLParserDelegate,FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance,UITableViewDelegate,UITableViewDataSource>
{
    UIView *viewAddcartPopup;
    UIView *loadingCircle;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSMutableArray *arrMHolidayList;
    NSMutableArray *arrMHolidayListOverAll;
    
    objHolidayList *objHL;
    
    NSString *strGetLatestYear;
    
    
    NSString *strCAlEN ;
    NSMutableArray *arrTable;
    NSDate *currentDT;
    NSString *strSelectedDate;
    NSMutableArray *arrMLDT,*arrMallDateList,*arrMallDateListFilter;
    NSMutableDictionary *dicMLDT;
    
    FSCalendar *calendar;
    
    UITableView *tabvListHoliday,*tabvListHolidayOverAll;
    
    UIView *viewCalendarwithlist,*viewListview;
    
    
    NSString *strCalenderSpecofic;
    
    UILabel *lblMessage;
    
}
@property (strong, nonatomic) IBOutlet UIView *vwH;
@property (strong, nonatomic) IBOutlet UILabel *lblHeaderTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnToggle;
- (IBAction)pressbtnToggle:(id)sender;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter1;
@property (strong, nonatomic) NSDateFormatter *dateFormatter2;
@property (strong, nonatomic) NSDictionary *fillSelectionColors;
@property (strong, nonatomic) NSDictionary *fillDefaultColors;
@property (strong, nonatomic) NSDictionary *borderDefaultColors;
@property (strong, nonatomic) NSDictionary *borderSelectionColors;
@property (strong, nonatomic) NSArray *datesWithEvent;
@property (strong, nonatomic) NSArray *datesWithMultipleEvents;

@end
