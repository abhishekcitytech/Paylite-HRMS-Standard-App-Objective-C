//
//  DashboardE.m
//  Paylite HRMS
//
//  Created by SANDIPAN on 30/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "DashboardE.h"
#import "XYPieChart.h"

@interface DashboardE ()

@end

@implementation DashboardE

#pragma mark - viewDidAppear Method
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    //------ Account no Check --------//
    [self checkAccountnoActiveDeactive];
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
    app2=(AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    _vwH.layer.shadowRadius = 3.0f;
    _vwH.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _vwH.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _vwH.layer.shadowOpacity = 0.5f;
    _vwH.layer.masksToBounds = NO;
    
    _tabvOverAllDashboard.backgroundView=nil;
    _tabvOverAllDashboard.backgroundColor=[UIColor whiteColor];
    _tabvOverAllDashboard.separatorColor=[UIColor clearColor];
    _tabvOverAllDashboard.showsVerticalScrollIndicator=NO;
    
     NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Press Slide Menu Method
- (IBAction)pressSideMenu:(id)sender
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

#pragma mark - Check Account Active / DeActive Method
-(void)checkAccountnoActiveDeactive
{
    strIdentifier=@"786";
    NSString *strAccountnumber=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strAccountnumber"]];
    NSLog(@"strAccountnumber :%@",strAccountnumber);
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<UserAccountCheck xmlns=\"http://tempuri.org/\"><sAccountNo>%@</sAccountNo>,<sPaltformType>%@</sPaltformType>"
                             "</UserAccountCheck> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",strAccountnumber,@"I"];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/UserAccountCheck" forHTTPHeaderField:@"SOAPAction"];
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


#pragma mark - Check DeviceID Active / DeActive Method
-(void)checkDeviceIDActiveDeactive
{
    strIdentifier=@"986";
    
    NSString *strDeviceID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]];
    NSLog(@"Device Token %@",strDeviceID);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<CheckDeviceExistsOrNot xmlns=\"http://tempuri.org/\"><sEmployeeId>%@</sEmployeeId>,<sDeviceType>%@</sDeviceType>,<sDeviceId>%@</sDeviceId>"
                             "</CheckDeviceExistsOrNot> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],@"I",strDeviceID];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/CheckDeviceExistsOrNot" forHTTPHeaderField:@"SOAPAction"];
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


#pragma mark - Fetch Expiring Doc Method
-(void)downloadExpDoc
{
    strIdentifier=@"1";
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<GetExpiringDocumentslist xmlns=\"http://tempuri.org/\"><sEmployeeId>%@</sEmployeeId>"
                             "</GetExpiringDocumentslist> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]]];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetExpiringDocumentslist" forHTTPHeaderField:@"SOAPAction"];
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

#pragma mark - Fetch Message Board Method
-(void)downloadMSgBoard
{
    strIdentifier=@"2";
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<GetMessageFromBoard xmlns=\"http://tempuri.org/\"><sCompanyId>%@</sCompanyId>,<sEmployeeId>%@</sEmployeeId>"
                             "</GetMessageFromBoard> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]]];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetMessageFromBoard" forHTTPHeaderField:@"SOAPAction"];
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


#pragma mark - Fetch Leave in Today Method
-(void)downloadLeaveinToday
{
    strIdentifier=@"3";
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<GetEmployeesInLeaveTodayList xmlns=\"http://tempuri.org/\"><sCompanyId>%@</sCompanyId>"
                             "</GetEmployeesInLeaveTodayList> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]]];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetEmployeesInLeaveTodayList" forHTTPHeaderField:@"SOAPAction"];
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

#pragma mark - Fetch Request Under Process Method
-(void)downloadRequestUnderProcess
{
    strIdentifier=@"4";
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSString *strIsHRprEmp=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"isHR"]];
    NSLog(@"strIsHRprEmp :%@",strIsHRprEmp);
    if ([strIsHRprEmp isEqualToString:@"1"]){
        strIsHRprEmp=@"1";
    }else{
        strIsHRprEmp=@"0";
    }
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<GetRequestUnderProcessList xmlns=\"http://tempuri.org/\"><sCompanyId>%@</sCompanyId>,<sEmployeeId>%@</sEmployeeId>,<sIsHrOrEmployee>%@</sIsHrOrEmployee>"
                             "</GetRequestUnderProcessList> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],strIsHRprEmp];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetRequestUnderProcessList" forHTTPHeaderField:@"SOAPAction"];
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

#pragma mark - Fetch Todays Punch Method
-(void)downloadTodaysPunch
{
    strIdentifier=@"5";
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *strTodayDate = [formatter stringFromDate:[NSDate date]];
    NSLog(@"strTodayDate :%@",strTodayDate);
    //strTodayDate=@"2017-09-12";
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<GetTodaysPunchDataList xmlns=\"http://tempuri.org/\"><sEmployeeId>%@</sEmployeeId>,<sDate>%@</sDate>"
                             "</GetTodaysPunchDataList> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],strTodayDate];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetTodaysPunchDataList" forHTTPHeaderField:@"SOAPAction"];
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
        if ([elementName isEqualToString:@"GetExpiringDocumentslistResult"])
        {
            arrMDocList=[[NSMutableArray alloc]init];
        }
        if ([elementName isEqualToString:@"Table1"])
        {
            dicMDoc=[[NSMutableDictionary alloc]init];
        }
        if ([elementName isEqualToString:@"EmployeeId"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"EmployeeName"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DocumentId"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DocumentName"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DateOfIssue"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DateOfExpiry"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Status"])
        {
            currentElementValue=[NSMutableString string];
        }
        
    }
    else if ([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"GetMessageFromBoardResult"])
        {
        }
        if ([elementName isEqualToString:@"BoardMessage"])
        {
        }
        if ([elementName isEqualToString:@"EmployeeWiseMessage"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"AllMessage"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if ([strIdentifier isEqualToString:@"3"])
    {
        if ([elementName isEqualToString:@"GetEmployeesInLeaveTodayListResult"])
        {
            arrMEmpOnLevaeName=[[NSMutableArray alloc]init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            dicMEmpOnLevaeType=[[NSMutableDictionary alloc]init];
        }
        if ([elementName isEqualToString:@"EmployeeId"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"EmployeeName"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Department"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"LeaveType"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"FromDate"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"ToDate"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"ISFINALAUTHORIZED"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"IsDirect"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if ([strIdentifier isEqualToString:@"4"])
    {
        if ([elementName isEqualToString:@"GetRequestUnderProcessListResult"])
        {
            slices=[[NSMutableArray alloc]init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            
        }
        if ([elementName isEqualToString:@"PendingLeaveRequest"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"PendingAdvanceRequest"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"PendingExpenseRequest"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"PendingProfileChangeRequest"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if ([strIdentifier isEqualToString:@"5"])
    {
        if ([elementName isEqualToString:@"GetTodaysPunchDataListResult"])
        {
            arrMTodaysPunch=[[NSMutableArray alloc]init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            dicMTodaysPunch=[[NSMutableDictionary alloc]init];
        }
        if ([elementName isEqualToString:@"ID"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"EVENT_DATE"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"PunchTimes"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"InOutFlag"]) 
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if ([strIdentifier isEqualToString:@"786"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"iOSPlatform"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if ([strIdentifier isEqualToString:@"986"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"MessageText"])
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
        if ([elementName isEqualToString:@"Table1"])
        {
            [arrMDocList addObject:dicMDoc];
        }
        if ([elementName isEqualToString:@"EmployeeId"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"EmployeeId"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"EmployeeName"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"EmployeeName"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DocumentId"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"DocumentId"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DocumentName"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"DocumentName"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DateOfIssue"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"DateOfIssue"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DateOfExpiry"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"DateOfExpiry"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Status"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"Status"];
            currentElementValue=nil;
        }
        
    }
    else if ([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"BoardMessage"])
        {
        }
        if ([elementName isEqualToString:@"EmployeeWiseMessage"])
        {
            strBoradMessageEmployewise=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"AllMessage"])
        {
            strBoradMessageAll=currentElementValue;
            currentElementValue=nil;
        }
    }
    else if ([strIdentifier isEqualToString:@"3"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
            [arrMEmpOnLevaeName addObject:dicMEmpOnLevaeType];
        }
        if ([elementName isEqualToString:@"EmployeeId"])
        {
            [dicMEmpOnLevaeType setObject:currentElementValue forKey:@"EmployeeId"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"EmployeeName"])
        {
            [dicMEmpOnLevaeType setObject:currentElementValue forKey:@"EmployeeName"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Department"])
        {
            [dicMEmpOnLevaeType setObject:currentElementValue forKey:@"Department"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"LeaveType"])
        {
            [dicMEmpOnLevaeType setObject:currentElementValue forKey:@"LeaveType"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"FromDate"])
        {
            [dicMEmpOnLevaeType setObject:currentElementValue forKey:@"FromDate"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"ToDate"])
        {
            [dicMEmpOnLevaeType setObject:currentElementValue forKey:@"ToDate"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"ISFINALAUTHORIZED"])
        {
            [dicMEmpOnLevaeType setObject:currentElementValue forKey:@"ISFINALAUTHORIZED"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"IsDirect"])
        {
            [dicMEmpOnLevaeType setObject:currentElementValue forKey:@"IsDirect"];
            currentElementValue=nil;
        }
    }
    else if ([strIdentifier isEqualToString:@"4"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
            /*<PendingLeaveRequest>1</PendingLeaveRequest>
            <PendingAdvanceRequest>0</PendingAdvanceRequest>
            <PendingExpenseRequest>0</PendingExpenseRequest>
            <PendingProfileChangeRequest>5</PendingProfileChangeRequest>*/
        }
        if ([elementName isEqualToString:@"PendingLeaveRequest"])
        {
            if (currentElementValue==0)
            {
                
            }
            else
            {
                [slices addObject:currentElementValue];
            }
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"PendingAdvanceRequest"])
        {
            if (currentElementValue==0)
            {
            }
            else
            {
                [slices addObject:currentElementValue];
            }
            
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"PendingExpenseRequest"])
        {
            if (currentElementValue==0)
            {
            }
            else
            {
                [slices addObject:currentElementValue];
            }
            
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"PendingProfileChangeRequest"])
        {
            if (currentElementValue==0)
            {
            }
            else
            {
                [slices addObject:currentElementValue];
            }
            
            currentElementValue=nil;
        }
    }
    else if ([strIdentifier isEqualToString:@"5"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
            [arrMTodaysPunch addObject:dicMTodaysPunch];
        }
        if ([elementName isEqualToString:@"ID"])
        {
            [dicMTodaysPunch setObject:currentElementValue forKey:@"ID"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"EVENT_DATE"])
        {
            [dicMTodaysPunch setObject:currentElementValue forKey:@"EVENT_DATE"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"PunchTimes"])
        {
            [dicMTodaysPunch setObject:currentElementValue forKey:@"PunchTimes"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"InOutFlag"])
        {
            [dicMTodaysPunch setObject:currentElementValue forKey:@"InOutFlag"];
            currentElementValue=nil;
        }
    }
    else if ([strIdentifier isEqualToString:@"786"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strAccCheckCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strAccCheckText=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"iOSPlatform"])
        {
            strAccPlatform=currentElementValue;
            currentElementValue=nil;
        }
    }
    else if ([strIdentifier isEqualToString:@"986"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strDVCCheckCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strDVCCheckText=currentElementValue;
            currentElementValue=nil;
        }
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        if ([arrMDocList count]==0)
        {
        }
        else
        {
            NSLog(@"arrMDocList :%@",arrMDocList);
            [_tabvOverAllDashboard reloadData];
        }
        [self downloadMSgBoard];
    }
    else if ([strIdentifier isEqualToString:@"2"])
    {
        [self downloadLeaveinToday];
    }
    else if ([strIdentifier isEqualToString:@"3"])
    {
        if ([arrMEmpOnLevaeName count]==0)
        {
        }
        else
        {
            NSLog(@"arrMEmpOnLevaeName :%@",arrMEmpOnLevaeName);
            [_tabvOverAllDashboard reloadData];
        }
        [self downloadRequestUnderProcess];
    }
    else if ([strIdentifier isEqualToString:@"4"])
    {
        NSLog(@"slices >>><<< :%@",slices);
        
        sliceColors=[[NSMutableArray alloc] initWithObjects:[UIColor colorWithRed:224.0/255 green:85.0/255 blue:55.0/255 alpha:1.0],[UIColor colorWithRed:7.0/255 green:159.0/255 blue:246.0/255 alpha:1.0],[UIColor colorWithRed:141.0/255 green:186.0/255 blue:66.0/255 alpha:1.0],[UIColor colorWithRed:246.0/255 green:180.0/255 blue:2.0/255 alpha:1.0], nil];
        
        sliceText = [[NSMutableArray alloc]initWithObjects:@"Leave Request",@"Loan/Advance",@"Expense Claim",@"Change Profile", nil];
        
        [pieChartRight reloadData];
        
        [self downloadTodaysPunch];
        
    }
    else if ([strIdentifier isEqualToString:@"5"])
    {
        if ([arrMTodaysPunch count]==0)
        {
            [_tabvOverAllDashboard reloadData];
        }
        else
        {
            NSLog(@"arrMTodaysPunch :%@",arrMTodaysPunch);
            [_tabvOverAllDashboard reloadData];
            
            //--------------- Today's First Punch ----------------------//
            NSMutableDictionary *dictemp=[arrMTodaysPunch objectAtIndex:0];
            NSLog(@"date time : %@",[dictemp valueForKey:@"PunchTimes"]);
        }
    }
    else  if ([strIdentifier isEqualToString:@"786"])
    {
        NSLog(@"strAccCheckCode:%@",strAccCheckCode);
        int code=[strAccCheckCode intValue];
        if (code==0)
        {
            [self checkDeviceIDActiveDeactive];
           
        }
        else{
            [self openForceLogoutPopup:@"Product license has been de-activated. \n Please contact to your system administrator." idnt:@"786"];
        }
    }
    else  if ([strIdentifier isEqualToString:@"986"])
    {
        NSLog(@"strDVCCheckCode:%@",strAccCheckCode);
        int code=[strDVCCheckCode intValue];
        if (code==0)
        {
            NSLog(@"****************************************Device Active****************************************");
            [self downloadExpDoc];
        }
        else{
            NSLog(@"******************************Device Inactive****************************************");
            [self openForceLogoutPopup:@"You have logged in on another device. \n You will be logged out from here." idnt:@"986"];
        }
    }
}


#pragma mark - UITableView Delegate & DataSource Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    if (section==1)
    {
        return 1;
    }
    if (section==2)
    {
        if ([arrMDocList count]==0)
        {
            return 1;
        }
        else{
            return [arrMDocList count];
        }
    }
    if (section==3)
    {
        return 1;
    }
    if (section==4)
    {
        if ([arrMEmpOnLevaeName count]==0)
        {
            return 1;
        }
        else{
            return [arrMEmpOnLevaeName count];
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
    }
    else if (section==1 || section==2 ||section==3||section==4)
    {
        return 60;
    }
    return 2.50f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2.50f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
    }
    else if (section==1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *imgV1=[[UIImageView alloc] initWithFrame:CGRectMake(8,16,28,28)];
        [imgV1 setImage:[UIImage imageNamed:@"underprocess"]];
        imgV1.backgroundColor=[UIColor clearColor];
        [view addSubview:imgV1];
        
        UILabel *lbl2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV1.frame)+10,17,180,30)];
        lbl2.text=[NSString stringWithFormat:@"%@",@"My Requests"];
        lbl2.textAlignment=NSTextAlignmentLeft;
        lbl2.textColor=[UIColor colorWithRed:30.0/255 green:161.0/255 blue:242.0/255 alpha:1.0];
        lbl2.font=[UIFont fontWithName:@"GothamBook" size:14];
        lbl2.backgroundColor=[UIColor clearColor];
        [view addSubview:lbl2];
        
        return view;
    }
    else if (section==2){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *imgV1=[[UIImageView alloc] initWithFrame:CGRectMake(8,16,28,28)];
        [imgV1 setImage:[UIImage imageNamed:@"expdoc"]];
        imgV1.backgroundColor=[UIColor clearColor];
        [view addSubview:imgV1];
        
        UILabel *lbl2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV1.frame)+10,17,180,30)];
        lbl2.text=[NSString stringWithFormat:@"%@",@"Expiring Documents"];
        lbl2.textAlignment=NSTextAlignmentLeft;
        lbl2.textColor=[UIColor colorWithRed:30.0/255 green:161.0/255 blue:242.0/255 alpha:1.0];
        lbl2.font=[UIFont fontWithName:@"GothamBook" size:14];
        lbl2.backgroundColor=[UIColor clearColor];
        [view addSubview:lbl2];
        return view;
    }
    else if (section==3){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *imgV1=[[UIImageView alloc] initWithFrame:CGRectMake(8,16,28,28)];
        [imgV1 setImage:[UIImage imageNamed:@"msgboard"]];
        imgV1.backgroundColor=[UIColor clearColor];
        [view addSubview:imgV1];
        
        UILabel *lbl2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV1.frame)+10,17,180,30)];
        lbl2.text=[NSString stringWithFormat:@"%@",@"Message Board"];
        lbl2.textAlignment=NSTextAlignmentLeft;
        lbl2.textColor=[UIColor colorWithRed:30.0/255 green:161.0/255 blue:242.0/255 alpha:1.0];
        lbl2.font=[UIFont fontWithName:@"GothamBook" size:14];
        lbl2.backgroundColor=[UIColor clearColor];
        [view addSubview:lbl2];
        return view;
        
    }
    else if (section==4){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *imgV1=[[UIImageView alloc] initWithFrame:CGRectMake(8,16,28,28)];
        [imgV1 setImage:[UIImage imageNamed:@"emponleave"]];
        imgV1.backgroundColor=[UIColor clearColor];
        [view addSubview:imgV1];
        
        UILabel *lbl2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV1.frame)+10,17,230,30)];
        lbl2.text=[NSString stringWithFormat:@"%@",@"Employees on Leave Today"];
        lbl2.textAlignment=NSTextAlignmentLeft;
        lbl2.textColor=[UIColor colorWithRed:30.0/255 green:161.0/255 blue:242.0/255 alpha:1.0];
        lbl2.font=[UIFont fontWithName:@"GothamBook" size:14];
        lbl2.backgroundColor=[UIColor clearColor];
        [view addSubview:lbl2];
        return view;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0){
            return 120;
        }
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            if ([[slices objectAtIndex:0] intValue]==0 && [[slices objectAtIndex:1] intValue]==0 && [[slices objectAtIndex:2] intValue]==0 && [[slices objectAtIndex:3] intValue]==0){
                return 60;
            }
            else{
                return 220;
            }
        }
    }
    else if (indexPath.section==2)
    {
        return 60;
    }
    else if (indexPath.section==3)
    {
        if (indexPath.row==0)
        {
            if ([strBoradMessageAll length]==0){
                return 60;
            }
            else{
                return UITableViewAutomaticDimension;
            }
        }
    }
    else if (indexPath.section==4)
    {
        return 60;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.section==0)
    {
        //punch view
        
        UIButton *btnAttendencePunch=[UIButton buttonWithType:UIButtonTypeCustom];
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
            if (screenSize.height==568.0f){
                //5S
                btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-80,CGRectGetMidY(cell.frame)+30,200,60);
            }
            else if(screenSize.height == 667.0f){
                //6
                btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-80,CGRectGetMidY(cell.frame)+30,200,60);
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-80,CGRectGetMidY(cell.frame)+30,200,60);
            }
            else if(screenSize.height == 812.0f){
                //X
                btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-80,CGRectGetMidY(cell.frame)+30,200,60);
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-60,CGRectGetMidY(cell.frame)+30,200,60);
            }
            else{
                btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-80,CGRectGetMidY(cell.frame)+30,200,60);
            }
        }
        [btnAttendencePunch setTitle:@"Record Attendance" forState:UIControlStateNormal];
        btnAttendencePunch.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16];
        [btnAttendencePunch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnAttendencePunch setBackgroundColor:[UIColor colorWithRed:30.0/256.0 green:161/256.0 blue:242/256.0 alpha:1.0]];
        [btnAttendencePunch addTarget:self action:@selector(pressbtnAttendencePunch:) forControlEvents:UIControlEventTouchUpInside];
        [btnAttendencePunch.layer setMasksToBounds:YES];
        [btnAttendencePunch.layer setCornerRadius: 4.0];
        [btnAttendencePunch.layer setBorderWidth:0.0];
        [btnAttendencePunch.layer setBorderColor:[[UIColor clearColor] CGColor]];
        [cell.contentView addSubview:btnAttendencePunch];
        
        if ([arrMTodaysPunch count]>0)
        {
            UIImageView *imgV1=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(cell.frame)-40,10,32,32)];
            imgV1.backgroundColor=[UIColor clearColor];
            [imgV1 setImage:[UIImage imageNamed:@"Dashboardclock"]];
            [cell.contentView addSubview:imgV1];
            
            UILabel *lbl2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV1.frame)+5,10,80,20)];
            lbl2.textAlignment=NSTextAlignmentLeft;
            lbl2.textColor=[UIColor darkGrayColor];
            lbl2.font=[UIFont fontWithName:@"GothamBook" size:13];
            lbl2.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:lbl2];
            
            UILabel *lbl3=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV1.frame)+5,CGRectGetMaxY(lbl2.frame),80,20)];
            lbl3.textAlignment=NSTextAlignmentLeft;
            lbl3.textColor=[UIColor blackColor];
            lbl3.font=[UIFont fontWithName:@"GothamBook" size:13];
            lbl3.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:lbl3];
            
            NSMutableDictionary *dictemp=[arrMTodaysPunch objectAtIndex:0];
            NSLog(@"date time : %@",[dictemp valueForKey:@"PunchTimes"]);
            
            NSString *str=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"PunchTimes"]];
            NSArray *items = [str componentsSeparatedByString:@","];
            NSString *str1=[items objectAtIndex:0];
            NSString *str2=[items objectAtIndex:1];
            lbl2.text=[NSString stringWithFormat:@"%@",str1];
            lbl3.text=[NSString stringWithFormat:@"%@",str2];
        }
        else
        {
            /*UILabel *lblTopMessage=[[UILabel alloc] initWithFrame:CGRectMake(20,15,tableView.frame.size.width-40,30)];
            lblTopMessage.textAlignment=NSTextAlignmentCenter;
            lblTopMessage.textColor=[UIColor darkGrayColor];
            lblTopMessage.font=[UIFont fontWithName:@"GothamBook" size:15];
            lblTopMessage.text=@"Please record your daily attendance";
            lblTopMessage.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:lblTopMessage];*/
            
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
                if (screenSize.height==568.0f){
                    //5S
                    btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-80,CGRectGetMidY(cell.frame)+20,180,60);
                }
                else if(screenSize.height == 667.0f){
                    //6
                    btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-80,CGRectGetMidY(cell.frame)+20,200,60);
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-80,CGRectGetMidY(cell.frame)+20,200,60);
                }
                else if(screenSize.height == 812.0f){
                    //X
                    btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-80,CGRectGetMidY(cell.frame)+20,200,60);
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-60,CGRectGetMidY(cell.frame)+20,200,60);
                }
                else{
                    btnAttendencePunch.frame=CGRectMake(CGRectGetMidX(cell.frame)-80,CGRectGetMidY(cell.frame)+20,180,60);
                }
            }
        }
        
    }
    else if (indexPath.section==1)
    {
        //under process
        if ([[slices objectAtIndex:0] intValue]==0 && [[slices objectAtIndex:1] intValue]==0 && [[slices objectAtIndex:2] intValue]==0 && [[slices objectAtIndex:3] intValue]==0)
        {
            UILabel *cellHeading1=[[UILabel alloc] initWithFrame:CGRectMake(0,0,_tabvOverAllDashboard.frame.size.width, 60)];
            cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellHeading1.backgroundColor=[UIColor clearColor];
            cellHeading1.textAlignment=NSTextAlignmentCenter;
            cellHeading1.textColor=[UIColor grayColor];
            cellHeading1.text=[NSString stringWithFormat:@"%@",@"There are no pending requests"];
            [cell.contentView addSubview:cellHeading1];
            
        }
        else
        {
            //under process view
            pieChartRight=[[XYPieChart alloc] initWithFrame:CGRectMake(10,20, 200, 190)];
            [pieChartRight setDelegate:self];
            [pieChartRight setDataSource:self];
            [pieChartRight setShowPercentage:NO];
            [pieChartRight setLabelColor:[UIColor whiteColor]];
            [cell.contentView addSubview:pieChartRight];
            [pieChartRight reloadData];
            
            UILabel *lblcolor1;
            //UILabel *lblcolor1Value;
            UIButton *btnLegendsClick;
            
            CGFloat fffY=60;
            for (int i = 0; i < slices.count; i++)
            {
                if ([[slices objectAtIndex:i] isEqualToString:@"0"]){
                    // value Blanks
                }else{
                    // Have value
                    NSString *strColor = [sliceColors objectAtIndex:i];
                    NSString *strText = [sliceText objectAtIndex:i];
                    NSLog(@"strColor%@ , strText%@", strColor,strText);
                    
                    lblcolor1=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pieChartRight.frame)+20,fffY,16,16)];
                    lblcolor1.backgroundColor= [sliceColors objectAtIndex:i];
                    [cell.contentView addSubview:lblcolor1];
                    
                    /*lblcolor1Value=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblcolor1.frame)+5,fffY,150,20)];
                     lblcolor1Value.text=[NSString stringWithFormat:@"%@",strText];
                     lblcolor1Value.textAlignment=NSTextAlignmentLeft;
                     lblcolor1Value.textColor=[UIColor darkGrayColor];
                     lblcolor1Value.font=[UIFont fontWithName:@"GothamBook" size:12];
                     lblcolor1Value.backgroundColor=[UIColor clearColor];
                     [cell.contentView addSubview:lblcolor1Value];*/
                    
                    btnLegendsClick=[UIButton buttonWithType:UIButtonTypeCustom];
                    [btnLegendsClick setFrame:CGRectMake(CGRectGetMaxX(lblcolor1.frame)+5,fffY,150,20)];
                    //[btnLegendsClick setTitle:strText forState:UIControlStateNormal];
                    [btnLegendsClick setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                    btnLegendsClick.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:12];
                    btnLegendsClick.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    btnLegendsClick.backgroundColor=[UIColor clearColor];
                    [btnLegendsClick addTarget:self action:@selector(pressPieChartLegends:) forControlEvents:UIControlEventTouchUpInside];
                    
                    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:strText attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
                    [btnLegendsClick setAttributedTitle:titleString forState:UIControlStateNormal];
                    
                    [cell.contentView addSubview:btnLegendsClick];
                    
                    fffY= CGRectGetMaxY(lblcolor1.frame)+16;
                }
            }
        }
    }
    else if (indexPath.section==2)
    {
        //expiring doc
        if ([arrMDocList count]==0)
        {
            UILabel *cellHeading1=[[UILabel alloc] initWithFrame:CGRectMake(0,0,_tabvOverAllDashboard.frame.size.width, 60)];
            cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellHeading1.backgroundColor=[UIColor clearColor];
            cellHeading1.textAlignment=NSTextAlignmentCenter;
            cellHeading1.textColor=[UIColor grayColor];
            cellHeading1.text=[NSString stringWithFormat:@"%@",@"There are no expiring documents"];
            [cell.contentView addSubview:cellHeading1];
            
        }
        else
        {
            NSMutableDictionary *dictemp=[arrMDocList objectAtIndex:indexPath.row];
            
            UILabel *cellHeading1=[[UILabel alloc] initWithFrame:CGRectMake(8,7,200, 17)];
            UILabel *cellHeading2=[[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(cellHeading1.frame)+5, 110, 17)];
            
            UIImageView *imgVstatus=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cellHeading1.frame)+10,18,20,20)];
            imgVstatus.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:imgVstatus];
            
            UILabel *lblStatus=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgVstatus.frame)+2,15, 120, 30)];
            
            
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f)
                {
                    //5S
                    cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
                    cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
                }
                else if(screenSize.height == 667.0f)
                {
                    //6
                    cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
                    cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
                }
                else if(screenSize.height == 736.0f)
                {
                    //6Plus
                    cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
                    cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
                }
                else if(screenSize.height == 812.0f)
                {
                    //X
                    cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
                    cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
                    cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
                }
                else
                {
                    cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
                    cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
                }
            }
            
            cellHeading1.backgroundColor=[UIColor clearColor];
            cellHeading2.backgroundColor=[UIColor clearColor];
            lblStatus.backgroundColor=[UIColor clearColor];
            lblStatus.numberOfLines=2;
            
            [cell.contentView addSubview:lblStatus];
            [cell.contentView addSubview:cellHeading1];
            [cell.contentView addSubview:cellHeading2];
            
            cellHeading1.text=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"DocumentName"]];
            cellHeading2.text=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"DateOfExpiry"]];
            
            NSString *strStatus=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"Status"]];
            if ([strStatus isEqualToString:@"0"]) {
                //Already expired
                lblStatus.textColor=[UIColor redColor];
                lblStatus.text=[NSString stringWithFormat:@"%@",@"Expired"];
                [imgVstatus setImage:[UIImage imageNamed:@"warningRed"]];
            }
            else if ([strStatus isEqualToString:@"1"]) {
                //Expiring Today
                lblStatus.textColor=[UIColor darkGrayColor];
                lblStatus.text=[NSString stringWithFormat:@"%@",@"Expiring Today"];
                [imgVstatus setImage:[UIImage imageNamed:@"warningGray"]];
            }
            else{
                //Expiring withing 15 days
                lblStatus.textColor=[UIColor darkGrayColor];
                //lblStatus.text=[NSString stringWithFormat:@"Expiring withing %@ days",strStatus];
                lblStatus.text=@"About to Expire";
                [imgVstatus setImage:[UIImage imageNamed:@"warningGray"]];
            }
            
            cellHeading1.textColor=[UIColor darkGrayColor];
            cellHeading2.textColor=[UIColor blackColor];
        }
    }
    if (indexPath.section==3)
    {
        //message board
        if ([strBoradMessageAll length]==0)
        {
            cell.textLabel.text=@"No message to display";
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
            cell.textLabel.textColor=[UIColor grayColor];
            cell.textLabel.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
        else
        {
            cell.textLabel.text=strBoradMessageAll;
            cell.textLabel.numberOfLines=20;
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            cell.textLabel.textAlignment=NSTextAlignmentLeft;
            cell.textLabel.textColor=[UIColor darkGrayColor];
            cell.textLabel.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
    }
    else if (indexPath.section==4)
    {
        //Employess Today On Leave
        
        if ([arrMEmpOnLevaeName count]==0)
        {
            UILabel *cellHeading1=[[UILabel alloc] initWithFrame:CGRectMake(0,0,_tabvOverAllDashboard.frame.size.width, 60)];
            cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellHeading1.backgroundColor=[UIColor clearColor];
            cellHeading1.textAlignment=NSTextAlignmentCenter;
            cellHeading1.textColor=[UIColor grayColor];
            cellHeading1.text=[NSString stringWithFormat:@"%@",@"No employee on leave today"];
            [cell.contentView addSubview:cellHeading1];
        }
        else
        {
            NSMutableDictionary *dictemp=[arrMEmpOnLevaeName objectAtIndex:indexPath.row];
            
            //Employee Name
            UILabel *lbl1name=[[UILabel alloc] initWithFrame:CGRectMake(10,10,_tabvOverAllDashboard.frame.size.width/2,40)];
            //Leave Type
            UILabel *lbl2type=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lbl1name.frame)+10,10,_tabvOverAllDashboard.frame.size.width/2,40)];
            
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    lbl1name.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lbl2type.font=[UIFont fontWithName:@"GothamBook" size:13];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    lbl1name.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lbl2type.font=[UIFont fontWithName:@"GothamBook" size:13];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    lbl1name.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lbl2type.font=[UIFont fontWithName:@"GothamBook" size:13];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    lbl1name.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lbl2type.font=[UIFont fontWithName:@"GothamBook" size:13];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    lbl1name.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lbl2type.font=[UIFont fontWithName:@"GothamBook" size:13];
                }
                else{
                    lbl1name.font=[UIFont fontWithName:@"GothamBook" size:13];
                    lbl2type.font=[UIFont fontWithName:@"GothamBook" size:13];
                }
            }
            
            lbl1name.textAlignment=NSTextAlignmentLeft;
            lbl2type.textAlignment=NSTextAlignmentCenter;
            lbl1name.textColor=[UIColor darkTextColor];
            lbl2type.textColor=[UIColor darkTextColor];
            lbl1name.backgroundColor=[UIColor clearColor];
            lbl2type.backgroundColor=[UIColor clearColor];
            
            lbl1name.text=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"EmployeeName"]];
            lbl2type.text=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"LeaveType"]];
            
            [cell.contentView addSubview:lbl1name];
            [cell.contentView addSubview:lbl2type];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)])
    {
        CGFloat cornerRadius = 2.f;
        cell.backgroundColor = UIColor.clearColor;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGRect bounds = CGRectInset(cell.bounds,0, 0);
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
        {
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
        }
        else if (indexPath.row == 0)
        {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            addLine = YES;
        }
        else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
        {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
        }
        else
        {
            CGPathAddRect(pathRef, nil, bounds);
            addLine = YES;
        }
        
        layer.path = pathRef;
        CFRelease(pathRef);
        //set the border color
        layer.strokeColor = [UIColor lightGrayColor].CGColor;
        //set the border width
        layer.lineWidth = 0.4;
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.0f].CGColor;
        
        
        if (addLine == YES) {
            CALayer *lineLayer = [[CALayer alloc] init];
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
            [layer addSublayer:lineLayer];
        }
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        [testView.layer insertSublayer:layer atIndex:0];
        testView.backgroundColor = UIColor.clearColor;
        cell.backgroundView = testView;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - PieChartLegends Click Method
-(void)pressPieChartLegends:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if ([btn.titleLabel.text isEqualToString:@"Leave Request"]){
        MyLeave *objDemo;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeave5S" bundle:nil];
            }
            else if(screenSize.height == 667.0f){
                //6
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeave6" bundle:nil];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeave6Plus" bundle:nil];
            }
            else if(screenSize.height == 812.0f){
                //X
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeaveX" bundle:nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeaveXSMAX" bundle:nil];
            }
            else{
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeave" bundle:nil];
            }
        }
        else
        {
        }
        [self.navigationController pushViewController:objDemo animated:YES];
    }
    else if ([btn.titleLabel.text isEqualToString:@"Loan/Advance"]){
        MyAdvance *objDemo;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvance5S" bundle:nil];
            }
            else if(screenSize.height == 667.0f){
                //6
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvance6" bundle:nil];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvance6Plus" bundle:nil];
            }
            else if(screenSize.height == 812.0f){
                //X
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvanceX" bundle:nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvanceXSMAX" bundle:nil];
            }
            else{
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvance" bundle:nil];
            }
        }
        else
        {
        }
        [self.navigationController pushViewController:objDemo animated:YES];
    }
    else if ([btn.titleLabel.text isEqualToString:@"Expense Claim"]){
        MyExpenseClaim *objDemo;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim5S" bundle:nil];
            }
            else if(screenSize.height == 667.0f){
                //6
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim6" bundle:nil];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim6Plus" bundle:nil];
            }
            else if(screenSize.height == 812.0f){
                //X
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaimX" bundle:nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaimXSMAX" bundle:nil];
            }
            else{
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim" bundle:nil];
            }
        }
        else
        {
        }
        [self.navigationController pushViewController:objDemo animated:YES];
    }
    else if ([btn.titleLabel.text isEqualToString:@"Change Profile"])
    {
        ChangeProfile *objDemo;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfile5S" bundle:nil];
            }
            else if(screenSize.height == 667.0f){
                //6
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfile6" bundle:nil];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfile6Plus" bundle:nil];
            }
            else if(screenSize.height == 812.0f){
                //X
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfileX" bundle:nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfileXSMAX" bundle:nil];
            }
            else{
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfile" bundle:nil];
            }
        }
        else
        {
        }
        [self.navigationController pushViewController:objDemo animated:YES];
    }
}

#pragma mark - Go To Attendnace Screen
-(void)pressbtnAttendencePunch:(id)sender
{
    TodaysAttendance *objDemo;
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance5S" bundle:nil];
        }
        else if(screenSize.height == 667.0f){
            //6
            objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance6" bundle:nil];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance6Plus" bundle:nil];
        }
        else if(screenSize.height == 812.0f){
            //X
            objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendanceX" bundle:nil];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendanceXSMAX" bundle:nil];
        }
        else{
            objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance" bundle:nil];
        }
    }
    else
    {
    }
    [self.navigationController pushViewController:objDemo animated:YES];
}

#pragma mark - XYPieChart DataSource && Delegate Method
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return slices.count;
}
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    NSInteger isVal=[[slices objectAtIndex:index] intValue];
    if (isVal==0) {
        return 0;
    }
    else{
        return [[slices objectAtIndex:index] intValue];
    }
    
}
- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    NSInteger isVal=[[slices objectAtIndex:index] intValue];
    if (isVal==0) {
        return 0;
    }
    else{
        return [sliceColors objectAtIndex:(index % sliceColors.count)];
    }
}
- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index
{
    //NSLog(@"values text :%@",[slices objectAtIndex:index]);
    NSString *strVal=[NSString stringWithFormat:@"%@",[slices objectAtIndex:index]];
    //NSLog(@"strVal slices Value:%@",strVal);
    
    if ([strVal isEqualToString:@"0"]) {
        return @"";
    }
    else
    {
        return [NSString stringWithFormat:@"%@",[slices objectAtIndex:index]];
    }
    
}
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    //NSLog(@"will select slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    //NSLog(@"will deselect slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    //NSLog(@"did deselect slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    //NSLog(@"did select slice at index %lu",(unsigned long)index);
    //self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[self.slices objectAtIndex:index]];
    
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


#pragma mark - ForceLogout Popup Method
-(void)openForceLogoutPopup:(NSString *)strMessage idnt:(NSString *)strIdentifier
{
    ctrlFRCLThanksPop=[[UIControl alloc] initWithFrame:CGRectMake(0,0,screenWidth,screenHeight)];
    ctrlFRCLThanksPop.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:ctrlFRCLThanksPop];
    
    viewFRCLThanksPopOverall=[[UIView alloc] init];
    viewFRCLThanksPopOverall.frame=CGRectMake(0,0,ctrlFRCLThanksPop.frame.size.width,ctrlFRCLThanksPop.frame.size.height);
    viewFRCLThanksPopOverall.backgroundColor =[UIColor whiteColor];
    [ctrlFRCLThanksPop addSubview:viewFRCLThanksPopOverall];
    
    viewFRCLThanksPopTop=[[UIView alloc] init];
    viewFRCLThanksPopTop.frame=CGRectMake(0,0,ctrlFRCLThanksPop.frame.size.width,ctrlFRCLThanksPop.frame.size.height/2+50);
    viewFRCLThanksPopTop.backgroundColor =[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
    [ctrlFRCLThanksPop addSubview:viewFRCLThanksPopTop];
    
    UIImageView *imgv=[[UIImageView alloc] init];
    imgv.frame=CGRectMake(0, 0, 64, 64);
    imgv.center=CGPointMake(viewFRCLThanksPopTop.frame.size.width/2, viewFRCLThanksPopTop.frame.size.height/2-28);
    [imgv setImage:[UIImage imageNamed:@"warning"]];
    [viewFRCLThanksPopTop addSubview:imgv];
    
    lblFRCLMessage=[[UILabel alloc] init];
    lblFRCLMessage.frame=CGRectMake(0, CGRectGetMaxY(imgv.frame)+60, ctrlFRCLThanksPop.frame.size.width,50);
    lblFRCLMessage.textAlignment=NSTextAlignmentCenter;
    lblFRCLMessage.textColor=[UIColor whiteColor];
    lblFRCLMessage.text=strMessage;
    lblFRCLMessage.numberOfLines=10;
    lblFRCLMessage.backgroundColor=[UIColor clearColor];
    [viewFRCLThanksPopTop addSubview:lblFRCLMessage];
    
    btnFRCLLogout=[UIButton buttonWithType:UIButtonTypeCustom];
    btnFRCLLogout.frame=CGRectMake(CGRectGetMidX(self.view.frame)-50,CGRectGetMaxY(viewFRCLThanksPopOverall.frame)-140,100,40);
    [btnFRCLLogout addTarget:self action:@selector(pressFRCL:) forControlEvents:UIControlEventTouchUpInside];
    [btnFRCLLogout setBackgroundColor:[UIColor colorWithRed:30/256.0 green:161/256.0 blue:242/256.0 alpha:1.0]];
    if ([strIdentifier isEqualToString:@"786"]) {
        [btnFRCLLogout setTitle:@"Close" forState:UIControlStateNormal];
    }
    else if ([strIdentifier isEqualToString:@"986"]) {
        [btnFRCLLogout setTitle:@"Ok" forState:UIControlStateNormal];
    }
    btnFRCLLogout.layer.cornerRadius=4.0;
    btnFRCLLogout.layer.masksToBounds=YES;
    [btnFRCLLogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewFRCLThanksPopOverall addSubview:btnFRCLLogout];
}
-(void)pressFRCL:(id)sender
{
    [ctrlFRCLThanksPop removeFromSuperview];
    if ([strIdentifier isEqualToString:@"786"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:strAccCheckCode forKey:@"isAccountActiveDeactiveiOSPlatform"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    else if ([strIdentifier isEqualToString:@"986"]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
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

@end
