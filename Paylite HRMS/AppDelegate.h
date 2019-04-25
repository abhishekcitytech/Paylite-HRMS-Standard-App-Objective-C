//
//  AppDelegate.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 29/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//




#define screenHeight  [UIScreen mainScreen].bounds.size.height
#define screenWidth   [UIScreen mainScreen].bounds.size.width
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UserNotifications/UserNotifications.h>
#import "MyLeave.h"
#import "ApprovalLeave.h"
#import "MyAdvance.h"
#import "ApprovalAdvance.h"
#import "MyExpenseClaim.h"
#import "ApprovalExpense.h"
@import UIKit;
#import "Firebase.h"
@import FirebaseCore;
@import FirebaseMessaging;
#import "Login.h"
@class Login;
#import "MyAdvance.h"
@class MyAdvance;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,FIRMessagingDelegate,UNUserNotificationCenterDelegate>
{
    NSMutableDictionary *dicUserDetails,*dicCompanyDetails;
    NSDictionary *UserInfoNotification;
}
@property(nonatomic,retain)NSMutableDictionary *dicUserDetails,*dicCompanyDetails;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)UINavigationController *nav;
@property(nonatomic,retain)Login *objLogin;
@property (nonatomic,assign) BOOL restrictRotation;
@property(nonatomic,retain) MyAdvance *objMyAdvance;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic)NSString *strMsgCount;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(NSString*)changeLanguage:(NSString*)key;
    

@end

