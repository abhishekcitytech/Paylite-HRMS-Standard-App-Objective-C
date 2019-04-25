//
//  LeaveBalance.m
//  Paylite HR
//
//  Created by Sandipan on 10/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "LeaveBalance.h"

@interface LeaveBalance ()

@end

@implementation LeaveBalance

#pragma mark - ViewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self fetchLeaveType]; 
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
    border.frame = CGRectMake(0, _txtLeaveType.frame.size.height - borderWidth, _txtLeaveType.frame.size.width, _txtLeaveType.frame.size.height);
    border.borderWidth = borderWidth;
    [_txtLeaveType.layer addSublayer:border];
    _txtLeaveType.layer.masksToBounds = YES;
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

#pragma mark -  Generate Press Method
- (IBAction)pressGenerate:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *strAsondate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    NSLog(@"strAsondate :%@",strAsondate);
    [self fetchLeaveBalanceStrutre:strAsondate];
}
-(void)fetchLeaveBalanceStrutre:(NSString *)strDTT
{
    strIdentifier=@"2";
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
                             "<GetEmployeeLeave xmlns=\"http://tempuri.org/\"><sEmployeeID>%@</sEmployeeID>,<sYear>%@</sYear>,<sLeaveType>%@</sLeaveType>"
                             "</GetEmployeeLeave> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],strDTT,strIDDD];
    
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
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        NSLog(@"arrMLeaveType :%@",arrMLeaveType);
        
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
        else
        {
            /*NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy"];
            NSString *strAsondate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
            NSLog(@"strAsondate :%@",strAsondate);
            [self fetchLeaveBalanceStrutre:strAsondate];
            _viewBox.hidden=YES;*/
        }
    }
    else if([strIdentifier isEqualToString:@"2"])
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
}


#pragma mark - UITextField Delegate Method
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField==_txtLeaveType)
    {
        Activetxtfld=textField;
        [self popupList];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==_txtLeaveType)
    {
        Activetxtfld=textField;
        [self popupList];
        return NO;
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}
-(void)textFieldDidChange :(UITextField *)theTextField
{
}

#pragma mark - Create LeaveType PopUP List Method
-(void)popupList
{
    if (tblView!=nil)
    {
        [tblView removeFromSuperview];
        tblView=nil;
    }
    else
    {
        
        NSLog(@"arrMLeaveType :%@",arrMLeaveType);
        
        NSLog(@"yyy----> %f",CGRectGetMaxY(Activetxtfld.frame));
    
        tblView=[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(Activetxtfld.frame),CGRectGetMaxY(Activetxtfld.frame)+2, CGRectGetWidth(Activetxtfld.frame), 0) style:UITableViewStylePlain];
        tblView.delegate=self;
        tblView.dataSource=self;
        [_viewBox addSubview:tblView];
        
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
    return [arrMLeaveType count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    cell.accessoryType=UITableViewCellAccessoryNone;
    
    cell.backgroundColor=[UIColor whiteColor];
    
    objLeaveType *obj=[arrMLeaveType objectAtIndex:indexPath.row];
    
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    objLeaveType *obj=[arrMLeaveType objectAtIndex:indexPath.row];
    _txtLeaveType.text=[NSString stringWithFormat:@"%@",obj.strLeaveType];
    strIDDD=[NSString stringWithFormat:@"%@",obj.strLeaveID];
    
    [self handleTap];
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
