//
//  ApplyLeave.m
//  Paylite HRMS
//
//  Created by SANDIPAN on 30/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ApplyLeave.h"

@interface ApplyLeave ()

@end

@implementation ApplyLeave

#pragma mark - ViewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

}

#pragma mark - ViewDidLoad Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    app4=(AppDelegate *)[[UIApplication sharedApplication] delegate];

    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    //[self.view addGestureRecognizer:tap];
    
    currX=2.0f;
    arrImages = [[NSMutableArray alloc] init];
    
    _vwH.layer.shadowRadius = 3.0f;
    _vwH.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _vwH.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _vwH.layer.shadowOpacity = 0.5f;
    _vwH.layer.masksToBounds = NO;
    
    _txtvReason.text=@" Remarks";
    _txtvReason.textColor = [UIColor lightGrayColor];
    
    _btnFull.selected=YES;
    _btnHalf.selected=NO;
     strFullHalf=@"F";
    
      _btnEmployeename.hidden=YES;
     //[self fetchGetSubordinates];
    
    _btnLeaveBalance.hidden=NO;
    
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    _txtEmployeename.text=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeName"]];
     strSubordIDD=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]];
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            [_scrollLeave setContentSize:CGSizeMake(_scrollLeave.frame.size.width, _scrollLeave.frame.size.height+200)];
        }
        else if(screenSize.height == 667.0f){
            //6
            [_scrollLeave setContentSize:CGSizeMake(_scrollLeave.frame.size.width, _scrollLeave.frame.size.height+110)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            [_scrollLeave setContentSize:CGSizeMake(_scrollLeave.frame.size.width, _scrollLeave.frame.size.height+110)];
        }
        else if(screenSize.height == 812.0f){
            //X
            [_scrollLeave setContentSize:CGSizeMake(_scrollLeave.frame.size.width, _scrollLeave.frame.size.height+110)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            [_scrollLeave setContentSize:CGSizeMake(_scrollLeave.frame.size.width, _scrollLeave.frame.size.height+110)];
        }
        else{
            //4S
            [_scrollLeave setContentSize:CGSizeMake(_scrollLeave.frame.size.width, _scrollLeave.frame.size.height+600)];
        }
    }
    else
    {
    }
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.barTintColor=[UIColor whiteColor];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(Next)],
                           nil];
    [numberToolbar sizeToFit];
    _txtfromDate.inputAccessoryView = numberToolbar;
    
    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.barTintColor=[UIColor whiteColor];
    numberToolbar1.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancell)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(Done)],
                           nil];
    [numberToolbar1 sizeToFit];
    _txtToDate.inputAccessoryView = numberToolbar1;
    
    [_btnApply.layer setMasksToBounds:YES];
    [_btnApply.layer setCornerRadius: 4.0];
    [_btnApply.layer setBorderWidth:0.0];
    [_btnApply.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    [self fetchLeaveType];
    
    [self setUpBorder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Back Press Method
- (IBAction)pressback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Set Border Method
-(void)setUpBorder
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _txtvReason.frame.size.height - borderWidth, _txtvReason.frame.size.width, _txtvReason.frame.size.height);
    border.borderWidth = borderWidth;
    [_txtvReason.layer addSublayer:border];
    _txtvReason.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 0.5;
    border1.borderColor = [UIColor lightGrayColor].CGColor;
    border1.frame = CGRectMake(0, _txtEmployeename.frame.size.height - borderWidth1, _txtEmployeename.frame.size.width, _txtEmployeename.frame.size.height);
    border1.borderWidth = borderWidth1;
    [_txtEmployeename.layer addSublayer:border1];
    _txtEmployeename.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    CGFloat borderWidth2 = 0.5;
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.frame = CGRectMake(0, _txtfromDate.frame.size.height - borderWidth2, _txtfromDate.frame.size.width, _txtfromDate.frame.size.height);
    border2.borderWidth = borderWidth2;
    [_txtfromDate.layer addSublayer:border2];
    _txtfromDate.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    CGFloat borderWidth3 = 0.5;
    border3.borderColor = [UIColor lightGrayColor].CGColor;
    border3.frame = CGRectMake(0, _txtToDate.frame.size.height - borderWidth3, _txtToDate.frame.size.width, _txtToDate.frame.size.height);
    border3.borderWidth = borderWidth3;
    [_txtToDate.layer addSublayer:border3];
    _txtToDate.layer.masksToBounds = YES;
    
    CALayer *border4 = [CALayer layer];
    CGFloat borderWidth4 = 0.5;
    border4.borderColor = [UIColor lightGrayColor].CGColor;
    border4.frame = CGRectMake(0, _txtNoofDays.frame.size.height - borderWidth4, _txtNoofDays.frame.size.width, _txtNoofDays.frame.size.height);
    border4.borderWidth = borderWidth4;
    [_txtNoofDays.layer addSublayer:border4];
    _txtNoofDays.layer.masksToBounds = YES;
    
    CALayer *border5 = [CALayer layer];
    CGFloat borderWidth5 = 0.5;
    border5.borderColor = [UIColor lightGrayColor].CGColor;
    border5.frame = CGRectMake(0, _txtLeaveType.frame.size.height - borderWidth5, _txtLeaveType.frame.size.width, _txtLeaveType.frame.size.height);
    border5.borderWidth = borderWidth5;
    [_txtLeaveType.layer addSublayer:border5];
    _txtLeaveType.layer.masksToBounds = YES;
    
    CALayer *border6 = [CALayer layer];
    CGFloat borderWidth6 = 0.5;
    border6.borderColor = [UIColor lightGrayColor].CGColor;
    border6.frame = CGRectMake(0, _viewFullHalf.frame.size.height - borderWidth6, _viewFullHalf.frame.size.width, _viewFullHalf.frame.size.height);
    border6.borderWidth = borderWidth6;
    [_viewFullHalf.layer addSublayer:border6];
    _viewFullHalf.layer.masksToBounds = YES;
}

#pragma mark - Create UIDatePicker Method
- (void) initializeTextFieldInputView1
{
    datePicker1 = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    NSString *strDOJ=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"DateOfJoin"]];
    strDOJ=[strDOJ stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    NSLog(@"strDOJ :%@",strDOJ);
    NSDateFormatter *ddoj1 = [[NSDateFormatter alloc] init];
    [ddoj1 setDateFormat:@"yyyy/MM/dd"];
    NSDate *date111 = [ddoj1 dateFromString:strDOJ];
    [ddoj1 setDateFormat:@"dd/MM/yyyy"];
    NSString *date222 = [ddoj1 stringFromDate:date111];
    NSLog(@"date222 :%@",date222);
    NSDate *ddgfgf = [ddoj1 dateFromString:date222];
    [datePicker1 setMinimumDate: ddgfgf];
    
    if ( [_txtfromDate.text isEqualToString:@""])
    {
        datePicker1.date=[NSDate date];
    }
    else
    {
        NSString *dateStr =_txtfromDate.text;
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *date = [dateFormat dateFromString:dateStr];
        datePicker1.date=date;
    }
    
    datePicker1.backgroundColor = [UIColor whiteColor];
    [datePicker1 addTarget:self action:@selector(dateUpdated1:) forControlEvents:UIControlEventValueChanged];
    _txtfromDate.inputView = datePicker1;
}
- (void) dateUpdated1:(UIDatePicker *)datePicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    _txtfromDate.text =[formatter stringFromDate:datePicker.date];
}
- (void) initializeTextFieldInputView2
{
    datePicker2 = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker2.datePickerMode = UIDatePickerModeDate;
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    NSString *strDOJ=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"DateOfJoin"]];
    strDOJ=[strDOJ stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    NSLog(@"strDOJ :%@",strDOJ);
    NSDateFormatter *ddoj1 = [[NSDateFormatter alloc] init];
    [ddoj1 setDateFormat:@"yyyy/MM/dd"];
    NSDate *date111 = [ddoj1 dateFromString:strDOJ];
    [ddoj1 setDateFormat:@"dd/MM/yyyy"];
    NSString *date222 = [ddoj1 stringFromDate:date111];
    NSLog(@"date222 :%@",date222);
    NSDate *ddgfgf = [ddoj1 dateFromString:date222];
    [datePicker2 setMinimumDate: ddgfgf];
    
    if ( [_txtfromDate.text isEqualToString:@""])
    {
        datePicker1.date=[NSDate date];
    }
    else  if (  ![_txtToDate.text isEqualToString:@""])
    {
        NSString *dateStr =_txtToDate.text;
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *date = [dateFormat dateFromString:dateStr];
        datePicker2.date=date;
    }
    else
    {
        NSString *dateStr =_txtfromDate.text;
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *datef = [dateFormat dateFromString:dateStr];
        datePicker2.date=datef;
    }
    datePicker2.backgroundColor = [UIColor whiteColor];
    [datePicker2 addTarget:self action:@selector(dateUpdated2:) forControlEvents:UIControlEventValueChanged];
    _txtToDate.inputView = datePicker2;
}
- (void) dateUpdated2:(UIDatePicker *)datePicker
{
    if ([strComparedate isEqualToString:@"1"])
    {
        _txtToDate.text=@"";
        _txtNoofDays.text=@"";
    }
    else
    {
    }
}

#pragma mark - Next/Cancel Press Method
-(void)Next
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    _txtfromDate.text =[formatter stringFromDate:datePicker1.date];
    [self initializeTextFieldInputView2];
    
    UITextField *txtfld=(UITextField *)actvtextbox;
    if (txtfld==_txtfromDate)
    {
        txtfld=_txtToDate;
    }
    [txtfld becomeFirstResponder];
}
-(void)cancel
{
    
    UITextField *txtfld=(UITextField *)actvtextbox;
    [txtfld resignFirstResponder];
    _txtfromDate.text=@"";
}

#pragma mark - Done/Cancel Press Method
-(void)Done
{
    strComparedate=@"";
    
    UITextField *txtfld=(UITextField *)actvtextbox;
    [txtfld resignFirstResponder];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *FromDate = [dateFormatter dateFromString:_txtfromDate.text];
    NSDate *ToDate = [dateFormatter dateFromString: [dateFormatter stringFromDate:datePicker2.date]];
    
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
        _txtToDate.text=@"";
        _txtNoofDays.text=@"";
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        _txtToDate.text =[formatter stringFromDate:datePicker2.date];
        [self fetchNoofLeaveDays];
    }
}
-(void)cancell
{
    UITextField *txtfld=(UITextField *)actvtextbox;
    [txtfld resignFirstResponder];
    _txtToDate.text=@"";
}

#pragma mark - Press Full Half Radio Button Method
- (IBAction)pressFullHalfMethod:(id)sender
{
    if (_btnFull.isSelected==NO)
    {
        _btnFull.selected=YES;
        _btnHalf.selected=NO;
        strFullHalf=@"F";
    }
    else if (_btnHalf.isSelected==NO)
    {
        _btnFull.selected=NO;
        _btnHalf.selected=YES;
        strFullHalf=@"H";
    }
    
    NSLog(@"strFullHalf :%@",strFullHalf);
    [self fetchNoofLeaveDays];
}




#pragma mark - Fetch GetSubordinates Method
-(void)fetchGetSubordinates
{
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    strIdentifier=@"5";
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<GetSubordinates xmlns=\"http://tempuri.org/\"><sEmployeeId>%@</sEmployeeId>"
                             "</GetSubordinates> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]]];
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetSubordinates" forHTTPHeaderField:@"SOAPAction"];
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
#pragma mark - LeaveBalance Method
- (IBAction)pressLeaveBalance:(id)sender
{
    if ([_txtfromDate.text isEqualToString:@""])
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        NSString *strAsondate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
        NSLog(@"strAsondate :%@",strAsondate);
        [self fetchLeaveBalanceStrutre:strAsondate];
    }
    else
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *strDTTT = [dateFormat dateFromString:_txtfromDate.text];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:strDTTT];
        //NSInteger day = [components day];
        //NSInteger month = [components month];
        NSInteger year = [components year];
        NSString *strFinalYear=[NSString stringWithFormat:@"%ld",(long)year];
        NSLog(@"strFinalYear :%@",strFinalYear);
        
        [self fetchLeaveBalanceStrutre:strFinalYear];
    }
}

-(void)fetchLeaveBalanceStrutre:(NSString *)strDTT
{
    strIdentifier=@"4";
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    //NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
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
                             "<GetEmployeeLeave xmlns=\"http://tempuri.org/\"><sEmployeeID>%@</sEmployeeID>,<sYear>%@</sYear>,<sLeaveType>%@</sLeaveType>"
                             "</GetEmployeeLeave> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",strSubordIDD,strDTT,strIDDD];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%ld",(long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetEmployeeLeave" forHTTPHeaderField:@"SOAPAction"];
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

#pragma mark - Fetch No of Leave days Method
-(void)fetchNoofLeaveDays
{
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
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
                             "<GetNoofLeaveDays xmlns=\"http://tempuri.org/\"><sComapnyID>%@</sComapnyID>,<sEmployeeID>%@</sEmployeeID>,<sLeavType>%@</sLeavType>,<dtFromDate>%@</dtFromDate>,<dtToDate>%@</dtToDate>,<sHalfFull>%@</sHalfFull>"
                             "</GetNoofLeaveDays> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],strIDDD,_txtfromDate.text,_txtToDate.text,strFullHalf];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetNoofLeaveDays" forHTTPHeaderField:@"SOAPAction"];
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


#pragma mark - Fetch LevaeType Method
-(void)fetchLeaveType
{
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    strIdentifier=@"1";
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<GetLeaveType xmlns=\"http://tempuri.org/\"><sCompanyID>%@</sCompanyID>,<sEmployeeID>%@</sEmployeeID>"
                             "</GetLeaveType> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]]];
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetLeaveType" forHTTPHeaderField:@"SOAPAction"];
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



#pragma mark - ApplyLeave Method
- (IBAction)pressApply:(id)sender
{
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    //NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    if ([_txtfromDate.text isEqualToString:@""])
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please select From date."
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
    else if ([_txtToDate.text isEqualToString:@""])
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please select To date."
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
    else if ([_txtNoofDays.text isEqualToString:@""])
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter no of days."
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
    else if ([_txtLeaveType.text isEqualToString:@""])
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter leave type."
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
    else if ([_txtNoofDays.text isEqualToString:@"0"])
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"No of days should be greater than zero."
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
        
        NSString *base64String,*base64String1;
        NSData* imageData;
        
        for (UIImageView *imgvw in arrImages)
        {
            UIImage  *img = imgvw.image;
            
            imageData = [NSData dataWithData:UIImageJPEGRepresentation([self imageByScalingProportionallyToSize:CGSizeMake(200, 200) imageToResize:img], 1.0)];
            //imageData =[NSData dataWithData:UIImagePNGRepresentation([self imageWithImage:img scaledToSize:CGSizeMake(200, 200) isAspectRation:YES])];
            //imageData = [NSData dataWithData:UIImagePNGRepresentation([self compressImage:img])];
            //imageData = UIImageJPEGRepresentation(image,0.1);
            base64String1 =[Base64 encode:imageData];
            base64String=[base64String1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            base64String=[base64String1 stringByRemovingPercentEncoding];
        }
        
        //NSLog(@"imageData length:%lu",[imageData length]);
        NSLog(@"imageData size: %.2f KB", (float)[imageData length]/1024);
        NSLog(@"base64String length:%lu KB",(unsigned long)[base64String length]/1024);
        //NSLog(@"base64String :%@",base64String);
        
        if ([arrImages count]==0) {
            base64String=@"";
        }
        
        NSString *strFromDate=_txtfromDate.text;
        NSString *strTodate=_txtToDate.text;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *datefrom = [dateFormat dateFromString:strFromDate];
        NSDate *dateTo = [dateFormat dateFromString:strTodate];
        NSDateFormatter *currentDTFormatter = [[NSDateFormatter alloc] init];
        [currentDTFormatter setDateFormat:@"yyyy"];
        NSString *strFrom = [currentDTFormatter stringFromDate:datefrom];
        NSString *strTo = [currentDTFormatter stringFromDate:dateTo];
        NSComparisonResult result1;
        result1 = [strTo compare:strFrom];
        //NSLog(@"%@ %@ %ld", strTo,strFrom,(long)result1);
        
        if(result1==NSOrderedSame)
        {
           [self uploadLeaveData:strIDDD reason:_txtvReason.text fromdate:_txtfromDate.text todate:_txtToDate.text nodays:[_txtNoofDays.text doubleValue] leaveId:@"" employeeID:strSubordIDD iMode:0 rejectCommt:@"" imageattached:base64String];
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Apply leave calendar year wise."
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
}


#pragma mark - Post ApplyLeave Method
-(void)uploadLeaveData:(NSString *)leaveTypeId reason:(NSString *)reasonDesc fromdate:(NSString *)frmdate todate:(NSString *)tdate nodays:(double)day leaveId:(NSString *)leaveId employeeID:(NSString *)empID iMode:(NSInteger)imode rejectCommt:(NSString *)rejectComment imageattached:(NSString *)strAttached
{
    
    
    strIdentifier=@"2";
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strReject;
    NSInteger mode;
    if (imode==0)
    {
        mode=0;
    }
    else
    {
        mode=102;
    }
    if ([rejectComment isEqualToString:@""])
    {
        strReject=@"";
    }
    else
    {
        strReject=rejectComment;
    }
   
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSString *strExtension;
    if ([strAttached isEqualToString:@""]) {
        strExtension=@"";
    }
    else{
        strExtension=@"jpg";
    }
    
    if ([_txtvReason.text isEqualToString:@" Remarks"]) {
        _txtvReason.text=@"";
        reasonDesc=_txtvReason.text;
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
                             "<ApplyLeave xmlns=\"http://tempuri.org/\"><sCompanyID>%@</sCompanyID>,<sUsername>%@</sUsername>,<sLeaveID>%@</sLeaveID>,<sEmployeeID>%@</sEmployeeID>,<dtFromDate>%@</dtFromDate>,<dtToDate>%@</dtToDate>,<dNoOfDays>%f</dNoOfDays>,<sLeaveTypeID>%@</sLeaveTypeID>,<sReason>%@</sReason>,<sHalfFull>%@</sHalfFull>,<iMode>%ld</iMode>,<sRejectComment>%@</sRejectComment>,<sDocument>%@</sDocument>,<extTag>%@</extTag>"
                             "</ApplyLeave> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"Username"]],leaveId,empID,frmdate,tdate,day,leaveTypeId,reasonDesc,strFullHalf,(long)mode,strReject,strAttached,strExtension];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%ld",(long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/ApplyLeave" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    NSLog(@"contentlength description=%@",[msgLength description]);
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
        if ([elementName isEqualToString:@"GetLeaveTypeResult"])
        {
            arrMLeaveType=[[NSMutableArray alloc] init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            objlt=[[objLeaveType alloc] init];
        }
        if ([elementName isEqualToString:@"ID"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"LeaveType"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
            NSLog(@"mytable is called..");
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            currentElementValue=[NSMutableString string];
        }
        
    }
    else if([strIdentifier isEqualToString:@"3"])
    {
        if ([elementName isEqualToString:@"GetNoofLeaveDaysResult"])
        {
            NSLog(@"rootis called..");
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            NSLog(@"mytable is called..");
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"NoOfLeaveDays"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if([strIdentifier isEqualToString:@"4"])
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
        if ([elementName isEqualToString:@"FileLocation"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if([strIdentifier isEqualToString:@"5"])
        {
            if ([elementName isEqualToString:@"GetSubordinatesResult"])
            {
                arrMSubordinates=[[NSMutableArray alloc]init];
            }
            if ([elementName isEqualToString:@"mytable"])
            {
                DictSubordinates=[[NSMutableDictionary alloc]init];
            }
            if ([elementName isEqualToString:@"Id"])
            {
                currentElementValue=[NSMutableString string];
            }
            if ([elementName isEqualToString:@"EmployeeName"])
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
            [arrMLeaveType addObject:objlt];
        }
        if ([elementName isEqualToString:@"ID"])
        {
            objlt.strLeaveID=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"LeaveType"])
        {
            objlt.strLeaveType=currentElementValue;
            currentElementValue=nil;
        }
    }
    else if([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
            NSLog(@"mytable is called..");
        }
        if ([elementName isEqualToString:@"LeaveID"])
        {
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strLeaveApplyMessageCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strLeaveApplyMessageText=currentElementValue;
            currentElementValue=nil;
        }
    }
    else if([strIdentifier isEqualToString:@"3"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
            NSLog(@"mytable is called..");
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            NSLog(@"MessageCode :%@",currentElementValue);
            strnoofMessagecode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"NoOfLeaveDays"])
        {
            NSLog(@"NoOfLeaveDays :%@",currentElementValue);
            strnoofdaysvalue=currentElementValue;
            currentElementValue=nil;
        }
        
    }
    else if([strIdentifier isEqualToString:@"4"])
    {
        if ([elementName isEqualToString:@"employeeleave"])
        {
            NSLog(@"employeeleave is called..");
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            NSLog(@"MessageCode :%@",currentElementValue);
            strlevablanceMessagecode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"FileLocation"])
        {
            NSLog(@"filelocation :%@",currentElementValue);
            strleavefilelocation=currentElementValue;
            currentElementValue=nil;
        }
    }
    
    else if([strIdentifier isEqualToString:@"5"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
           [arrMSubordinates addObject:DictSubordinates];
        }
        if ([elementName isEqualToString:@"Id"])
        {
         //   objHL.strHDate=currentElementValue;
            
            [DictSubordinates setValue:currentElementValue forKey:@"Id"];
            
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"EmployeeName"])
        {
           // objHL.strHName=currentElementValue;
            
             [DictSubordinates setValue:currentElementValue forKey:@"EmployeeName"];
            currentElementValue=nil;
        }
        
        
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        
        //NSLog(@"arrMLeaveType :%@",arrMLeaveType);

        objLeaveType *obj=[arrMLeaveType objectAtIndex:0];
        _txtLeaveType.text=[NSString stringWithFormat:@"%@",obj.strLeaveType];
        strIDDD=[NSString stringWithFormat:@"%@",obj.strLeaveID];
        
        if ([arrMLeaveType count]==0)
        {
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Error in leave type."
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
    else if([strIdentifier isEqualToString:@"2"])
    {
        int code=[strLeaveApplyMessageCode intValue];
        if (code==0)
        {
            [self GoTOThankYouPage:@"Your request has been forwarded for approval."];
        }
        else
        {
          
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:strLeaveApplyMessageText
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
    else if([strIdentifier isEqualToString:@"3"])
    {
        int code=[strnoofMessagecode intValue];
        if (code==0)
        {
            _txtNoofDays.text=strnoofdaysvalue;
        }
        else
        {
           
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Error in days count."
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
    else if([strIdentifier isEqualToString:@"4"])
    {
        int code=[strlevablanceMessagecode intValue];
        if (code==0)
        {
            NSLog(@"leaveBalancefilelocation url--%@",strleavefilelocation);
            
            [self restrictRotation:YES];
            //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
            
            [self viewPdfReader];
        }
        else
        {
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Error in leave balance."
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
    else if([strIdentifier isEqualToString:@"5"])
    {
        if ([arrMSubordinates count]==0)
        {
            _btnEmployeename.hidden=YES;
        }
        else
        {
            _btnEmployeename.hidden=NO;
            //NSLog(@"arrMSubordinates :%@",arrMSubordinates);
        }
    }
}


#pragma mark - Go To ThankYou Page Method
-(void)GoTOThankYouPage:(NSString *)strMSG
{
    ThankYou *objDemo;
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYou5S" bundle:nil];
        }
        else if(screenSize.height == 667.0f){
            //6
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYou6" bundle:nil];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYou6Plus" bundle:nil];
        }
        else if(screenSize.height == 812.0f){
            //X
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYouX" bundle:nil];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYouXSMAX" bundle:nil];
        }
        else{
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYou" bundle:nil];
        }
    }
    else
    {
    }
    objDemo.strMessage=strMSG;
    [self.navigationController pushViewController:objDemo animated:YES];
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
    
    mainBg.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    mainBg.backgroundColor =[UIColor whiteColor];
    
    bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,mainBg.frame.size.width,64)];
    bgVwHeader.backgroundColor =[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
    [mainBg addSubview:bgVwHeader];
    
    
    webViewPdfReader=[[UIWebView alloc] initWithFrame:CGRectMake(0,84, mainBg.frame.size.width, mainBg.frame.size.height-84)];
    NSURL *url = [NSURL URLWithString:strleavefilelocation];
    webViewPdfReader.scalesPageToFit=YES;
    webViewPdfReader.delegate=self;
    [webViewPdfReader setBackgroundColor:[UIColor whiteColor]];
    [webViewPdfReader.scrollView setZoomScale:8.0 animated:NO];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webViewPdfReader loadRequest:requestObj];
    [mainBg addSubview:webViewPdfReader];
    
    btnDonepdf=[UIButton buttonWithType:UIButtonTypeCustom];
    btnDonepdf.frame=CGRectMake(8, 28,60, 28);
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
    
    [self performSelector:@selector(executePrintOperation) withObject:nil afterDelay:0.2];
}
-(void)executePrintOperation
{
    NSURL *url = [NSURL URLWithString:strleavefilelocation];
    NSLog(@"leavefilelocation url:%@",url);
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self printPDF:urlData];
}
-(void)emailpdf:(UIButton *)sender
{
    [mainBg removeFromSuperview];
    [self restrictRotation:NO];
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    [UINavigationController attemptRotationToDeviceOrientation];
    
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
            AttchedFiledate = [NSData dataWithContentsOfURL:[NSURL URLWithString:strleavefilelocation]];
            
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


#pragma mark - Print PDF Method
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

#pragma mark - Email Message Method
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:?cc=&subject=Paylite HRMS Leave Balance!";
    NSString *strBodymessage=[NSString stringWithFormat:@"%@\n\n%@",@"Hello Sir,",@"please check your attached leave balance."];
    NSString *body = [NSString stringWithFormat:@"&body=%@",strBodymessage];
    NSString *email = [NSString stringWithFormat:@"%@%@\n\n%@", recipients, body,strleavefilelocation];
    email = [email stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email] options:@{} completionHandler:nil];
}
- (void)showEmail:(NSData*)file
{
    NSString *emailTitle = @"Paylite HRMS Leave Balance!";
    NSString *strBodymessage=[NSString stringWithFormat:@"%@\n\n%@",@"Hello Sir,",@"please check your attached leave balance."];
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

#pragma mark - UIWebview Delegate Method
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document. body.style.zoom = 12.0;"];
    [self hideLoadingMode];
}


#pragma mark - UITextField Delegate Method
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _txtfromDate)
    {
        [self initializeTextFieldInputView1];
    }
    else if (textField == _txtToDate)
    {
        [self initializeTextFieldInputView2];
    }
    if (textField==_txtLeaveType)
    {
        Activetxtfld=textField;
        tblView.tag=121;
        [self popupList];
    }
    else
    {
    }
    
    actvtextbox=textField;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _txtfromDate)
    {
    }
    else if (textField == _txtToDate)
    {
    }
    if (textField==_txtLeaveType)
    {
        Activetxtfld=textField;
        tblView.tag=121;
        [self popupList];
        return NO;
    }
    else
    {
    }
    
    actvtextbox=textField;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField==_txtfromDate)
    {
        [datePicker1 removeFromSuperview];
        datePicker1=nil;
    }
    else if (textField==_txtToDate)
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

#pragma mark - UITextView Delegate Method
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if( [_txtvReason.text isEqualToString:@" Remarks"] && [_txtvReason.textColor isEqual:[UIColor lightGrayColor]] ){
        _txtvReason.text = @"";
        _txtvReason.textColor = [UIColor blackColor];
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if(screenSize.height == 667.0f)
        {
            [_scrollLeave setContentOffset:CGPointMake(0, 100) animated:YES];
        }
        else if(screenSize.height == 736.0f)
        {
            [_scrollLeave setContentOffset:CGPointMake(0, 100) animated:YES];
        }
        else if(screenSize.height == 812.0f)
        {
            [_scrollLeave setContentOffset:CGPointMake(0, 100) animated:YES];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            [_scrollLeave setContentOffset:CGPointMake(0, 100) animated:YES];
        }
        else if(screenSize.height == 568.0f)
        {
            [_scrollLeave setContentOffset:CGPointMake(0, textView.frame.origin.y-10) animated:YES];
        }
        else{
            [_scrollLeave setContentOffset:CGPointMake(0, textView.frame.origin.y-10) animated:YES];
        }
    }
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView==_txtvReason) {
        [_scrollLeave setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}
-(void)dismissKeyboard
{
    if(_txtvReason.text.length == 0){
        _txtvReason.textColor = [UIColor lightGrayColor];
        _txtvReason.text = @" Remarks";
    }
    if (tblView!=nil){
    }
    else
    {
        [self.view endEditing:YES];
    }
}


#pragma mark - Sub Ordinate Pop Gesture Method
-(void)popupListGetSubordinates
{
    [_txtvReason resignFirstResponder];
    
    if (tblView!=nil){
        [tblView removeFromSuperview];
        tblView=nil;
    }
    else
    {
        tblView=[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(Activetxtfld.frame),CGRectGetMaxY(Activetxtfld.frame)+2, CGRectGetWidth(Activetxtfld.frame), 0) style:UITableViewStylePlain];
        tblView.delegate=self;
        tblView.dataSource=self;
        [_scrollLeave addSubview:tblView];
    
        arrFeedTblPopup=nil;
        arrFeedTblPopup=arrMSubordinates;
        tblView.tag=122;
       
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
                             frame.size.height = self.view.frame.size.height/2.0f-64;
                             tblView.frame = frame;
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

#pragma mark - Create LeaveType PopUP List Method
-(void)popupList
{
    [_txtvReason resignFirstResponder];
    
    if (tblView!=nil){
        [tblView removeFromSuperview];
        tblView=nil;
    }
    else
    {
        tblView=[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(Activetxtfld.frame),CGRectGetMaxY(Activetxtfld.frame)+2, CGRectGetWidth(Activetxtfld.frame), 0) style:UITableViewStylePlain];
        tblView.delegate=self;
        tblView.dataSource=self;
        [_scrollLeave addSubview:tblView];
        tblView.tag=121;
        
        arrFeedTblPopup= [self GetDataForPoppup:Activetxtfld];
       
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
                             frame.size.height = self.view.frame.size.height/2.0f-64;
                             tblView.frame = frame;
                         }
                         completion:^(BOOL finished){
                         }];
    }
}
-(NSArray *)GetDataForPoppup:(UITextField *)fld
{
    if (tblView.tag==121) {
     arrFeedTblPopup=nil;
    if(fld==_txtLeaveType)
    {
        arrFeedTblPopup=arrMLeaveType;
    }
    else{
        
    }
    }
    return arrFeedTblPopup;
}

#pragma mark - Get Subordinates Button call Method
- (IBAction)pressEmployeename:(id)sender
{
    //Activetxtfld=_txtEmployeename;
    //[self popupListGetSubordinates];
}

#pragma mark - UITableView Delegate/Datasource Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tblView.tag==122)
    {
        return [arrMSubordinates count];
    }
    else
    {
        return [arrFeedTblPopup count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (  tblView.tag==122)
    {
        static NSString *cellidentifier=@"cellidentifier";
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.backgroundColor=[UIColor whiteColor];
        
       //objLeaveType *obj=[arrFeedTblPopup objectAtIndex:indexPath.row];
        NSDictionary *dicTemp=[arrMSubordinates objectAtIndex:indexPath.row];
        
        UILabel *title1;
        title1=[[UILabel alloc] initWithFrame:CGRectMake(15,0,280,44)];
        title1.textAlignment=NSTextAlignmentLeft;
        title1.textColor=[UIColor darkGrayColor];
        title1.font=[UIFont fontWithName:@"GothamBook" size:13.0];
        title1.backgroundColor=[UIColor clearColor];
        title1.text=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeName"]];
        [cell.contentView addSubview:title1];
        
        UILabel *lblSeparator;
        lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(15,42.5,tableView.frame.size.width-30,0.5)];
        lblSeparator.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:lblSeparator];
          return cell;
    }
    else
    {
        static NSString *cellidentifier=@"cellidentifier";
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.backgroundColor=[UIColor whiteColor];
        
        objLeaveType *obj=[arrFeedTblPopup objectAtIndex:indexPath.row];
        
        UILabel *title1;
        title1=[[UILabel alloc] initWithFrame:CGRectMake(15,0,280,44)];
        title1.textAlignment=NSTextAlignmentLeft;
        title1.textColor=[UIColor darkGrayColor];
        title1.font=[UIFont fontWithName:@"GothamBook" size:13.0];
        title1.backgroundColor=[UIColor clearColor];
        title1.text=[NSString stringWithFormat:@"%@",obj.strLeaveType];
        [cell.contentView addSubview:title1];
        
        UILabel *lblSeparator;
        lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(15,42.5,tableView.frame.size.width-30,0.5)];
        lblSeparator.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:lblSeparator];
          return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      if ( tblView.tag==122)
      {
          NSDictionary *dicTemp=[arrFeedTblPopup objectAtIndex:indexPath.row];
          _txtEmployeename.text=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeName"]];
          strSubordIDD=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"Id"]];
          [self handleTap];
      }
      else
      {
          objLeaveType *obj=[arrFeedTblPopup objectAtIndex:indexPath.row];
          _txtLeaveType.text=[NSString stringWithFormat:@"%@",obj.strLeaveType];
          strIDDD=[NSString stringWithFormat:@"%@",obj.strLeaveID];
          [self handleTap];
          [self fetchNoofLeaveDays];
      }
}
-(void)handleTap
{
    [UIView animateWithDuration:0.35
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = tblView.frame;
                         frame.size.height = 0;
                         tblView.frame = frame;
                     }
                     completion:^(BOOL finished){
                         [tblView removeFromSuperview];
                         tblView=nil;
                         
                     }];
}



#pragma mark - Press Add Document Method
- (IBAction)pressDocument:(id)sender
{
    if ([arrImages count]<1)
    {
        [self openCameraRoll];
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Can not upload more than one attachment."
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

#pragma mark - Camera Roll && Attach Document Flow Method
-(void)openCameraRoll
{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Take photo"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [self selfPhotoLibraryCamera];
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Choose from gallery"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [self selfPhotoLibraryPhone];
                              }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)selfPhotoLibraryPhone
{
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    //[imagePickerController setAllowsEditing:YES];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
-(void)selfPhotoLibraryCamera
{
    // if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    NSLog(@"%@",[[UIDevice currentDevice] model]);
    
    // if (![[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator"])
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        //[imagePickerController setAllowsEditing:YES];
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Sorry!"
                                                                            message:@""
                                                                     preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *alertActionCancel = [UIAlertAction actionWithTitle: @"Your device does not have this facility."
                                                                    style: UIAlertActionStyleDestructive
                                                                  handler: ^(UIAlertAction *action) {
                                                                      NSLog(@"Dismiss button tapped!");
                                                                  }];
        [controller addAction: alertActionCancel];
        [self presentViewController: controller animated: YES completion: nil];
    }
}


#pragma mark - image picker controler delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self ScrollImgSetup:image];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSLog(@"imageData length:%lu",[imageData length]);
    NSLog(@"imageData size: %.2f KB", (float)[imageData length]/1024);
    
    NSString *base64String =[Base64 encode:imageData];
    base64String=[base64String stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    base64String=[base64String stringByRemovingPercentEncoding];
   
    NSLog(@"base64String length:%lu",[base64String length]);
    NSLog(@"base64String size: %.2f KB", (float)[base64String length]/1024);
    
    //[self SyncRequestPost:base64String];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    picker=nil;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{
    //NSLog(@"imageview subview :- %@",_scrollDocument.subviews);
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Image post base64 Method
/*-(void)SyncRequestPost:(NSString *)str
{
    NSString *strConUrl=[NSString stringWithFormat:@"%@",@"http://50.57.84.23/ImageUpload/Service1.svc/PostImage"];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSString *post = [NSString stringWithFormat:@"image=%@",str];
    post=[post stringByReplacingOccurrencesOfString:@"" withString:@"%20"];
    NSLog(@"PostString=%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strConUrl]]];
    [request setHTTPMethod:@"POST"];
    //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<PostImage xmlns=\"http://50.57.84.23/\"><image>%@</image>"
                             "</PostImage> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",str];
    
    NSLog(@"soapMessage %@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://50.57.84.23/ImageUpload/Service1.svc/PostImage" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //NSLog(@"contentlength=%@",msgLength);
    NSLog(@"theRequest=%@",theRequest);
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    if(theConnection)
    {
        NSLog(@"Connected..");
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        self.view.userInteractionEnabled=NO;
        [self showLoadingMode];
    }
    else{
    }
}*/

#pragma mark - Image Scaling Methods
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize isAspectRation:(BOOL)aspect
{
    if (!image) {
        return nil;
    }
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    CGFloat originRatio = image.size.width / image.size.height;
    CGFloat newRatio = newSize.width / newSize.height;
    
    CGSize sz;
    
    if (!aspect) {
        sz = newSize;
    }else {
        if (originRatio < newRatio) {
            sz.height = newSize.height;
            sz.width = newSize.height * originRatio;
        }else {
            sz.width = newSize.width;
            sz.height = newSize.width / originRatio;
        }
    }
    CGFloat scale = 1.0;
    //    if([[UIScreen mainScreen]respondsToSelector:@selector(scale)]) {
    //        CGFloat tmp = [[UIScreen mainScreen]scale];
    //        if (tmp > 1.5) {
    //            scale = 2.0;
    //        }
    //    }
    sz.width /= scale;
    sz.height /= scale;
    UIGraphicsBeginImageContextWithOptions(sz, NO, scale);
    [image drawInRect:CGRectMake(0, 0, sz.width, sz.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize imageToResize:(UIImage*)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    return newImage ;
}
-(UIImage *)compressImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 600.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    return [UIImage imageWithData:imageData];
}


#pragma mark - Setup Attachment ScrollView Method
-(void)ScrollImgSetup:(id)img
{
    ImageViewCat *imgvw;
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,80, 100)];
        }
        else if(screenSize.height == 667.0f){
            //6
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,100, 120)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,100, 120)];
        }
        else if(screenSize.height == 812.0f){
            //X
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,100, 120)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,100, 120)];
        }
        else
        {
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,100, 90)];
        }
    }
    
    
    if ([img isKindOfClass:[NSString class]])
    {
        imgvw.strURL=(NSString*)img;
    }
    else
    {
        imgvw.strURL = @"";
        imgvw.image=(UIImage*)img;
    }
    
    imgvw.userInteractionEnabled=YES;
    
    UIButton *btnDlt=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(imgvw.frame)-24,0,24, 24)];
    [btnDlt setBackgroundColor:[UIColor clearColor]];
    [btnDlt setBackgroundImage:[UIImage imageNamed:@"crossR"] forState:UIControlStateNormal];
    [btnDlt addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    btnDlt.tag=arrImages.count+1;
    imgvw.tag=arrImages.count+1+100;
    [imgvw addSubview:btnDlt];
    
    
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            _scrollDocument.contentSize=CGSizeMake(currX+80, _scrollDocument.frame.size.height);
        }
        else if(screenSize.height == 667.0f){
            //6
            _scrollDocument.contentSize=CGSizeMake(currX+100, _scrollDocument.frame.size.height);
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            _scrollDocument.contentSize=CGSizeMake(currX+100, _scrollDocument.frame.size.height);
        }
        else if(screenSize.height == 812.0f){
            //X
            _scrollDocument.contentSize=CGSizeMake(currX+100, _scrollDocument.frame.size.height);
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            _scrollDocument.contentSize=CGSizeMake(currX+100, _scrollDocument.frame.size.height);
        }
        else{
            _scrollDocument.contentSize=CGSizeMake(currX+100, _scrollDocument.frame.size.height);
        }
    }
    currX=CGRectGetMaxX(imgvw.frame);
    [_scrollDocument addSubview:imgvw];
    [arrImages addObject:imgvw];
}
-(void)deleteImage:(UIButton *)sender
{
    NSLog(@"tapped Arr count ::-%lu",(unsigned long)arrImages.count);
    NSLog(@"senderctag::-%lu\n\nNo of subviews ::%@",(unsigned long)sender.tag,[_scrollDocument subviews]);
    CGFloat currXimg=0.0f;
    int i=1;
    
    NSMutableArray *toDestroy = [NSMutableArray arrayWithCapacity:arrImages.count];
    for (UIImageView *vw in arrImages)
    {
        if ([vw isKindOfClass:[UIImageView class]]){
            UIImageView *imgVw=(UIImageView *)vw;
            if (imgVw.tag-100 == sender.tag){
                [imgVw removeFromSuperview];
                [toDestroy addObject:[arrImages objectAtIndex:sender.tag-1]];
                currX=currX-CGRectGetWidth(imgVw.frame);
                imgVw=nil;
            }
        }
    }
    [arrImages removeObjectsInArray:toDestroy];
    
    for (UIImageView *vw in arrImages){
        vw.frame=CGRectMake(currXimg+2, CGRectGetMinY(vw.frame), CGRectGetWidth(vw.frame), CGRectGetHeight(vw.frame));
        currXimg=CGRectGetMaxX(vw.frame);
        vw.tag=i+100;
        for (UIButton *btn in [vw subviews]) {
            btn.tag=i;
        }
        i++;
        _scrollDocument.contentSize=CGSizeMake(CGRectGetWidth(vw.frame)*i, _scrollDocument.frame.size.height);
    }
}

#pragma mark - Custom Spinner Method
-(void)showLoadingMode
{
    if (!loadingCircle)
    {
        loadingCircle = [[UIView alloc]init];
        loadingCircle.backgroundColor = [UIColor clearColor];
        loadingCircle.alpha=1.00f;
        
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
    lblC.font=[UIFont fontWithName:@"GothamBook" size:13];
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


@end
