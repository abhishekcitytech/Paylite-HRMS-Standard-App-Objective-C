//
//  ApprovalLeaveDetails.m
//  Paylite HRMS
//
//  Created by SANDIPAN on 21/06/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ApprovalLeaveDetails.h"

@interface ApprovalLeaveDetails ()

@end

@implementation ApprovalLeaveDetails
@synthesize objldtsss;

#pragma mark - ViewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self setupDetail];
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
    
    [_btnApprove.layer setMasksToBounds:YES];
    [_btnApprove.layer setCornerRadius: 4.0];
    [_btnApprove.layer setBorderWidth:0.0];
    [_btnApprove.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    [_btnReject.layer setMasksToBounds:YES];
    [_btnReject.layer setCornerRadius: 4.0];
    [_btnReject.layer setBorderWidth:0.0];
    [_btnReject.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    
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
    
    [self initializeTextFieldInputView1];
    [self initializeTextFieldInputView2];
    
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

    [self setBorderMethod];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Back Press Method
- (IBAction)pressBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Create FromDate PickerView Method
- (void)initializeTextFieldInputView1
{
    datePicker1 = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    datePicker1.minuteInterval = 5;
    datePicker1.backgroundColor = [UIColor whiteColor];
    [datePicker1 addTarget:self action:@selector(dateUpdated1:) forControlEvents:UIControlEventValueChanged];
    
    NSString *dateStr =objldtsss.LeaveFromDate;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    datePicker1.date=date;
    
    _txtfromDate.inputView = datePicker1;
}
- (void)dateUpdated1:(UIDatePicker *)datePicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    _txtfromDate.text =[formatter stringFromDate:datePicker.date];
}

#pragma mark - Create ToDate PickerView Method
- (void)initializeTextFieldInputView2
{
    datePicker2 = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker2.datePickerMode = UIDatePickerModeDate;
    datePicker2.minuteInterval = 5;
    datePicker2.backgroundColor = [UIColor whiteColor];
    [datePicker2 addTarget:self action:@selector(dateUpdated2:) forControlEvents:UIControlEventValueChanged];
    
    NSString *dateStr =objldtsss.LeaveToDate;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    datePicker2.date=date;
    
    _txtToDate.inputView = datePicker2;
}
- (void)dateUpdated2:(UIDatePicker *)datePicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    _txtToDate.text =[formatter stringFromDate:datePicker.date];
}


#pragma mark - Data Setup Method
-(void)setupDetail
{
    _txtEmployeename.text=objldtsss.Employee;
    _txtfromDate.text=objldtsss.LeaveFromDate;
    _txtToDate.text=objldtsss.LeaveToDate;
    _txtNoofDays.text=objldtsss.NoOfDays;
    _txtLeaveType.text=objldtsss.LeaveType;
    
    NSString *strRemarks=[NSString stringWithFormat:@"%@",objldtsss.Reason];
    NSLog(@"strRemarks :%@",strRemarks);
    if (strRemarks.length>0)
    {
        _txtvReason.text=strRemarks;
        _txtvReason.textColor = [UIColor blackColor];
    }
    else{
        _txtvReason.text=@" Remarks";
        _txtvReason.textColor = [UIColor lightGrayColor];
    }
    
    NSString *strUrl=[NSString stringWithFormat:@"%@",objldtsss.Leaveimages];
    if ([strUrl isEqualToString:@""]) {
    }
    else
    {
        btnAttch=[UIButton buttonWithType:UIButtonTypeCustom];
        btnAttch.frame=CGRectMake(CGRectGetMinX(_txtvReason.frame)+10,CGRectGetMaxY(_txtvReason.frame)+10,80,100);
        [btnAttch setBackgroundColor:[UIColor clearColor]]; 
        [btnAttch.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [btnAttch.layer setBorderWidth: 0.5];
        [btnAttch.layer setCornerRadius:4.0f];
        [btnAttch.layer setMasksToBounds:YES];
        
        btnAttchGrayOut=[UIButton buttonWithType:UIButtonTypeCustom];
        btnAttchGrayOut.frame=CGRectMake(CGRectGetMinX(_txtvReason.frame)+10,CGRectGetMaxY(_txtvReason.frame)+10,80,100);
        [btnAttchGrayOut setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6]];
        [btnAttchGrayOut setTitle:@"View" forState:UIControlStateNormal];
        btnAttchGrayOut.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:14];
        [btnAttchGrayOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnAttchGrayOut.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [btnAttchGrayOut.layer setBorderWidth: 0.5];
        [btnAttchGrayOut.layer setCornerRadius:4.0f];
        [btnAttchGrayOut.layer setMasksToBounds:YES];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        self.view.userInteractionEnabled=NO;
        [self showLoadingMode];
        NSURL *imgUrl = [NSURL URLWithString:[strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
        [self downloadImageWithURL:imgUrl completionBlock:^(BOOL succeeded, NSData *data) {
            if (succeeded)
            {
                btnAttch.contentMode=UIViewContentModeScaleToFill;
                [btnAttch setBackgroundImage:[[UIImage alloc] initWithData:data] forState:UIControlStateNormal];
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                self.view.userInteractionEnabled=YES;
                [self hideLoadingMode];
            }
            else
            {
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                self.view.userInteractionEnabled=YES;
                [self hideLoadingMode];
            }
        }];
        
        [btnAttchGrayOut addTarget:self action:@selector(pressOpenAttachment:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollLeave addSubview:btnAttch];
        [_scrollLeave addSubview:btnAttchGrayOut];
        
        [_btnApprove setFrame:CGRectMake(_btnApprove.frame.origin.x,_btnApprove.frame.origin.y+btnAttch.frame.size.height+20, _btnApprove.frame.size.width, _btnApprove.frame.size.height)];
        [_btnReject setFrame:CGRectMake(_btnReject.frame.origin.x,CGRectGetMaxY(_btnApprove.frame)+10, _btnReject.frame.size.width, _btnReject.frame.size.height)];
    }
    
    if ([objldtsss.FullHalf isEqualToString:@"Full"])
    {
        //Full
        _btnFull.selected=YES;
        _btnHalf.selected=NO;
         strFullHalf=@"F";
    }
    else if ([objldtsss.FullHalf isEqualToString:@"Half"])
    {
        //Half
        _btnFull.selected=NO;
        _btnHalf.selected=YES;
        strFullHalf=@"H";
    }
    
    NSLog(@"employee id :%@",objldtsss.EmployeeID);
    NSLog(@"leave type id :%@",objldtsss.LeaveTypeID);
}

#pragma mark - pressAttachment Popup Method
-(void)pressOpenAttachment:(id)sender
{
    NSString *strUrl=[NSString stringWithFormat:@"%@",objldtsss.Leaveimages];
    [self openAttachmentPopup:@"1" imgUrl:strUrl];
}


#pragma mark - Set Border Style Method
-(void)setBorderMethod
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

#pragma mark - Next/Cancel Press Method
-(void)Next
{
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
    
    NSString *start=[NSString stringWithFormat:@"%@",_txtfromDate.text];
    NSString *end=[NSString stringWithFormat:@"%@",_txtToDate.text];
    NSLog(@"start :%@",_txtfromDate.text);
    NSLog(@"end :%@",_txtToDate.text);
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd/MM/yyyy"];
    [f setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [f dateFromString:end];
    NSLog(@"startDate :%@",startDate);
    NSLog(@"endDate :%@",endDate);
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    NSLog(@"%ld", (long)[components day]);
    
    if ((int)[components day]>=0)
    {
        //NSLog(@"countDays >>> %ld",(long)[components day]+1);
        //_txtNoofDays.text=[NSString stringWithFormat:@"%ld",(long)[components day]+1];
        [_txtfromDate resignFirstResponder];
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please select valid date."
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
        
        _txtfromDate.text=@"";
        _txtNoofDays.text=@"";
    }
}


#pragma mark - Done/Cancel Press Method
-(void)Done
{
    NSString *start=[NSString stringWithFormat:@"%@",_txtfromDate.text];
    NSString *end=[NSString stringWithFormat:@"%@",_txtToDate.text];
    NSLog(@"start :%@",_txtfromDate.text);
    NSLog(@"end :%@",_txtToDate.text);
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd/MM/yyyy"];
    [f setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [f dateFromString:end];
    NSLog(@"startDate :%@",startDate);
    NSLog(@"endDate :%@",endDate);
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    NSLog(@"%ld", (long)[components day]);

    if ((int)[components day]>=0)
    {
        [_txtToDate resignFirstResponder];
       
        NSComparisonResult result;
        result = [endDate compare:startDate];
        if(result==NSOrderedDescending)
        {
            NSLog(@"today is less");
            [self fetchNoofLeaveDays];
        }
        else if(result==NSOrderedAscending)
        {
            NSLog(@"newDate is less");

            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"To date cannot be less than From date."
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
            NSLog(@"Both dates are same");
            [self fetchNoofLeaveDays];
        }
        
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"To date cannot be less than From date."
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
-(void)cancell
{
    UITextField *txtfld=(UITextField *)actvtextbox;
    [txtfld resignFirstResponder];
    
    NSString *start=[NSString stringWithFormat:@"%@",_txtfromDate.text];
    NSString *end=[NSString stringWithFormat:@"%@",_txtToDate.text];
    NSLog(@"start :%@",_txtfromDate.text);
    NSLog(@"end :%@",_txtToDate.text);
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd/MM/yyyy"];
    [f setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [f dateFromString:end];
    NSLog(@"startDate :%@",startDate);
    NSLog(@"endDate :%@",endDate);
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    NSLog(@"%ld", (long)[components day]);
    
    if ((int)[components day]>=0)
    {
        [_txtToDate resignFirstResponder];
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"To date cannot be less than From date."
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


#pragma mark - Segment Full Half Press Method
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

#pragma mark - Fetch No of Leave days Method
-(void)fetchNoofLeaveDays
{
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    strIdentifier=@"2";
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
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],objldtsss.EmployeeID,objldtsss.LeaveTypeID,_txtfromDate.text,_txtToDate.text,strFullHalf];
    
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


#pragma mark - UITextField Delegate Method
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _txtfromDate)
    {
       /* NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        _txtfromDate.text=[formatter stringFromDate:[NSDate date]];*/
    }
    else if (textField == _txtToDate)
    {
        /*NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        _txtToDate.text=[formatter stringFromDate:[NSDate date]];*/
    }
    else
    {
    }
    actvtextbox=textField;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _txtfromDate)
    {
        /*NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        _txtfromDate.text=[formatter stringFromDate:[NSDate date]];*/
    }
    else if (textField == _txtToDate)
    {
        /*NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        _txtToDate.text=[formatter stringFromDate:[NSDate date]];*/
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
    if([textView isEqual:_txtvReason])
    {
        [_scrollLeave setContentOffset:CGPointMake(0, 100) animated:YES];
    }
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView==_txtvReason)
    {
        [_scrollLeave setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if(_txtvReason.text.length == 0){
        _txtvReason.textColor = [UIColor lightGrayColor];
        _txtvReason.text = @" Remarks";
    }
}

#pragma mark - Approve Press Method
- (IBAction)pressApprove:(id)sender
{
    Useraction=123;
    
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
        
    }else if ([_txtToDate.text isEqualToString:@""])
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
    else if ([_txtvReason.text isEqualToString:@" Remarks"])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter your remarks."
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
    else if (_txtvReason.text.length>0)
    {
        [self uploadData:objldtsss.LeaveTypeID reason:_txtvReason.text fromdate:_txtfromDate.text todate:_txtToDate.text nodays:_txtNoofDays.text.doubleValue leaveId:objldtsss.leaveID employeeID:objldtsss.EmployeeID iMode:101 rejectCommt:@""];
        
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter your remarks."
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

#pragma mark - Reject Press Method
- (IBAction)pressReject:(id)sender
{
    Useraction=321;
    
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
        
    }else if ([_txtToDate.text isEqualToString:@""])
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
    else if ([_txtvReason.text isEqualToString:@" Remarks"])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter your remarks."
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
    else if (_txtvReason.text.length>0)
    {
        [self uploadData:objldtsss.LeaveTypeID reason:_txtvReason.text fromdate:_txtfromDate.text todate:_txtToDate.text nodays:_txtNoofDays.text.doubleValue leaveId:objldtsss.leaveID employeeID:objldtsss.EmployeeID iMode:102 rejectCommt:_txtvReason.text];
        
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter your remarks."
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


#pragma mark - Upload Leave Approval Data
-(void)uploadData:(NSString *)leaveTypeId reason:(NSString *)reasonDesc fromdate:(NSString *)frmdate todate:(NSString *)tdate nodays:(double)day leaveId:(NSString *)leaveId employeeID:(NSString *)empID iMode:(NSInteger)imode rejectCommt:(NSString *)rejectComment
{
    strIdentifier=@"1";
    
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSLog(@"imode---%lu",(unsigned long)imode);
    NSLog(@"reject Comment--%@",rejectComment);
    NSString *strReject;
    NSInteger mode;
    if (imode==101){
        mode=101;
    }else{
        mode=102;
    }
    
    if ([rejectComment isEqualToString:@""]){
        strReject=@"";
    }else{
        strReject=rejectComment;
    }
    
    NSLog(@"employee id--%@",empID);
    NSLog(@"leavetype ID---%@",leaveId);
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    
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
                             "<ApplyLeave xmlns=\"http://tempuri.org/\"><sCompanyID>%@</sCompanyID>,<sUsername>%@</sUsername>,<sLeaveID>%@</sLeaveID>,<sEmployeeID>%@</sEmployeeID>,<dtFromDate>%@</dtFromDate>,<dtToDate>%@</dtToDate>,<dNoOfDays>%f</dNoOfDays>,<sLeaveTypeID>%@</sLeaveTypeID>,<sReason>%@</sReason>,<sHalfFull>%@</sHalfFull>,<iMode>%ld</iMode>,<sRejectComment>%@</sRejectComment>"
                             "</ApplyLeave> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"Username"]],leaveId,[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],frmdate,tdate,day,leaveTypeId,reasonDesc,strFullHalf,(long)mode,strReject];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%ld",(long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/ApplyLeave" forHTTPHeaderField:@"SOAPAction"];
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
        if ([elementName isEqualToString:@"mytable"])
        {
        }
        if ([elementName isEqualToString:@"LeaveID"])
        {
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
    else if([strIdentifier isEqualToString:@"2"])
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
    else
    {
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
        if ([elementName isEqualToString:@"LeaveID"])
        {
            strLeaveIDapproval=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strMessageCodeapproval=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strMessageTextapproval=currentElementValue;
            currentElementValue=nil;
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
            strnoofMessagecode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"NoOfLeaveDays"])
        {
            strnoofdaysvalue=currentElementValue;
            currentElementValue=nil;
        }
    }
    else
    {
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        if ([strMessageCodeapproval isEqualToString:@"0"])
        {
            if (Useraction==321)
            {
                [self GoTOThankYouPage:@"Leave request has been rejected."];
            }
            else if (Useraction==123)
            {
                [self GoTOThankYouPage:@"Leave request has been approved."];
            }
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:strMessageTextapproval
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
        int code=[strnoofMessagecode intValue];
        if (code==0)
        {
            _txtNoofDays.text=strnoofdaysvalue;
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Error in days count. please try again."
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
    else
    {
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

#pragma mark - Attachment Popup Method
-(void)openAttachmentPopup:(NSString *)strSelectedCell imgUrl:(NSString *)strUrl
{
    [self showLoadingMode];
    mainBg = [[UIView alloc] initWithFrame:CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height)];
    mainBg.backgroundColor =[UIColor whiteColor];
    
    bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,mainBg.frame.size.width,64)];
    bgVwHeader.backgroundColor =[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
    [mainBg addSubview:bgVwHeader];
    
    webvwImgPopup = [[UIImageView alloc]initWithFrame:CGRectMake(60,128,bgVwHeader.frame.size.width-120,300)];
    webvwImgPopup.backgroundColor=[UIColor whiteColor];
    [bgVwHeader addSubview:webvwImgPopup];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    self.view.userInteractionEnabled=NO;
    NSURL *imgUrl = [NSURL URLWithString:[strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    [self downloadImageWithURL:imgUrl completionBlock:^(BOOL succeeded, NSData *data) {
        if (succeeded)
        {
            //webvwImgPopup.contentMode=UIViewContentModeScaleAspectFit;
            webvwImgPopup.image= [[UIImage alloc] initWithData:data];
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            self.view.userInteractionEnabled=YES;
            [self hideLoadingMode];
        }
        else
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            self.view.userInteractionEnabled=YES;
            [self hideLoadingMode];
        }
    }];
    
    btnDonepdf=[UIButton buttonWithType:UIButtonTypeCustom];
    btnDonepdf.frame=CGRectMake(8, 28, 60, 28);
    [btnDonepdf setBackgroundColor:[UIColor clearColor]];
    [btnDonepdf setTitle:@"Done" forState:UIControlStateNormal];
    [btnDonepdf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnDonepdf.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16.0];
    [btnDonepdf addTarget:self action:@selector(donepdf:) forControlEvents:UIControlEventTouchUpInside];
    [btnDonepdf clipsToBounds];
    [bgVwHeader addSubview:btnDonepdf];
    
    [self.view addSubview:mainBg];
}
-(void)donepdf:(UIButton *)sender
{
    [mainBg removeFromSuperview];
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

@end
