//
//  AttendanceReport.m
//  Paylite HR
//
//  Created by Sandipan on 16/02/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "AttendanceReport.h"

@interface AttendanceReport ()

@end

@implementation AttendanceReport

#pragma mark - viewDidAppear Method
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
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
    
    [self createViewDetail];
    
    NSDate *currentdate=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    txtFromDate.text =[formatter stringFromDate:currentdate];
    txtToDate.text =[formatter stringFromDate:currentdate];
    NSLog(@"txtFromDate %@",txtFromDate.text);
    NSLog(@"txtFromDate %@",txtToDate.text);
    [self downloadattendanceHistoryPunch:txtFromDate.text todt:txtToDate.text];
   
    if (viewDetail2.isHidden==NO) {
        viewDetail2.hidden=YES;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - press Back Method
- (IBAction)pressBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Fetch Attendance History Method
-(void)downloadattendanceHistoryPunch:(NSString *)strFormdate todt:(NSString *)strTodate
{
    strIdentifier=@"1";
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
                             "<GetDailyAttendancePunchSummary xmlns=\"http://tempuri.org/\"><sEmployeeID>%@</sEmployeeID>,<sFromDate>%@</sFromDate>,<sToDate>%@</sToDate>"
                             "</GetDailyAttendancePunchSummary> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],strFormdate,strTodate];

    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetDailyAttendancePunchSummary" forHTTPHeaderField:@"SOAPAction"];
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
    if([strIdentifier isEqualToString:@"1"])
    {
        if ([elementName isEqualToString:@"getemployeeleaveresult"])
        {
            NSLog(@"rootis called..");
        }
        if ([elementName isEqualToString:@"employeeleave"])
        {
            NSLog(@"employeeleave is called..");
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"FileLocation"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if ([strIdentifier isEqualToString:@"2"])
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
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentElementValue appendString:string];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([strIdentifier isEqualToString:@"1"])
    {
        if ([elementName isEqualToString:@"employeeleave"])
        {
            NSLog(@"employeeleave is called..");
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strMesgCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strMesgCodeTEXT=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"FileLocation"])
        {
            strFileLoctn=currentElementValue;
            currentElementValue=nil;
        }
    }
    else if ([strIdentifier isEqualToString:@"2"])
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
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if([strIdentifier isEqualToString:@"1"])
    {
        int code=[strMesgCode intValue];
        if (code==0)
        {
            NSLog(@"OutstandingAdvancefilelocation url--%@",strFileLoctn);
            
            [self restrictRotation:YES];
            //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
            
            [self viewPdfReader];
        }
        else
        {
           
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:strMesgCodeTEXT
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
        if ([arrMTodaysPunch count]>0)
        {
            /*NSMutableDictionary *dictemp=[arrMTodaysPunch objectAtIndex:0];
            //NSLog(@"First date time : %@",[dictemp valueForKey:@"PunchTimes"]);
            
            NSString *str=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"PunchTimes"]];
            NSArray *items = [str componentsSeparatedByString:@","];
            //NSString *str1=[items objectAtIndex:0];
            NSString *str2=[items objectAtIndex:1];
            strPunchInTime=[NSString stringWithFormat:@"%@",str2];
            
            NSUInteger myCount = [arrMTodaysPunch count];
            if (myCount==1) {
                //only one punch data in list
                strPunchOutTime=@"";
            }else{
                NSMutableDictionary *dictemp1=[arrMTodaysPunch objectAtIndex:myCount-1];
                //NSLog(@"Last date time : %@",[dictemp1 valueForKey:@"PunchTimes"]);
                
                NSString *str22=[NSString stringWithFormat:@"%@",[dictemp1 valueForKey:@"PunchTimes"]];
                NSArray *items22 = [str22 componentsSeparatedByString:@","];
                //NSString *str122=[items22 objectAtIndex:0];
                NSString *str222=[items22 objectAtIndex:1];
                strPunchOutTime=[NSString stringWithFormat:@"%@",str222];
            }*/
        }
        else
        {
        }
    }
}


#pragma mark - ViewDetail Attendance
-(void)createViewDetail
{
    if (viewDetail2!=nil) {
        [viewDetail2 removeFromSuperview];
    }
    viewDetail2 = [[UIView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(_vwH.frame)+10,UIScreen.mainScreen.bounds.size.width-20,220)];
    viewDetail2.backgroundColor=[UIColor whiteColor];
    [viewDetail2.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [viewDetail2.layer setBorderWidth: 0.5];
    [viewDetail2.layer setCornerRadius:4.0f];
    [viewDetail2.layer setMasksToBounds:YES];
    [self.view addSubview:viewDetail2];
    
    txtFromDate=[[UITextField alloc] initWithFrame:CGRectMake(20,10,viewDetail2.frame.size.width-40,44)];
    [txtFromDate setBorderStyle:UITextBorderStyleNone];
    txtFromDate.textAlignment=NSTextAlignmentLeft;
    txtFromDate.textColor=[UIColor darkGrayColor];
    txtFromDate.delegate=self;
    txtFromDate.placeholder=@"From Date";
    txtFromDate.font=[UIFont fontWithName:@"GothamBook" size:14.0];
    txtFromDate.backgroundColor=[UIColor whiteColor];
    [viewDetail2 addSubview:txtFromDate];
    
    CALayer *border2 = [CALayer layer];
    CGFloat borderWidth2 = 0.5;
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.frame = CGRectMake(0, txtFromDate.frame.size.height - borderWidth2, txtFromDate.frame.size.width, txtFromDate.frame.size.height);
    border2.borderWidth = borderWidth2;
    [txtFromDate.layer addSublayer:border2];
    txtFromDate.layer.masksToBounds = YES;
    
    UIImageView *imgvCal1=[[UIImageView alloc]init];
    [imgvCal1 setFrame:CGRectMake(CGRectGetWidth(txtFromDate.frame)-32,10,24,24)];
    [imgvCal1 setImage:[UIImage imageNamed:@"cal"]];
    [txtFromDate addSubview:imgvCal1];
    
    txtToDate=[[UITextField alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(txtFromDate.frame)+10,viewDetail2.frame.size.width-40,44)];
    [txtToDate setBorderStyle:UITextBorderStyleNone];
    txtToDate.textAlignment=NSTextAlignmentLeft;
    txtToDate.textColor=[UIColor darkGrayColor];
    txtToDate.delegate=self;
    txtToDate.placeholder=@"To Date";
    txtToDate.font=[UIFont fontWithName:@"GothamBook" size:14.0];
    txtToDate.backgroundColor=[UIColor whiteColor];
    [viewDetail2 addSubview:txtToDate];
    
    CALayer *border3 = [CALayer layer];
    CGFloat borderWidth3 = 0.5;
    border3.borderColor = [UIColor lightGrayColor].CGColor;
    border3.frame = CGRectMake(0, txtToDate.frame.size.height - borderWidth3, txtToDate.frame.size.width, txtToDate.frame.size.height);
    border3.borderWidth = borderWidth3;
    [txtToDate.layer addSublayer:border3];
    txtToDate.layer.masksToBounds = YES;
    
    UIImageView *imgvCal2=[[UIImageView alloc]init];
    [imgvCal2 setFrame:CGRectMake(CGRectGetWidth(txtToDate.frame)-32,10,24,24)];
    [imgvCal2 setImage:[UIImage imageNamed:@"cal"]];
    [txtToDate addSubview:imgvCal2];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.barTintColor=[UIColor whiteColor];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(Next)],
                           nil];
    [numberToolbar sizeToFit];
    txtFromDate.inputAccessoryView = numberToolbar;
    
    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.barTintColor=[UIColor whiteColor];
    numberToolbar1.items = [NSArray arrayWithObjects:
                            [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancell)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(Done)],
                            nil];
    [numberToolbar1 sizeToFit];
    txtToDate.inputAccessoryView = numberToolbar1;
    
    btnGenerate=[UIButton buttonWithType:UIButtonTypeCustom];
    btnGenerate.frame=CGRectMake(0,viewDetail2.frame.size.height-50,viewDetail2.frame.size.width,50);
    [btnGenerate setTitle:@"Generate" forState:UIControlStateNormal];
    [btnGenerate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnGenerate.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16.0];
    btnGenerate.tag=10002;
    [btnGenerate setBackgroundColor:[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0]];
    [btnGenerate addTarget:self action:@selector(pressGenerateReport:) forControlEvents:UIControlEventTouchUpInside];
    [viewDetail2 addSubview:btnGenerate];
}
-(void)pressGenerateReport:(id)sender
{
    UITextField *txtfld=(UITextField *)actvtextbox;
    [txtfld resignFirstResponder];
    
    UIButton *btn =(UIButton *)sender;
    NSLog(@"btn tag %ld",btn.tag);
    
    if ([txtFromDate.text isEqualToString:@""] || [txtToDate.text isEqualToString:@""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please select valid dates."
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
        NSLog(@"txtFromDate %@",txtFromDate.text);
        NSLog(@"txtFromDate %@",txtToDate.text);
        
        [self downloadattendanceHistoryPunch:txtFromDate.text todt:txtToDate.text];
    }
}

#pragma mark - Create UIDatePicker Method
- (void) initializeTextFieldInputView1
{
    datePicker1 = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    
    if ( [txtFromDate.text isEqualToString:@""])
    {
        datePicker1.date=[NSDate date];
    }
    else
    {
        NSString *dateStr =txtFromDate.text;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *date = [dateFormat dateFromString:dateStr];
        datePicker1.date=date;
    }
    
    datePicker1.backgroundColor = [UIColor whiteColor];
    [datePicker1 addTarget:self action:@selector(dateUpdated1:) forControlEvents:UIControlEventValueChanged];
    txtFromDate.inputView = datePicker1;
}
- (void) dateUpdated1:(UIDatePicker *)datePicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    txtFromDate.text =[formatter stringFromDate:datePicker.date];
}
- (void) initializeTextFieldInputView2
{
    datePicker2 = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker2.datePickerMode = UIDatePickerModeDate;
    
    if ( [txtFromDate.text isEqualToString:@""])
    {
        datePicker1.date=[NSDate date];
    }
    else  if (  ![txtToDate.text isEqualToString:@""])
    {
        NSString *dateStr =txtToDate.text;
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *date = [dateFormat dateFromString:dateStr];
        datePicker2.date=date;
    }
    else
    {
        NSString *dateStr =txtFromDate.text;
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *datef = [dateFormat dateFromString:dateStr];
        datePicker2.date=datef;
    }
    datePicker2.backgroundColor = [UIColor whiteColor];
    [datePicker2 addTarget:self action:@selector(dateUpdated2:) forControlEvents:UIControlEventValueChanged];
    txtToDate.inputView = datePicker2;
}
- (void) dateUpdated2:(UIDatePicker *)datePicker
{
    if ([strComparedate isEqualToString:@"1"]) {
        txtToDate.text=@"";
    }else{
    }
}

#pragma mark - Next/Cancel/Done/Cancel Press Method
-(void)Next
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    txtFromDate.text =[formatter stringFromDate:datePicker1.date];
    [self initializeTextFieldInputView2];
    
    UITextField *txtfld=(UITextField *)actvtextbox;
    if (txtfld==txtFromDate)
    {
        txtfld=txtToDate;
    }
    [txtfld becomeFirstResponder];
}
-(void)cancel
{
    UITextField *txtfld=(UITextField *)actvtextbox;
    [txtfld resignFirstResponder];
}
-(void)Done
{
    strComparedate=@"";
    UITextField *txtfld=(UITextField *)actvtextbox;
    [txtfld resignFirstResponder];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *FromDate = [dateFormatter dateFromString:txtFromDate.text];
    NSDate *ToDate = [dateFormatter dateFromString:txtToDate.text];
    
    result = [ToDate compare:FromDate];
    if(result==NSOrderedAscending)
    {
        NSLog(@"today is less");
        strComparedate=@"1";
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please select valid dates."
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
    
    if ([strComparedate isEqualToString:@"1"])
    {
        txtToDate.text=@"";
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        txtToDate.text =[formatter stringFromDate:datePicker2.date];
    }
}
-(void)cancell
{
    UITextField *txtfld=(UITextField *)actvtextbox;
    [txtfld resignFirstResponder];
}

#pragma mark - UITextField Delegate Method
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == txtFromDate)
    {
        [self initializeTextFieldInputView1];
    }
    else if (textField == txtToDate)
    {
        [self initializeTextFieldInputView2];
    }
    actvtextbox=textField;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == txtFromDate)
    {
    }
    else if (textField == txtToDate)
    {
    }
    actvtextbox=textField;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField==txtFromDate)
    {
        [datePicker1 removeFromSuperview];
        datePicker1=nil;
    }
    else if (textField==txtToDate)
    {
        [datePicker2 removeFromSuperview];
        datePicker2=nil;
    }
    else
    {
        
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}



#pragma mark - Screen Orientation Method
/*-(void)OrientationDidChange:(NSNotification*)notification
 {
 UIDeviceOrientation Orientation=[[UIDevice currentDevice]orientation];
 //UIDeviceOrientationUnknown,
 //UIDeviceOrientationPortrait,
 //UIDeviceOrientationPortraitUpsideDown,
 //UIDeviceOrientationLandscapeLeft,
 //UIDeviceOrientationLandscapeRight,
 //UIDeviceOrientationFaceUp,
 //UIDeviceOrientationFaceDown
 
 if(Orientation==UIDeviceOrientationLandscapeLeft || Orientation==UIDeviceOrientationLandscapeRight){
 NSLog(@"UIDeviceOrientationLandscapeLeft / UIDeviceOrientationLandscapeRight");
 }
 else if(Orientation==UIDeviceOrientationPortrait){
 NSLog(@"UIDeviceOrientationPortrait");
 }
 else if(Orientation==UIDeviceOrientationPortraitUpsideDown){
 NSLog(@"UIDeviceOrientationPortraitUpsideDown");
 }
 else{
 NSLog(@"Nothing");
 }
 
 [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
 [UINavigationController attemptRotationToDeviceOrientation];
 }*/
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

#pragma mark - Create Leave Balance WebView PopUp Method
-(void)viewPdfReader
{
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    [UINavigationController attemptRotationToDeviceOrientation];
    
    mainBg = [[UIView alloc] initWithFrame:CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height)];
    mainBg.backgroundColor =[UIColor whiteColor];
    
    bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,mainBg.frame.size.width,64)];
    bgVwHeader.backgroundColor =[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
    [mainBg addSubview:bgVwHeader];
    
    
    webViewPdfReader=[[UIWebView alloc] initWithFrame:CGRectMake(0,84, mainBg.frame.size.width, mainBg.frame.size.height-84)];
    NSURL *url = [NSURL URLWithString:strFileLoctn];
    webViewPdfReader.scalesPageToFit=YES;
    webViewPdfReader.delegate=self;
    [webViewPdfReader setBackgroundColor:[UIColor whiteColor]];
    [webViewPdfReader.scrollView setZoomScale:8.0 animated:NO];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webViewPdfReader loadRequest:requestObj];
    [mainBg addSubview:webViewPdfReader];
    
    btnDonepdf=[UIButton buttonWithType:UIButtonTypeCustom];
    btnDonepdf.frame=CGRectMake(8, 28, 60, 28);
    [btnDonepdf setBackgroundColor:[UIColor clearColor]];
    [btnDonepdf setTitle:@"Done" forState:UIControlStateNormal];
    [btnDonepdf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnDonepdf.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16.0];
    [btnDonepdf addTarget:self action:@selector(donepdf:) forControlEvents:UIControlEventTouchUpInside];
    [btnDonepdf clipsToBounds];
    [bgVwHeader addSubview:btnDonepdf];
    
    btnPrintpdf=[UIButton buttonWithType:UIButtonTypeCustom];
    btnPrintpdf.frame=CGRectMake(CGRectGetMaxX(bgVwHeader.frame)-94,28,24,24);
    [btnPrintpdf setBackgroundColor:[UIColor clearColor]];
    [btnPrintpdf setBackgroundImage:[UIImage imageNamed:@"printerpdf"] forState:UIControlStateNormal];
    [btnPrintpdf addTarget:self action:@selector(printpdf:) forControlEvents:UIControlEventTouchUpInside];
    [btnPrintpdf clipsToBounds];
    [bgVwHeader addSubview:btnPrintpdf];
    
    btnEmailpdf=[UIButton buttonWithType:UIButtonTypeCustom];
    btnEmailpdf.frame=CGRectMake(CGRectGetMaxX(bgVwHeader.frame)-40,28,24,24);
    [btnEmailpdf setBackgroundColor:[UIColor clearColor]];
    [btnEmailpdf setBackgroundImage:[UIImage imageNamed:@"emailpdf"] forState:UIControlStateNormal];
    [btnEmailpdf addTarget:self action:@selector(emailpdf:) forControlEvents:UIControlEventTouchUpInside];
    [btnEmailpdf clipsToBounds];
    [bgVwHeader addSubview:btnEmailpdf];
    
    [self.view addSubview:mainBg];
    [self showLoadingMode];
}
-(void)donepdf:(UIButton *)sender
{
    if (viewDetail2.isHidden==YES) {
        viewDetail2.hidden=NO;
    }
    [mainBg removeFromSuperview];
    [self restrictRotation:NO];
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    [UINavigationController attemptRotationToDeviceOrientation];
}
-(void)printpdf:(UIButton *)sender
{
    [mainBg removeFromSuperview];
    [self restrictRotation:NO];
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    [UINavigationController attemptRotationToDeviceOrientation];
    if (viewDetail2.isHidden==YES) {
        viewDetail2.hidden=NO;
    }
    [self performSelector:@selector(executePrintOperation) withObject:nil afterDelay:0.2];
}
-(void)executePrintOperation
{
    NSURL *url = [NSURL URLWithString:strFileLoctn];
    NSLog(@"advancefilelocation url:%@",url);
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self printPDF:urlData];
}
-(void)emailpdf:(UIButton *)sender
{
    [mainBg removeFromSuperview];
    [self restrictRotation:NO];
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    [UINavigationController attemptRotationToDeviceOrientation];
    if (viewDetail2.isHidden==YES) {
        viewDetail2.hidden=NO;
    }
    [self performSelector:@selector(executeEmailOperation) withObject:nil afterDelay:0.2];
}
-(void)executeEmailOperation
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        if ([mailClass canSendMail])
        {
            NSData *AttchedFiledate =[[NSData alloc]init];
            AttchedFiledate = [NSData dataWithContentsOfURL:[NSURL URLWithString:strFileLoctn]];
            [self showEmail:AttchedFiledate];
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        [self launchMailAppOnDevice];
    }
}
- (void)printPDF:(NSData*)pdfData{
    UIPrintInteractionController *printer=[UIPrintInteractionController sharedPrintController];
    UIPrintInfo *info = [UIPrintInfo printInfo];
    info.orientation = UIPrintInfoOrientationPortrait;
    info.outputType = UIPrintInfoOutputGeneral;
    info.jobName=@"CadabraCorp.pdf";
    info.duplex=UIPrintInfoDuplexLongEdge;
    printer.printInfo = info;
    printer.printingItem=pdfData;
    
    UIPrintInteractionCompletionHandler completionHandler =
    ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
        if (!completed && error)
            NSLog(@"FAILED! error = %@",[error localizedDescription]);
    };
    [printer presentAnimated:YES completionHandler:completionHandler];
}
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:?cc=&subject=Paylite HRMS Oustanding Advance!";
    NSString *strBodymessage=[NSString stringWithFormat:@"%@\n\n%@",@"Hello Sir,",@"please check your attached oustanding advance report."];
    NSString *body = [NSString stringWithFormat:@"&body=%@",strBodymessage];
    NSString *email = [NSString stringWithFormat:@"%@%@\n\n%@", recipients, body,strFileLoctn];
    //email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    email = [email stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email] options:@{} completionHandler:nil];
}
- (void)showEmail:(NSData*)file
{
    
    NSString *emailTitle = @"Daily Attendace Report";
    NSString *strBodymessage=[NSString stringWithFormat:@"%@\n\n%@",@"Hello Sir,",@"please check your attached daily attendance report."];
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:strBodymessage isHTML:NO];
        [mc setToRecipients:toRecipents];
        [self presentViewController:mc animated:YES completion:NULL];
    }
    
    [mc addAttachmentData:file mimeType:@"application/pdf" fileName:@"attachment.pdf"];
    
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)resulttt error:(NSError *)error
{
    switch (resulttt){
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom = 12.0;"];
    [self hideLoadingMode];
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
@end
