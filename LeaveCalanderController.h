//
//  LeaveCalanderController.h
//  Paylite HR
//
//  Created by Macmini2 on 4/12/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#define kViolet [UIColor colorWithRed:170/255.0 green:114/255.0 blue:219/255.0 alpha:1.0]

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class AppDelegate;

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "FSCalendar.h"

@interface LeaveCalanderController : UIViewController<NSXMLParserDelegate,FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
{
    UILabel *lblMessage;
    
    UIView *viewAddcartPopup;
    UIView *loadingCircle;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSMutableArray *arrMLeaveList,*arrMallDateList;
    NSMutableDictionary *dicMLeave;
    
    NSString *strCAlEN ;
    NSMutableArray *arrTable;
    
    NSDate *currentDT;
    
    NSString *strSelectedDate;
    
    
    NSMutableArray *arrMLDT;
    NSMutableDictionary *dicMLDT;
}

@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (weak, nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter1;
@property (strong, nonatomic) NSDateFormatter *dateFormatter2;

@property (strong, nonatomic) NSDictionary *fillSelectionColors;
@property (strong, nonatomic) NSDictionary *fillDefaultColors;
@property (strong, nonatomic) NSDictionary *borderDefaultColors;
@property (strong, nonatomic) NSDictionary *borderSelectionColors;

@property (strong, nonatomic) NSArray *datesWithEvent;
@property (strong, nonatomic) NSArray *datesWithMultipleEvents;
@property (weak, nonatomic) IBOutlet UITableView *tableCalendar;

@end
