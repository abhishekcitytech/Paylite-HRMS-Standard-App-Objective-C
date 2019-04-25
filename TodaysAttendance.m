//
//  TodaysAttendance.m
//  Paylite HR
//
//  Created by Sandipan on 16/02/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "TodaysAttendance.h"


@interface TodaysAttendance ()

@end

@implementation TodaysAttendance

#pragma mark - viewDidAppear Method
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self fetchuserinfo:[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"] valueForKey:@"CompanyID"]] empid:[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"] valueForKey:@"EmployeeID"]] devcid:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]] devctype:@"I"];
}

#pragma mark - viewWillAppear Method
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

#pragma mark - viewDidLoad Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    _vwH.layer.shadowRadius = 3.0f;
    _vwH.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _vwH.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _vwH.layer.shadowOpacity = 0.5f;
    _vwH.layer.masksToBounds = NO;
    
    _btnCheckIn.layer.cornerRadius=4;
    _btnCheckIn.layer.masksToBounds=YES;
    
    _btnAttendanceReport.layer.cornerRadius=4;
    _btnAttendanceReport.layer.masksToBounds=YES;
    
    lblMessage=[[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMinY(_btnCheckIn.frame),UIScreen.mainScreen.bounds.size.width-20,60)];
    lblMessage.numberOfLines=3;
    lblMessage.font=[UIFont fontWithName:@"GothamBook" size:13];
    lblMessage.backgroundColor=[UIColor clearColor];
    lblMessage.textAlignment=NSTextAlignmentCenter;
    lblMessage.textColor=[UIColor blackColor];
    [self.view addSubview:lblMessage];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMM d, yyyy";
    NSString *string = [formatter stringFromDate:[NSDate date]];
    _lblTodayDate.text=string;
    
    [self updateTime];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - press Back Method
- (IBAction)pressBack:(id)sender
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    Menu *objDemo;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            objDemo = [[Menu alloc] initWithNibName:@"Menu5S" bundle:nil];
        }
        else if(screenSize.height == 667.0f){
            //6
            objDemo = [[Menu alloc] initWithNibName:@"Menu6" bundle:nil];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            objDemo = [[Menu alloc] initWithNibName:@"Menu6Plus" bundle:nil];
        }
        else if(screenSize.height == 812.0f){
            //X
            objDemo = [[Menu alloc] initWithNibName:@"MenuX" bundle:nil];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            objDemo = [[Menu alloc] initWithNibName:@"MenuXSMAX" bundle:nil];
        }
        else{
            objDemo = [[Menu alloc] initWithNibName:@"Menu" bundle:nil];
        }
    }
    else
    {
    }
    [objDemo.view setFrame:CGRectMake(-UIScreen.mainScreen.bounds.size.width, 0, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height)];
    [self addChildViewController:objDemo];
    [self.view addSubview:objDemo.view];
    [[self view] bringSubviewToFront:objDemo.view];
    [objDemo didMoveToParentViewController:self];
    [UIView animateWithDuration:0.3 animations:^{
        [objDemo.view setFrame:CGRectMake(-UIScreen.mainScreen.bounds.size.width/UIScreen.mainScreen.bounds.size.width, 0, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height)];
    }];
}

#pragma mark - Clock Digital Current Time
- (void)updateTime
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm:ss a"];
    _lblCurrentTime.text = [dateFormat stringFromDate:[NSDate date]];
    
    //call updateTime again after 1 second
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
}


#pragma mark -  Create MKMapview Method
-(void)createMapLocateus
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    locationManager.distanceFilter = kCLLocationAccuracyBest;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.allowsBackgroundLocationUpdates=YES;
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            mapvUserLocation = [[MKMapView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(_btnCheckIn.frame)+20,UIScreen.mainScreen.bounds.size.width-20,242)];
        }
        else if(screenSize.height == 667.0f){
            //6
            mapvUserLocation = [[MKMapView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(_btnCheckIn.frame)+20,UIScreen.mainScreen.bounds.size.width-20,314)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            mapvUserLocation = [[MKMapView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(_btnCheckIn.frame)+20,UIScreen.mainScreen.bounds.size.width-20,371)];
        }
        else if(screenSize.height == 812.0f){
            //X
            mapvUserLocation = [[MKMapView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(_btnCheckIn.frame)+20,UIScreen.mainScreen.bounds.size.width-20,423)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            mapvUserLocation = [[MKMapView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(_btnCheckIn.frame)+20,UIScreen.mainScreen.bounds.size.width-20,494)];
        }
        else
        {
            mapvUserLocation = [[MKMapView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(_btnCheckIn.frame)+20,UIScreen.mainScreen.bounds.size.width-20,177)];
        }
    }
    mapvUserLocation.delegate=self;
    [mapvUserLocation setShowsUserLocation:YES];
    mapvUserLocation.showsTraffic=YES;
    mapvUserLocation.showsCompass=YES;
    mapvUserLocation.showsBuildings=YES;
    mapvUserLocation.userInteractionEnabled=YES;
    mapvUserLocation.camera.altitude *= 0.1;
    [mapvUserLocation setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    mapvUserLocation.mapType=MKMapTypeStandard;
    mapvUserLocation.userTrackingMode=MKUserTrackingModeFollow;
    
    [mapvUserLocation.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [mapvUserLocation.layer setBorderWidth: 0.5];
    [mapvUserLocation.layer setCornerRadius:4.0f];
    [mapvUserLocation.layer setMasksToBounds:YES];
    [self.view addSubview:mapvUserLocation];
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:NO];
    mapView.showsUserLocation=YES;
}

#pragma mark - Create Geo-Fencing Methods
-(void)geofencingcreationforOfficeArea
{
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    NSString *strLat=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyLatitude"]];
    NSString *strLong=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyLongitude"]];
    
    double latdouble = [strLat doubleValue];
    double longdouble = [strLong doubleValue];
    
    NSLog(@"String value lat long -> (%@,%@)", strLat,strLong);
    NSLog(@"Double value lat long -> (%f,%f)", latdouble,longdouble);
    
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]])
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latdouble,longdouble);
        geofenceRegionCenter = CLLocationCoordinate2DMake(latdouble, longdouble);
        geofenceRegion = [[CLCircularRegion alloc] initWithCenter:geofenceRegionCenter radius:500 identifier:@"Office"];
        geofenceRegion.notifyOnEntry =YES;
        geofenceRegion.notifyOnExit =YES;
        
        NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
        
        //Add Office address Marker
        MKPointAnnotation *myAnnotationOffice = [[MKPointAnnotation alloc]init];
        [myAnnotationOffice setCoordinate:coordinate];
        myAnnotationOffice.title = [NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyName"]];
        [mapvUserLocation addAnnotation:myAnnotationOffice];
        
        //Zoom to user location
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000 , 1000);
        [mapvUserLocation setRegion: region animated:false];
        
        //Create Circle
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:coordinate radius:500];
        [mapvUserLocation addOverlay:circle];
    
        //[locationManager startMonitoringForRegion:geofenceRegion];
        //[locationManager requestStateForRegion:geofenceRegion];
        
        [locationManager startMonitoringForRegion:geofenceRegion];
        [locationManager performSelector:@selector(requestStateForRegion:) withObject:geofenceRegion afterDelay:1];
    }
    else
    {
        NSLog(@"System can't track regions");
    }
}
- (MKOverlayRenderer *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    circleView.strokeColor = [UIColor colorWithRed:30.0/256.0 green:161.0/256.0 blue:242.0/256.0 alpha:1.0];
    circleView.fillColor = [[UIColor colorWithRed:30.0/256.0 green:161.0/256.0 blue:242.0/256.0 alpha:1.0] colorWithAlphaComponent:0.4];
    circleView.lineWidth = 2.0;
    return circleView;
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
            [locationManager requestAlwaysAuthorization];
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [locationManager startUpdatingLocation];
            
            if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"] valueForKey:@"isGeoLocation"] isEqualToString:@""]){
            }
            else{
                [self geofencingcreationforOfficeArea];
            }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            [locationManager startUpdatingLocation];
            if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"] valueForKey:@"isGeoLocation"] isEqualToString:@""]){
            }
            else{
                [self geofencingcreationforOfficeArea];
            }
            break;
        case kCLAuthorizationStatusRestricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break;
        case kCLAuthorizationStatusDenied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break;
        default:
            break;
    }
}
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    //NSLog(@"region identifier: %@", region.identifier);
    //NSString *strVal=[NSString stringWithFormat:@"Right now, I have arrived within geo fence area (%@)",region.identifier];
    
    strLocalNotifyBodyText=@"Your are entering your work location. Don’t forget to put your daily attendance.";
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:nil
                                  message:strLocalNotifyBodyText
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    //NSLog(@"region identifier: %@", region.identifier);
    //NSString *strVal=[NSString stringWithFormat:@"Right now, I have departed from geo fence area (%@)",region.identifier];
    
    strLocalNotifyBodyText=@"Your are leaving your work location. Don’t forget to put your daily attendance.";
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:nil
                                  message:strLocalNotifyBodyText
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"Start monitoring for region: %@", region.identifier);
    [locationManager requestStateForRegion:region];
}
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"monitoringDidFailForRegion: %@", error);
}
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    // When regions are initialized, see if we are already within the geofence.
    
    if (state==CLRegionStateInside)
    {
        _btnCheckIn.hidden=NO;
        [lblMessage setText:@""];
        NSLog(@"Inside your desired area");
    }
    else if (state==CLRegionStateUnknown)
    {
        _btnCheckIn.hidden=YES;
        [lblMessage setText:@"You are not detected in your work location.\n\n Please move closed to your work location and try again."];
        NSLog(@"Unknown your desired area");
    }
    else if (state==CLRegionStateOutside)
    {
        _btnCheckIn.hidden=YES;
        [lblMessage setText:@"You are not detected in your work location.\n\n Please move closed to your work location and try again."];
        NSLog(@"Outside your desired area");
    }
    else
    {
        _btnCheckIn.hidden=YES;
        lblMessage.text=@"";
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = locations.lastObject;
    CLLocation *oldLocation;
    if (locations.count > 1){
        oldLocation = locations[locations.count - 2];
    }
    else{
        latitude = [NSString stringWithFormat:@"%.4f", newLocation.coordinate.latitude];
        longitude= [NSString stringWithFormat:@"%.4f", newLocation.coordinate.longitude];
        NSLog(@"updated-user-Location ->(%@,%@)",latitude,longitude);
    }
    //[locationManager stopUpdatingLocation];
    locationManager.allowsBackgroundLocationUpdates = YES;
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
    //-------- Check GeoFencing Enabled / Disabled -----------//
    if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"] valueForKey:@"isGeoLocation"] isEqualToString:@""])
    {
        _btnCheckIn.hidden=NO;
    }
    else
    {
        _btnCheckIn.hidden=YES;
    }
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:nil
                                  message:@"Your GPS is turned off."
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil){
        //[locationManager stopUpdatingLocation];
    }
}
-(void)alertlog:(NSString *)strvaluelog
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:nil
                                  message:strvaluelog
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Fetch User Type Method
-(void)fetchuserinfo:(NSString *)strCompanyIDD empid:(NSString *)strEmployeeIDD devcid:(NSString *)strDeviceID devctype:(NSString *)strDeviceType
{
    strIdentifier=@"3";
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<GetUserInfo xmlns=\"http://tempuri.org/\"><CompanyID>%@</CompanyID>,<EmployeeID>%@</EmployeeID>,<DeviceId>%@</DeviceId>,<DeviceType>%@</DeviceType>"
                             "</GetUserInfo> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",strCompanyIDD,strEmployeeIDD,strDeviceID,@"I"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    NSLog(@"soapMessage %@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d",(int)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetUserInfo" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //NSLog(@"contentlength=%@",msgLength);
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if(theConnection)
    {
        NSLog(@"Connected..");
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        self.view.userInteractionEnabled=NO;
        [self showLoadingMode];
    }
    else{
    }
}


#pragma mark - press Check In Method
- (IBAction)pressCheckIn:(id)sender
{
    strIdentifier=@"2";
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *strTodayDate = [formatter stringFromDate:[NSDate date]];
    NSLog(@"strTodayDate :%@",strTodayDate);
    //strTodayDate=@"2018-02-01 17:34:58.000";
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<SaveEmployeeAttendance xmlns=\"http://tempuri.org/\"><sEmployeeId>%@</sEmployeeId>,<sDateTime>%@</sDateTime>,<sGeoLocationLatLong>%@</sGeoLocationLatLong>"
                             "</SaveEmployeeAttendance> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],strTodayDate,[NSString stringWithFormat:@"%@,%@",latitude,longitude]];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/SaveEmployeeAttendance" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //NSLog(@"contentlength=%@",msgLength);
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if(theConnection)
    {
        NSLog(@"Connected..");
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        self.view.userInteractionEnabled=NO;
        [self showLoadingMode];
    }
    else
    {
    }
}



#pragma mark - Connection Delegate Method
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Response Code: %ld",(long)[(NSHTTPURLResponse*) response statusCode]);
    if(d2)
    {
        d2=nil;
    }
    d2=[[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [d2 appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *data_Response = [[NSString alloc] initWithData:d2 encoding:NSUTF8StringEncoding];
    NSLog(@"XML Response=%@",data_Response);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.view.userInteractionEnabled=YES;
    [self hideLoadingMode];
    
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:d2];
    [parser setDelegate:self];
    [parser parse];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    self.view.userInteractionEnabled=YES;
    [self hideLoadingMode];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:nil
                                  message:@"Please check your network and try again."
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - XML Parser Delegate Method
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        if ([elementName isEqualToString:@"GetTodaysPunchDataListNEWResult"])
        {
            arrMTodaysPunch=[[NSMutableArray alloc]init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            dicMTodaysPunch=[[NSMutableDictionary alloc]init];
        }
        if ([elementName isEqualToString:@"PunchTime"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if ([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"AttendanceId"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if ([strIdentifier isEqualToString:@"3"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
            NSLog(@"root is called..");
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"IsManager"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"IsHr"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"GeoLocation"])
        {
            currentElementValue=[NSMutableString string];
        }
        
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentElementValue appendString:string];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
        }
        if ([elementName isEqualToString:@"PunchTime"])
        {
            [arrMTodaysPunch addObject:currentElementValue];
            currentElementValue=nil;
        }
    }
    else if ([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strPunchMessagecode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"AttendanceId"])
        {
            strPunchID=currentElementValue;
            currentElementValue=nil;
        }
    }
    else if ([strIdentifier isEqualToString:@"3"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strCHECKMessagecode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strCHECKMessagetext=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"IsManager"])
        {
            strCHECKisManager=currentElementValue ;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"IsHr"])
        {
            strCHECKisHR=currentElementValue ;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"GeoLocation"])
        {
            strCHECKisGeoLocation=currentElementValue ;
            currentElementValue=nil;
        }
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        if ([arrMTodaysPunch count]>0)
        {
            NSLog(@"arrMTodaysPunch :%@",arrMTodaysPunch);
            [self punchPopup:arrMTodaysPunch];
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"No attendance logged yet."
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    else if ([strIdentifier isEqualToString:@"2"])
    {
        int code=[strPunchMessagecode intValue];
        if (code==0)
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Your attendance has been recorded."
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Attendance not recorded, please try after few minutes."
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    else if ([strIdentifier isEqualToString:@"3"])
    {
        int code=[strCHECKMessagecode intValue];
        if (code==0)
        {
            NSMutableDictionary *oldDict=[[NSUserDefaults standardUserDefaults]valueForKey:@"dicUserDetails"];
            //NSLog(@"oldDict :%@",oldDict);
            NSMutableDictionary *newDict = [oldDict mutableCopy];
            //NSLog(@"newDict :%@",newDict);
            
            [newDict setValue:strCHECKisGeoLocation forKey:@"isGeoLocation"];
           
            if ([strCHECKisGeoLocation isEqualToString:@""]) {
            }
            else{
                NSArray *items = [strCHECKisGeoLocation componentsSeparatedByString:@","];
                NSString *str1=[items objectAtIndex:0];
                NSString *str2=[items objectAtIndex:1];
                [newDict setValue:str1 forKey:@"CompanyLatitude"];
                [newDict setValue:str2 forKey:@"CompanyLongitude"];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:newDict forKey:@"dicUserDetails"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
        }
        
        [self createMapLocateus];
    }
}

#pragma mark - Go to Attendance report Screen
- (IBAction)pressAttendanceReport:(id)sender
{
    /*AttendanceReport *objDemo;
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            objDemo = [[AttendanceReport alloc] initWithNibName:@"AttendanceReport5S" bundle:nil];
        }
        else if(screenSize.height == 667.0f){
            //6
            objDemo = [[AttendanceReport alloc] initWithNibName:@"AttendanceReport6" bundle:nil];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            objDemo = [[AttendanceReport alloc] initWithNibName:@"AttendanceReport6Plus" bundle:nil];
        }
        else if(screenSize.height == 812.0f){
            //X
            objDemo = [[AttendanceReport alloc] initWithNibName:@"AttendanceReportX" bundle:nil];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            objDemo = [[AttendanceReport alloc] initWithNibName:@"AttendanceReportXSMAX" bundle:nil];
        }
        else{
            objDemo = [[AttendanceReport alloc] initWithNibName:@"AttendanceReport" bundle:nil];
        }
    }
    else
    {
    }
    [self.navigationController pushViewController:objDemo animated:YES];*/
    
    [self downloadTodaysPunchLIST];
}
-(void)downloadTodaysPunchLIST
{
    strIdentifier=@"1";
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *strTodayDate = [formatter stringFromDate:[NSDate date]];
    NSLog(@"strTodayDate :%@",strTodayDate);
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<GetTodaysPunchDataListNEW xmlns=\"http://tempuri.org/\"><sEmployeeId>%@</sEmployeeId>,<sDate>%@</sDate>"
                             "</GetTodaysPunchDataListNEW> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],strTodayDate];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetTodaysPunchDataListNEW" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //NSLog(@"contentlength=%@",msgLength);
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if(theConnection)
    {
        NSLog(@"Connected..");
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        self.view.userInteractionEnabled=NO;
        [self showLoadingMode];
    }
    else
    {
    }
}

#pragma mark- PUNCH Popup Method
-(void)punchPopup:(NSMutableArray *)arrMpunch
{
    ctrlPunchPopUp=[[UIControl alloc] init];
    ctrlPunchPopUp.frame=CGRectMake(0,UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width,UIScreen.mainScreen.bounds.size.height);
    ctrlPunchPopUp.backgroundColor=[UIColor clearColor];
    
    
    UIView * VwColorAlpha=[[UIView alloc] init];
    VwColorAlpha.frame=CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-UIScreen.mainScreen.bounds.size.height/1.4);
    VwColorAlpha.backgroundColor=[UIColor blackColor];
    VwColorAlpha.alpha=0.5;
    [ctrlPunchPopUp addSubview:VwColorAlpha];
    
    viewPunchPopUp=[[UIView alloc] init];
    viewPunchPopUp.frame=CGRectMake(0,CGRectGetHeight(ctrlPunchPopUp.frame)-UIScreen.mainScreen.bounds.size.height/1.4,UIScreen.mainScreen.bounds.size.width,UIScreen.mainScreen.bounds.size.height/1.4);
    viewPunchPopUp.backgroundColor=[UIColor whiteColor];
    viewPunchPopUp.layer.borderColor=[UIColor lightGrayColor].CGColor;
    viewPunchPopUp.layer.borderWidth=1.0;
    viewPunchPopUp.layer.masksToBounds=YES;
    [ctrlPunchPopUp addSubview:viewPunchPopUp];
    
    btncrossPunchPopup=[UIButton buttonWithType:UIButtonTypeCustom];
    btncrossPunchPopup.frame=CGRectMake(CGRectGetWidth(viewPunchPopUp.frame)-45,CGRectGetMinY(viewPunchPopUp.frame)-40,35,35);
    [btncrossPunchPopup setBackgroundColor:[UIColor clearColor]];
    [btncrossPunchPopup setBackgroundImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    [btncrossPunchPopup addTarget:self action:@selector(pressbtncrossPunchPopup:) forControlEvents:UIControlEventTouchUpInside];
    [ctrlPunchPopUp addSubview:btncrossPunchPopup];
    
    tblView=[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(viewPunchPopUp.frame),0, CGRectGetWidth(viewPunchPopUp.frame), 0) style:UITableViewStylePlain];
    tblView.delegate=self;
    tblView.dataSource=self;
    [viewPunchPopUp addSubview:tblView];
    tblView.backgroundView=nil;
    tblView.backgroundColor=[UIColor whiteColor];
    tblView.separatorColor=[UIColor clearColor];
    [tblView.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [tblView.layer setBorderWidth: 0.6];
    [tblView.layer setCornerRadius:2.0f];
    [tblView.layer setMasksToBounds:YES];
    
    [UIView animateWithDuration:0.35
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = tblView.frame;
                         frame.size.height = viewPunchPopUp.frame.size.height;
                         tblView.frame = frame;
                     }
                     completion:^(BOOL finished){
                     }];
    
    if (arrMTodaysPunch.count == 0){
        UILabel *lblNodata;
        lblNodata=[[UILabel alloc] initWithFrame:CGRectMake(15,CGRectGetMidX(viewPunchPopUp.frame),viewPunchPopUp.frame.size.width-30,30)];
        lblNodata.textAlignment=NSTextAlignmentCenter;
        lblNodata.textColor=[UIColor grayColor];
        lblNodata.font=[UIFont fontWithName:@"GothamBook" size:13.0];
        lblNodata.text= @"No attendance logged yet.";
        lblNodata.backgroundColor=[UIColor clearColor];
        [viewPunchPopUp addSubview:lblNodata];
    }
    
    
    ctrlPunchPopUp.layer.zPosition = 1;
    [UIView animateWithDuration:0.30 delay:0.1 options: UIViewAnimationOptionCurveEaseIn animations:^{
        [ctrlPunchPopUp setFrame:CGRectMake(0,0, UIScreen.mainScreen.bounds.size.width,UIScreen.mainScreen.bounds.size.height)];
    } completion:^(BOOL finished){
        
    }];
    [self.view addSubview:ctrlPunchPopUp];
    
}
-(void)pressbtncrossPunchPopup:(id)sender
{
    [ctrlPunchPopUp removeFromSuperview];
}

#pragma mark - UITableView Delegate & DataSource Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrMTodaysPunch count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.00f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    [view setBackgroundColor:[UIColor colorWithRed:222/256.0 green:222/256.0 blue:222/256.0 alpha:1.0]];
    
    UILabel *cellDocument=[[UILabel alloc] initWithFrame:CGRectMake(15,12,tableView.frame.size.width-30, 17)];
    cellDocument.font=[UIFont fontWithName:@"GothamBold" size:15];
    cellDocument.textColor=[UIColor darkGrayColor];
    cellDocument.textAlignment=NSTextAlignmentCenter;
    cellDocument.text=@"Time logged";
    [view addSubview:cellDocument];
    
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.backgroundColor=[UIColor whiteColor];

    UILabel *lblPounch;
    lblPounch=[[UILabel alloc] initWithFrame:CGRectMake(15,6,tableView.frame.size.width-30 ,30)];
    lblPounch.textAlignment=NSTextAlignmentCenter;
    lblPounch.textColor=[UIColor darkGrayColor];
    lblPounch.font=[UIFont fontWithName:@"GothamBook" size:13.0];
    lblPounch.backgroundColor=[UIColor clearColor];
    lblPounch.text=[NSString stringWithFormat:@"%@",[arrMTodaysPunch objectAtIndex:indexPath.row]];
    [cell.contentView addSubview:lblPounch];
    
    UILabel *lblSeparator;
    lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(15,43.5,tableView.frame.size.width-30,0.5)];
    lblSeparator.backgroundColor=[UIColor lightGrayColor];
    [cell.contentView addSubview:lblSeparator];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Custom Spinner Method
-(void)showLoadingMode
{
    if (!loadingCircle)
    {
        loadingCircle = [[UIView alloc]init];
        loadingCircle.backgroundColor = [UIColor clearColor];
        loadingCircle.alpha=1.00f;
        loadingCircle.layer.zPosition = 1;
        
        int size = 80;
        int size1 = 80;
        CGRect frame = loadingCircle.frame;
        frame.size.width = size ;
        frame.size.height = size1;
        frame.origin.x = screenWidth / 2 - frame.size.width / 2;
        frame.origin.y = screenHeight / 2 - frame.size.height / 2;
        loadingCircle.frame = frame;
        
        [loadingCircle.layer setBorderColor: [[UIColor clearColor] CGColor]];
        [loadingCircle.layer setBorderWidth: 1.0];
        [loadingCircle.layer setCornerRadius:0.0f];
        [loadingCircle.layer setMasksToBounds:YES];
        
        UIImageView* animatedImageView = [[UIImageView alloc] initWithFrame:loadingCircle.bounds];
        animatedImageView.animationImages = [NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"loader1.png"],
                                             [UIImage imageNamed:@"loader2.png"],
                                             [UIImage imageNamed:@"loader3.png"],
                                             [UIImage imageNamed:@"loader4.png"],
                                             [UIImage imageNamed:@"loader5.png"],
                                             [UIImage imageNamed:@"loader6.png"],
                                             [UIImage imageNamed:@"loader7.png"],
                                             [UIImage imageNamed:@"loader8.png"],
                                             [UIImage imageNamed:@"loader9.png"],
                                             [UIImage imageNamed:@"loader10.png"],
                                             [UIImage imageNamed:@"loader11.png"],
                                             [UIImage imageNamed:@"loader12.png"],
                                             [UIImage imageNamed:@"loader13.png"],
                                             [UIImage imageNamed:@"loader14.png"],
                                             [UIImage imageNamed:@"loader15.png"],
                                             [UIImage imageNamed:@"loader16.png"],
                                             [UIImage imageNamed:@"loader17.png"],
                                             [UIImage imageNamed:@"loader18.png"],
                                             [UIImage imageNamed:@"loader19.png"],nil];
        animatedImageView.animationDuration = 9.0f;
        animatedImageView.animationRepeatCount = 0;
        [animatedImageView startAnimating];
        [loadingCircle addSubview: animatedImageView];
        
        loadingCircle.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2.0f, [UIScreen mainScreen].bounds.size.height/2.0f);
        [self.view addSubview: loadingCircle];
    }
}
-(void)hideLoadingMode
{
    if (loadingCircle)
    {
        [loadingCircle removeFromSuperview];
        loadingCircle = nil;
    }
}

#pragma mark- CustomPopUp Method
-(void)custompopup:(NSString *)strmsg
{
    viewAddcartPopup=[[UIView alloc] init];
    viewAddcartPopup.frame=CGRectMake(10,-20, UIScreen.mainScreen.bounds.size.width-20,60);
    viewAddcartPopup.backgroundColor=[UIColor colorWithRed:255/256.0 green:204/256.0 blue:170/256.0 alpha:1.0];
    
    viewAddcartPopup.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    viewAddcartPopup.layer.shadowOffset = CGSizeMake(0, 2.0f);
    viewAddcartPopup.layer.shadowOpacity = 1.0f;
    [viewAddcartPopup.layer setMasksToBounds:NO];
    [viewAddcartPopup.layer setCornerRadius: 6.0];
    [viewAddcartPopup.layer setBorderWidth:0.0];
    [viewAddcartPopup.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    UILabel *lblC=[[UILabel alloc] init];
    lblC.font=[UIFont fontWithName:@"GothamBook" size:14];
    lblC.textColor=[UIColor blackColor];
    lblC.textAlignment=NSTextAlignmentLeft;
    lblC.backgroundColor=[UIColor clearColor];
    [lblC setFrame:CGRectMake(5,5,viewAddcartPopup.frame.size.width-10,viewAddcartPopup.frame.size.height-10)];
    lblC.text = [NSString stringWithFormat:@"%@",strmsg];
    [lblC setNumberOfLines:4];
    [viewAddcartPopup addSubview:lblC];
    
    
    viewAddcartPopup.layer.zPosition = 1;
    [UIView animateWithDuration:1.0 delay:0.3 options: UIViewAnimationOptionCurveEaseIn animations:^{
        [viewAddcartPopup setFrame:CGRectMake(10,20, UIScreen.mainScreen.bounds.size.width-20,60)];
    } completion:^(BOOL finished){
        
    }];
    [self.view addSubview:viewAddcartPopup];
    
    
    [UIView animateWithDuration:1.0 delay:3 options:0 animations:^{
        viewAddcartPopup.alpha = 0;
    } completion:^(BOOL finished) {
        viewAddcartPopup.hidden = YES;
        [viewAddcartPopup removeFromSuperview];
    }];
    
}

#pragma mark - Asynchronous Image Loading Method
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, NSData *data))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            completionBlock(YES, data);
        } else {
            completionBlock(NO, nil);
        }
    }];
}

#pragma mark - Screen Orientation Method
-(void)OrientationDidChange:(NSNotification*)notification
{
    UIDeviceOrientation Orientation=[[UIDevice currentDevice]orientation];
    if(Orientation==UIDeviceOrientationLandscapeLeft || Orientation==UIDeviceOrientationLandscapeRight)
    {
    }
    else if(Orientation==UIDeviceOrientationPortrait)
    {
    }
    else if(Orientation==UIDeviceOrientationPortraitUpsideDown)
    {
    }
}
-(void) restrictRotation:(BOOL) restriction
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.restrictRotation = restriction;
}
- (BOOL)shouldAutorotate
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark - Press Dashboard Method
- (IBAction)pressDashboard:(id)sender
{
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
        
        if ([[dicTemp valueForKey:@"isManager"] isEqualToString:@"0"]&&[[dicTemp valueForKey:@"isHR"] isEqualToString:@"0"])
        {
            //Do not forget to import DashboardE
            if ([controller isKindOfClass:[DashboardE class]]) {
                
                [self.navigationController popToViewController:controller
                                                      animated:YES];
                return;
            }
        }
        else
        {
            //Do not forget to import DashboardMH
            if ([controller isKindOfClass:[DashboardMH class]]) {
                
                [self.navigationController popToViewController:controller
                                                      animated:YES];
                return;
            }
        }
        
    }
}
@end
