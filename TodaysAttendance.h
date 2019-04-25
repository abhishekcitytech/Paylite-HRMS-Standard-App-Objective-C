//
//  TodaysAttendance.h
//  Paylite HR
//
//  Created by Sandipan on 16/02/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class AppDelegate;

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <MapKit/MapKit.h>

#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
#import <MapKit/MapKit.h>

#import "Menu.h"

#import "AttendanceReport.h"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#import <UserNotifications/UserNotifications.h>

#import "DashboardE.h"
#import "DashboardMH.h"

@interface TodaysAttendance : UIViewController<CLLocationManagerDelegate,NSXMLParserDelegate,AVAudioPlayerDelegate,MKMapViewDelegate,UNUserNotificationCenterDelegate,UITableViewDelegate,UITableViewDataSource>
{
    AVAudioPlayer *player;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSString *strPunchMessagecode,*strPunchID;
    
    UIView *loadingCircle;
    UIView *viewAddcartPopup;
    
    UIControl *ctrlPunchPopUp;
    UIView *viewPunchPopUp;
    UIButton *btncrossPunchPopup;
    UITableView *tblView;
    
    NSMutableArray *arrCoordinate,*arrAnnotation;
    NSMutableArray *arrLat,*arrLong,*arrBrnchName,*arrBrnchId,*arrBrnchDistance;
    CLGeocoder *geocode;
    CLPlacemark *placemark;
    NSString *Address;
    NSString *Area;
    NSString *Country;
    NSString *CountryArea;
    
    CLLocationManager *locationManager;
    CLLocationCoordinate2D geofenceRegionCenter;
    CLCircularRegion *geofenceRegion;
    
    MKMapView *mapvUserLocation;
    NSString *latitude;
    NSString *longitude;
    
    NSMutableArray *arrMTodaysPunch;
    NSMutableDictionary *dicMTodaysPunch;
    UIView *attsummaryView;
    NSString *strPunchInTime,*strPunchOutTime,*strWorkingHours;
    
    NSString *strLocalNotifyBodyText;
    
    NSString *strCHECKMessagecode,*strCHECKMessagetext,*strCHECKisManager,*strCHECKisHR,*strCHECKisGeoLocation;
    
    UILabel *lblMessage;
}

@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblTodayDate;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrentTime;
@property (strong, nonatomic) IBOutlet UIButton *btnCheckIn;
- (IBAction)pressCheckIn:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnAttendanceReport;
- (IBAction)pressAttendanceReport:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btnDashboard;
- (IBAction)pressDashboard:(id)sender;



@end
