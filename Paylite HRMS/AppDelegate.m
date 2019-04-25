//
//  AppDelegate.m
//  Paylite HRMS
//
//  Created by SANDIPAN on 29/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "AppDelegate.h"

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
#endif

// Implement UNUserNotificationCenterDelegate to receive display notification via APNS for devices
// running iOS 10 and above.
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@interface AppDelegate () <UNUserNotificationCenterDelegate>
    @end
#endif

// Copied from Apple's header in case it is missing in some cases (e.g. pre-Xcode 8 builds).
#ifndef NSFoundationVersionNumber_iOS_9_x_Max
#define NSFoundationVersionNumber_iOS_9_x_Max 1299
#endif
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()

@end

@implementation AppDelegate
NSString *const kGCMMessageIDKey = @"gcm.message_id";
@synthesize nav,objLogin,dicUserDetails,dicCompanyDetails,strMsgCount;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSUserDefaults standardUserDefaults]setValue:@"eng" forKey:@"applicationlanguage"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //------- Local Notification setup -----------//
    /*UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [self configureLocalNotification];*/
    
    //------- Fire base notification setup -------//
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [FIRApp configure];
    [FIRMessaging messaging].delegate = self ;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1)
    {
        // iOS 7.1 or earlier. Disable the deprecation warnings
        UIRemoteNotificationType allNotificationTypes =(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        [application registerForRemoteNotificationTypes:allNotificationTypes];
    }
    else
    {
        // iOS 8 or later
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max)
        {
            UIUserNotificationType allNotificationTypes =(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
            UIUserNotificationSettings *settings =[UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
            [application registerUserNotificationSettings:settings];
        }
        else
        {
            // iOS 10 or later
            [UNUserNotificationCenter currentNotificationCenter].delegate = self;
            UNAuthorizationOptions authOptions =UNAuthorizationOptionAlert| UNAuthorizationOptionSound| UNAuthorizationOptionBadge;
            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error){
            }];
        }
        [application registerForRemoteNotifications];
    }
    //------- Fire base notification #Endif -----------//
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f)
        {
            //5S
            objLogin = [[Login alloc] initWithNibName:@"Login5S" bundle:nil];
        }
        else if(screenSize.height == 667.0f){
            //6
            objLogin = [[Login alloc] initWithNibName:@"Login6" bundle:nil];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            objLogin = [[Login alloc] initWithNibName:@"Login6Plus" bundle:nil];
        }
        else if(screenSize.height == 812.0f){
            //X
            objLogin = [[Login alloc] initWithNibName:@"LoginX" bundle:nil];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            objLogin = [[Login alloc] initWithNibName:@"LoginXSMAX" bundle:nil];
        }
        else
        {
            //4S
            objLogin = [[Login alloc] initWithNibName:@"Login" bundle:nil];
        }
    }
    else
    {
    }
    nav=[[UINavigationController alloc] initWithRootViewController:objLogin];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self saveContext];
}

#pragma mark - Core Data stack method
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.-.Paylite_HRMS" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Paylite_HRMS" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    // Create the coordinator and store
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Paylite_HRMS.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}
- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support method
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Language Change method
-(NSString*)changeLanguage:(NSString*)key{
    
    NSLog(@"key %@",key);
    NSString *path,*updatedStr;
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"applicationlanguage"] isEqualToString:@"eng"])
    {
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
        NSBundle* languageBundle = [NSBundle bundleWithPath:path];
        updatedStr=[languageBundle localizedStringForKey:key value:@"" table:nil];
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"applicationlanguage"] isEqualToString:@"ar"])
    {
        NSString *path;
        path = [[NSBundle mainBundle] pathForResource:@"ar" ofType:@"lproj"];
        NSBundle* languageBundle = [NSBundle bundleWithPath:path];
        updatedStr=[languageBundle localizedStringForKey:key value:@"" table:nil];
    }
    return updatedStr;
}

    
#pragma mark - Firebase Notification method
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // Print message ID.
    if (userInfo[kGCMMessageIDKey])
    {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    // Print full message.
    NSLog(@"%@", userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    //---------- Google Firebase -------------//
    NSDictionary *userInfo = notification.request.content.userInfo;
    NSLog(@"%@", userInfo);
    if (userInfo[kGCMMessageIDKey])
    {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    [self NotificationPopup:userInfo];
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionNone);
    
    //---------- Local Notification -------------//
    // Play sound and show alert to the user
    //completionHandler(UNAuthorizationOptionAlert + UNAuthorizationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    //---------- Google Firebase -------------//
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]){
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    NSLog(@"%@", userInfo);
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    [self NotificationPopup:userInfo];
    completionHandler();
}
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken
{
    NSLog(@"FCM registration token: %@", fcmToken);
    NSString *token = [FIRMessaging messaging].FCMToken;
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"deviceToken"];
}
-(void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage
{
    NSLog(@"Received data message: %@", [[remoteMessage.appData valueForKey:@"aps"] valueForKey:@"alert"]);
}
-(void)NotificationPopup:(NSDictionary*)userInfo
{
    if (([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) || ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive))
    {
        NSLog(@"App is currently inactive or background state");
        [self notificationClickRedirection:userInfo];
    }
    else
    {
        NSLog(@"App is currently active state");
        NSDictionary *dictemp=[userInfo valueForKey:@"aps"];
        NSString *message =[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"alert"]];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:message
                                                                            message:@""
                                                                     preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"Check Now"
                                                                    style: UIAlertActionStyleDestructive
                                                                  handler: ^(UIAlertAction *action) {
                                                                      NSLog(@"Check Now button tapped!");
                                                                      [self notificationClickRedirection:userInfo];
                                                                  }];
        UIAlertAction *alertActionCancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                              style: UIAlertActionStyleDefault
                                                            handler: ^(UIAlertAction *action) {
                                                                NSLog(@"Cancel button tapped!");
                                                            }];
        [controller addAction: alertAction];
        [controller addAction: alertActionCancel];
        [self.objLogin presentViewController: controller animated: YES completion: nil];
    }
}
-(NSString*)ReplaceStringNull:(id)str
{
    NSString *st=[NSString stringWithFormat:@"%@",str];
    st = [st stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    st = [st stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    st = [st stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return st;
}
-(void)notificationClickRedirection:(NSDictionary*)userInfo
{
    NSLog(@"UserInfoNotification :%@",UserInfoNotification);
    NSString *stroptMode=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"gcm.notification.optMode"]];
    NSString *stroptType=[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"gcm.notification.optType"]];
    NSLog(@"UserInfoNotification :%@",stroptMode);
    NSLog(@"UserInfoNotification :%@",stroptType);
    
    if ([stroptType isEqualToString:@"MyLeave"])
    {
        MyLeave *frontViewController;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                frontViewController=[[MyLeave alloc] initWithNibName:@"MyLeave5S" bundle:Nil];
            }
            else if(screenSize.height == 667.0f){
                frontViewController=[[MyLeave alloc] initWithNibName:@"MyLeave6" bundle:Nil];
            }
            else if(screenSize.height == 736.0f){
                frontViewController=[[MyLeave alloc] initWithNibName:@"MyLeave6Plus" bundle:Nil];
            }
            else if(screenSize.height == 812.0f){
                frontViewController=[[MyLeave alloc] initWithNibName:@"MyLeaveX" bundle:Nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                frontViewController=[[MyLeave alloc] initWithNibName:@"MyLeaveXSMAX" bundle:Nil];
            }
            else{
                frontViewController=[[MyLeave alloc] initWithNibName:@"MyLeave6Plus" bundle:Nil];
            }
        }
        //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        [nav pushViewController:frontViewController animated:YES];
    }
    else  if ([stroptType isEqualToString:@"MyAdvance"])
    {
        MyAdvance *frontViewController;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                frontViewController=[[MyAdvance alloc] initWithNibName:@"MyAdvance5S" bundle:Nil];
            }
            else if(screenSize.height == 667.0f){
                frontViewController=[[MyAdvance alloc] initWithNibName:@"MyAdvance6" bundle:Nil];
            }
            else if(screenSize.height == 736.0f){
                frontViewController=[[MyAdvance alloc] initWithNibName:@"MyAdvance6Plus" bundle:Nil];
            }
            else if(screenSize.height == 812.0f){
                frontViewController=[[MyAdvance alloc] initWithNibName:@"MyAdvanceX" bundle:Nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                frontViewController=[[MyAdvance alloc] initWithNibName:@"MyAdvanceXSMAX" bundle:Nil];
            }
            else{
                frontViewController=[[MyAdvance alloc] initWithNibName:@"MyAdvance" bundle:Nil];
            }
        }
        //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        [nav pushViewController:frontViewController animated:YES];
    }
    else  if ([stroptType isEqualToString:@"MyExpense"])
    {
        MyExpenseClaim *frontViewController;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                frontViewController=[[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim5S" bundle:Nil];
            }
            else if(screenSize.height == 667.0f){
                frontViewController=[[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim6" bundle:Nil];
            }
            else if(screenSize.height == 736.0f){
                frontViewController=[[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim6Plus" bundle:Nil];
            }
            else if(screenSize.height == 812.0f){
                frontViewController=[[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaimX" bundle:Nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                frontViewController=[[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaimXSMAX" bundle:Nil];
            }
            else{
                frontViewController=[[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim" bundle:Nil];
            }
        }
        //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        [nav pushViewController:frontViewController animated:YES];
    }
    else if ([stroptType isEqualToString:@"Leave"])
    {
        ApprovalLeave *frontViewController;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                frontViewController=[[ApprovalLeave alloc] initWithNibName:@"ApprovalLeave5S" bundle:Nil];
            }
            else if(screenSize.height == 667.0f){
                frontViewController=[[ApprovalLeave alloc] initWithNibName:@"ApprovalLeave6" bundle:Nil];
            }
            else if(screenSize.height == 736.0f){
                frontViewController=[[ApprovalLeave alloc] initWithNibName:@"ApprovalLeave6Plus" bundle:Nil];
            }
            else if(screenSize.height == 812.0f){
                frontViewController=[[ApprovalLeave alloc] initWithNibName:@"ApprovalLeaveX" bundle:Nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                frontViewController=[[ApprovalLeave alloc] initWithNibName:@"ApprovalLeaveXSMAX" bundle:Nil];
            }
            else{
                frontViewController=[[ApprovalLeave alloc] initWithNibName:@"ApprovalLeave" bundle:Nil];
            }
        }
        //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        [nav pushViewController:frontViewController animated:YES];
    }
    else  if ([stroptType isEqualToString:@"Advance"])
    {
        ApprovalAdvance *frontViewController;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                frontViewController=[[ApprovalAdvance alloc] initWithNibName:@"ApprovalAdvance5S" bundle:Nil];
            }
            else if(screenSize.height == 667.0f){
                frontViewController=[[ApprovalAdvance alloc] initWithNibName:@"ApprovalAdvance6" bundle:Nil];
            }
            else if(screenSize.height == 736.0f){
                frontViewController=[[ApprovalAdvance alloc] initWithNibName:@"ApprovalAdvance6Plus" bundle:Nil];
            }
            else if(screenSize.height == 812.0f){
                frontViewController=[[ApprovalAdvance alloc] initWithNibName:@"ApprovalAdvanceX" bundle:Nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                frontViewController=[[ApprovalAdvance alloc] initWithNibName:@"ApprovalAdvanceXSMAX" bundle:Nil];
            }
            else{
                frontViewController=[[ApprovalAdvance alloc] initWithNibName:@"ApprovalAdvance" bundle:Nil];
            }
        }
        //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        [nav pushViewController:frontViewController animated:YES];
    }
    else  if ([stroptType isEqualToString:@"Expense"])
    {
        ApprovalExpense *frontViewController;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                frontViewController=[[ApprovalExpense alloc] initWithNibName:@"ApprovalExpense5S" bundle:Nil];
            }
            else if(screenSize.height == 667.0f){
                frontViewController=[[ApprovalExpense alloc] initWithNibName:@"ApprovalExpense6" bundle:Nil];
            }
            else if(screenSize.height == 736.0f){
                frontViewController=[[ApprovalExpense alloc] initWithNibName:@"ApprovalExpense6Plus" bundle:Nil];
            }
            else if(screenSize.height == 812.0f){
                frontViewController=[[ApprovalExpense alloc] initWithNibName:@"ApprovalExpenseX" bundle:Nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                frontViewController=[[ApprovalExpense alloc] initWithNibName:@"ApprovalExpenseXSMAX" bundle:Nil];
            }
            else{
                frontViewController=[[ApprovalExpense alloc] initWithNibName:@"ApprovalExpense" bundle:Nil];
            }
        }
        //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        [nav pushViewController:frontViewController animated:YES];
    }
}


#pragma mark - UNUserNotificationCenter Delegate method
- (void)configureLocalNotification
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"Something went wrong");
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Something went wrong in notifications."
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            [self.objLogin presentViewController: alert animated: YES completion: nil];
        }
    }];
}
- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity
{
}

#pragma mark - Screen Orientation method
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if(self.restrictRotation)
    {
        return UIInterfaceOrientationMaskLandscape;
    }
    else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

@end
