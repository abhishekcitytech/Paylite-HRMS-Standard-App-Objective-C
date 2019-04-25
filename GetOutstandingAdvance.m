//
//  GetOutstandingAdvance.m
//  Paylite HRMS
//
//  Created by Sandipan on 10/07/17.
//  Copyright © 2017 SANDIPAN. All rights reserved.
//

#import "GetOutstandingAdvance.h"

@interface GetOutstandingAdvance ()

@end

@implementation GetOutstandingAdvance

#pragma mark - ViewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *strToDate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    NSLog(@"strToDate :%@",strToDate);
    
    NSDate *OneYearDaysAgo = [[NSDate date] dateByAddingTimeInterval:-365*24*60*60];
    NSString *strFromDate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:OneYearDaysAgo]];
    NSLog(@"strFromDate :%@",strFromDate);
    
    _txtFromDate.text=strFromDate;
    _txtToDate.text=strToDate;
    //_viewBox.hidden=YES;
    //[self generateReport:_txtFromDate.text strtodate:_txtToDate.text];
}

#pragma mark - ViewDidLoad Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    _vwH.layer.shadowRadius = 3.0f;
    _vwH.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _vwH.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _vwH.layer.shadowOpacity = 0.5f;
    _vwH.layer.masksToBounds = NO;
    
    [_btnGenerate.layer setMasksToBounds:YES];
    [_btnGenerate.layer setCornerRadius: 4.0];
    [_btnGenerate.layer setBorderWidth:0.0];
    [_btnGenerate.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _txtFromDate.frame.size.height - borderWidth, _txtFromDate.frame.size.width, _txtFromDate.frame.size.height);
    border.borderWidth = borderWidth;
    [_txtFromDate.layer addSublayer:border];
    _txtFromDate.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 0.5;
    border1.borderColor = [UIColor lightGrayColor].CGColor;
    border1.frame = CGRectMake(0, _txtToDate.frame.size.height - borderWidth1, _txtToDate.frame.size.width, _txtToDate.frame.size.height);
    border1.borderWidth = borderWidth1;
    [_txtToDate.layer addSublayer:border1];
    _txtToDate.layer.masksToBounds = YES;
   
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.barTintColor=[UIColor whiteColor];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(Next)],
                           nil];
    [numberToolbar sizeToFit];
    _txtFromDate.inputAccessoryView = numberToolbar;
    
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
    
    /*if (_viewBox.isHidden==NO) {
        _viewBox.hidden=YES;
    }*/
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

#pragma mark - Create UIDatePicker Method
- (void) initializeTextFieldInputView1
{
    datePicker1 = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    
    if ( [_txtFromDate.text isEqualToString:@""])
    {
        datePicker1.date=[NSDate date];
    }
    else
    {
        NSString *dateStr =_txtFromDate.text;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *date = [dateFormat dateFromString:dateStr];
        datePicker1.date=date;
    }
    
    datePicker1.backgroundColor = [UIColor whiteColor];
    [datePicker1 addTarget:self action:@selector(dateUpdated1:) forControlEvents:UIControlEventValueChanged];
    _txtFromDate.inputView = datePicker1;
}
- (void) dateUpdated1:(UIDatePicker *)datePicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    _txtFromDate.text =[formatter stringFromDate:datePicker.date];
}
- (void) initializeTextFieldInputView2
{
    datePicker2 = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker2.datePickerMode = UIDatePickerModeDate;
    
    if ( [_txtFromDate.text isEqualToString:@""])
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
        NSString *dateStr =_txtFromDate.text;
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
    if ([strComparedate isEqualToString:@"1"]) {
        _txtToDate.text=@"";
    }else{
    }
}

#pragma mark - Next/Cancel Press Method
-(void)Next
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    _txtFromDate.text =[formatter stringFromDate:datePicker1.date];
    [self initializeTextFieldInputView2];
    
    UITextField *txtfld=(UITextField *)actvtextbox;
    if (txtfld==_txtFromDate)
    {
        txtfld=_txtToDate;
    }
    [txtfld becomeFirstResponder];
}
-(void)cancel
{
    UITextField *txtfld=(UITextField *)actvtextbox;
    [txtfld resignFirstResponder];
}

#pragma mark - Done/Cancel Press Method
-(void)Done
{
    strComparedate=@"";
    UITextField *txtfld=(UITextField *)actvtextbox;
    [txtfld resignFirstResponder];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *FromDate = [dateFormatter dateFromString:_txtFromDate.text];
    NSDate *ToDate = [dateFormatter dateFromString:_txtToDate.text];
    
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
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        _txtToDate.text =[formatter stringFromDate:datePicker2.date];
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
    if (textField == _txtFromDate)
    {
        [self initializeTextFieldInputView1];
    }
    else if (textField == _txtToDate)
    {
        [self initializeTextFieldInputView2];
    }
    actvtextbox=textField;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _txtFromDate)
    {
    }
    else if (textField == _txtToDate)
    {
    }
    actvtextbox=textField;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField==_txtFromDate)
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



#pragma mark -  Generate Press Method
- (IBAction)pressGenerate:(id)sender
{
    if ([_txtFromDate.text isEqualToString:@""] || [_txtToDate.text isEqualToString:@""])
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
        NSLog(@"_txtFromDate %@",_txtFromDate.text);
        NSLog(@"_txtFromDate %@",_txtToDate.text);
        [self generateReport:_txtFromDate.text strtodate:_txtToDate.text];
        
    }
}
-(void)generateReport:(NSString*)strFromDate strtodate:(NSString*)strToDate
{
    strIdentifier=@"1";
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<GetEmployeeAdvanceOutstanding xmlns=\"http://tempuri.org/\"><sEmployeeID>%@</sEmployeeID>,<sFromDate>%@</sFromDate>,<sToDate>%@</sToDate>"
                             "</GetEmployeeAdvanceOutstanding> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],strFromDate,strToDate];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%ld",(long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetEmployeeAdvanceOutstanding" forHTTPHeaderField:@"SOAPAction"];
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
        if ([elementName isEqualToString:@"FileLocation"])
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
        if ([elementName isEqualToString:@"FileLocation"])
        {
            strFileLoctn=currentElementValue;
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
                                          message:@"Error in advance outstanding."
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
    [mainBg removeFromSuperview];
    [self restrictRotation:NO];
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    [UINavigationController attemptRotationToDeviceOrientation];
    /*if (_viewBox.isHidden==YES) {
        _viewBox.hidden=NO;
    }*/
}
-(void)printpdf:(UIButton *)sender
{
    [mainBg removeFromSuperview];
    [self restrictRotation:NO];
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    [UINavigationController attemptRotationToDeviceOrientation];
    /*if (_viewBox.isHidden==YES) {
        _viewBox.hidden=NO;
    }*/
    
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
    /*if (_viewBox.isHidden==YES) {
        _viewBox.hidden=NO;
    }*/
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
     NSString *recipients = @"mailto:?cc=&subject=Paylite HRMS Oustanding Advance!";
    NSString *strBodymessage=[NSString stringWithFormat:@"%@\n\n%@",@"Hello Sir,",@"please check your attached oustanding advance report."];
    NSString *body = [NSString stringWithFormat:@"&body=%@",strBodymessage];
    NSString *email = [NSString stringWithFormat:@"%@%@\n\n%@", recipients, body,strFileLoctn];
    email = [email stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email] options:@{} completionHandler:nil];
}
- (void)showEmail:(NSData*)file
{
    NSString *emailTitle = @"Paylite HRMS Oustanding Advance!";
    NSString *strBodymessage=[NSString stringWithFormat:@"%@\n\n%@",@"Hello Sir,",@"please check your attached oustanding advance report."];
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
