//
//  ApprovalAdvance.m
//  Paylite HRMS
//
//  Created by SANDIPAN on 21/06/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ApprovalAdvance.h"

@interface ApprovalAdvance ()

@end

@implementation ApprovalAdvance


#pragma mark - viewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    _btnPending.selected=YES;
    _btnApproved.selected=NO;
    _btnRejected.selected=NO;
    
    [self downloadMyAdvance:@"100"];
    
    [_selected setImage:[UIImage imageNamed:@"sPending"]];
    [self animateToActiveButton:_btnPending withImageview:_selected];
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
    
    _tabvApprovalAdvance.backgroundView=nil;
    _tabvApprovalAdvance.backgroundColor=[UIColor clearColor];
    _tabvApprovalAdvance.separatorColor=[UIColor clearColor];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
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

#pragma mark - Swipe Gesture Right/Left  Method
- (IBAction)tappedRightButton:(id)sender
{
    if (_btnPending.selected==YES)
    {
        _btnPending.selected=NO;
        _btnApproved.selected=YES;
        _btnRejected.selected=NO;
        
        [self downloadMyAdvance:@"101"];
        
        [_selected setImage:[UIImage imageNamed:@"sApproved"]];
        [self animateToActiveButton:_btnApproved withImageview:_selected];
    }
    else if (_btnApproved.selected==YES)
    {
        _btnPending.selected=NO;
        _btnApproved.selected=NO;
        _btnRejected.selected=YES;
        
        [self downloadMyAdvance:@"102"];
        
        [_selected setImage:[UIImage imageNamed:@"sRejected"]];
        [self animateToActiveButton:_btnRejected withImageview:_selected];
    }
    
}
- (IBAction)tappedLeftButton:(id)sender
{
    if (_btnRejected.selected==YES)
    {
        _btnPending.selected=NO;
        _btnApproved.selected=YES;
        _btnRejected.selected=NO;
        
        [self downloadMyAdvance:@"101"];
        
        [_selected setImage:[UIImage imageNamed:@"sApproved"]];
        [self animateToActiveButton:_btnApproved withImageview:_selected];
    }
    else if (_btnApproved.selected==YES)
    {
        _btnPending.selected=YES;
        _btnApproved.selected=NO;
        _btnRejected.selected=NO;
        
        [self downloadMyAdvance:@"100"];
        
        [_selected setImage:[UIImage imageNamed:@"sPending"]];
        [self animateToActiveButton:_btnPending withImageview:_selected];
    }
    
}

#pragma mark - Press Pending / Approved / Rejected Method
- (IBAction)pressPending:(id)sender
{
    if (_btnPending.selected==YES)
    {
    }
    else
    {
        _btnPending.selected=YES;
        _btnApproved.selected=NO;
        _btnRejected.selected=NO;
        
        [self downloadMyAdvance:@"100"];
        
        
    }
    
    [_selected setImage:[UIImage imageNamed:@"sPending"]];
    [self animateToActiveButton:sender withImageview:_selected];
}
- (IBAction)pressApproved:(id)sender
{
    if (_btnApproved.selected==YES)
    {
    }
    else
    {
        _btnPending.selected=NO;
        _btnApproved.selected=YES;
        _btnRejected.selected=NO;
        
        [self downloadMyAdvance:@"101"];
    }
    
    [_selected setImage:[UIImage imageNamed:@"sApproved"]];
    [self animateToActiveButton:sender withImageview:_selected];
}
- (IBAction)pressRejected:(id)sender
{
    if (_btnRejected.selected==YES)
    {
    }
    else
    {
        _btnPending.selected=NO;
        _btnApproved.selected=NO;
        _btnRejected.selected=YES;
        
        [self downloadMyAdvance:@"102"];
    }
    
    [_selected setImage:[UIImage imageNamed:@"sRejected"]];
    [self animateToActiveButton:sender withImageview:_selected];
}

#pragma mark - AnimateToActiveButton Method
-(void)animateToActiveButton:(UIButton *)btn withImageview:(UIImageView *)img
{
    img.backgroundColor=[UIColor whiteColor];
    [UIView animateWithDuration:0.35 animations:^{
        img.frame=btn.frame;
    }];
}

#pragma mark- Download Advance
-(void)downloadMyAdvance:(NSString *)strSStatus
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
                             "<GetPendingAdvance xmlns=\"http://tempuri.org/\"><sCompanyID>%@</sCompanyID>,<sEmployeeID>%@</sEmployeeID>,<sStatus>%@</sStatus>"
                             "</GetPendingAdvance> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],strSStatus];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetPendingAdvance" forHTTPHeaderField:@"SOAPAction"];
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
#pragma mark- Url Connection Delegate method
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
        if ([elementName isEqualToString:@"GetPendingAdvanceResult"])
        {
            NSLog(@"rootis called..");
            arrMAdvanceDetails=[[NSMutableArray alloc]init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            objad=[[objAdvanceDetails alloc] init];
        }
        if ([elementName isEqualToString:@"ApplicationDate"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"ID"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"EmployeeCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Employee"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Department"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Gender"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"AdvanceStatusCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"AdvanceTypeID"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"AdvanceType"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"AdvanceAmount"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"NoOfInstallmentMonth"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"RepaymentAmount"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"YearNO"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"MonthName"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Reason"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"ReportedToStatus"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"ApprovalAuthorityStatus"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"HRStatus"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"FinalAuthorityStatus"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"L1Senior"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"L2Senior"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"L3Senior"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"L4Senior"])
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
            [arrMAdvanceDetails addObject:objad];
        }
        if ([elementName isEqualToString:@"ApplicationDate"])
        {
            objad.ApplicationDate=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"ID"])
        {
            objad.ID=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"EmployeeCode"])
        {
            objad.EmployeeCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Employee"])
        {
            objad.Employee=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Department"])
        {
            objad.Department=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Gender"])
        {
            objad.Gender=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"AdvanceStatusCode"])
        {
            objad.AdvanceStatusCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"AdvanceTypeID"])
        {
            objad.AdvanceTypeID=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"AdvanceType"])
        {
            objad.AdvanceType=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"AdvanceAmount"])
        {
            objad.AdvanceAmount=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"NoOfInstallmentMonth"])
        {
            objad.NoOfInstallmentMonth=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"RepaymentAmount"])
        {
            objad.RepaymentAmount=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"YearNO"])
        {
            objad.YearNO=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MonthName"])
        {
            objad.MonthName=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Reason"])
        {
            objad.reason=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"ReportedToStatus"])
        {
            objad.ReportedToStatus=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"ApprovalAuthorityStatus"])
        {
            objad.ApprovalAuthorityStatus=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"HRStatus"])
        {
            objad.HRStatus=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"FinalAuthorityStatus"])
        {
            objad.FinalAuthorityStatus=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"L1Senior"])
        {
            objad.L1Senior=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"L2Senior"])
        {
            objad.L2Senior=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"L3Senior"])
        {
            objad.L3Senior=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"L4Senior"])
        {
            objad.L4Senior=currentElementValue;
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
        NSLog(@"arrMAdvanceDetails :>>> %@",arrMAdvanceDetails);
        
        if ([arrMAdvanceDetails count]==0)
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"There are no requests."
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
            [_tabvApprovalAdvance reloadData];
        }
        else
        {
            [_tabvApprovalAdvance reloadData];
        }
    }
    else
    {
    }
}

#pragma mark - UITableView Delegate & DataSource Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([arrMAdvanceDetails count]>0)
    {
        return [arrMAdvanceDetails count];
    }
    else
    {
        return 0;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 190.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    NSMutableDictionary *dicTempComp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicCompanyDetails"];
    NSString *strCurrency=[NSString stringWithFormat:@"%@",[dicTempComp valueForKey:@"CurrencySymbol"]];
    
    objAdvanceDetails *obj=[arrMAdvanceDetails objectAtIndex:indexPath.section];
    
    UILabel *cellLable1,*cellLable2,*cellLable3,*cellLable4;
    
    cellLable1=[[UILabel alloc] initWithFrame:CGRectMake(14,10, _tabvApprovalAdvance.frame.size.width-10, 17)];
    cellLable2=[[UILabel alloc] initWithFrame:CGRectMake(14,CGRectGetMaxY(cellLable1.frame)+10, _tabvApprovalAdvance.frame.size.width-10, 17)];
    cellLable3=[[UILabel alloc] initWithFrame:CGRectMake(14,CGRectGetMaxY(cellLable2.frame)+10, _tabvApprovalAdvance.frame.size.width-10, 17)];
    cellLable4=[[UILabel alloc] initWithFrame:CGRectMake(14,CGRectGetMaxY(cellLable3.frame)+10, _tabvApprovalAdvance.frame.size.width-10, 17)];
    
    cellLable1.textColor=[UIColor darkGrayColor];
    cellLable2.textColor=[UIColor darkGrayColor];
    cellLable3.textColor=[UIColor darkGrayColor];
    cellLable4.textColor=[UIColor darkGrayColor];
    
    cellLable1.backgroundColor=[UIColor clearColor];
    cellLable2.backgroundColor=[UIColor clearColor];
    cellLable3.backgroundColor=[UIColor clearColor];
    cellLable4.backgroundColor=[UIColor clearColor];
    
    cellLable1.text=obj.Employee;
    cellLable2.text=[NSString stringWithFormat:@"%@",obj.AdvanceType];
    cellLable3.text=obj.ApplicationDate;
    
    NSString *string = [NSString stringWithFormat:@"%@",obj.AdvanceAmount];
    cellLable4.text=[NSString stringWithFormat:@"%@ %@",string,strCurrency];
    
    
    UIView *viewBottomCell=[[UIView alloc] init];
    viewBottomCell.frame=CGRectMake(14,120, _tabvApprovalAdvance.frame.size.width-28,60);
    viewBottomCell.backgroundColor=[UIColor whiteColor];
    [cell.contentView addSubview:viewBottomCell];
    
    NSLog(@"L1Senior   %@",obj.L1Senior);
    NSLog(@"L2Senior   %@",obj.L2Senior);
    NSLog(@"L3Senior   %@",obj.L3Senior);
    NSLog(@"L4Senior   %@",obj.L4Senior);
    
    NSLog(@"ReportedToStatus   %@",obj.ReportedToStatus);
    NSLog(@"ApprovalAuthorityStatus   %@",obj.ApprovalAuthorityStatus);
    NSLog(@"HRStatus   %@",obj.HRStatus);
    NSLog(@"FinalAuthorityStatus   %@",obj.FinalAuthorityStatus);
    
    NSMutableArray *arrMbottomsection=[[NSMutableArray alloc] init];
    int noofbox=0;
   
    if (![obj.ReportedToStatus isEqualToString:@""] || ![obj.L1Senior isEqualToString:@""]){
        noofbox=noofbox+1;
        NSMutableDictionary *dicMbottomsection=[[NSMutableDictionary alloc] init];
        [dicMbottomsection setObject:@"Line\nManager" forKey:@"name"];
        if ([obj.ReportedToStatus isEqualToString:@""]) {
            [dicMbottomsection setObject:@"100" forKey:@"val"];
        }
        else{
            [dicMbottomsection setObject:obj.ReportedToStatus forKey:@"val"];
        }
        [arrMbottomsection addObject:dicMbottomsection];
    }
    if (![obj.ApprovalAuthorityStatus isEqualToString:@""] || ![obj.L2Senior isEqualToString:@""]){
        noofbox=noofbox+1;
        NSMutableDictionary *dicMbottomsection=[[NSMutableDictionary alloc] init];
        [dicMbottomsection setObject:@"Approval Authority" forKey:@"name"];
        if ([obj.ApprovalAuthorityStatus isEqualToString:@""]) {
            [dicMbottomsection setObject:@"100" forKey:@"val"];
        }
        else{
            [dicMbottomsection setObject:obj.ApprovalAuthorityStatus forKey:@"val"];
        }
        [arrMbottomsection addObject:dicMbottomsection];
    }
    if (![obj.HRStatus isEqualToString:@""] || ![obj.L3Senior isEqualToString:@""]){
        noofbox=noofbox+1;
        NSMutableDictionary *dicMbottomsection=[[NSMutableDictionary alloc] init];
        [dicMbottomsection setObject:@"HR" forKey:@"name"];
        if ([obj.HRStatus isEqualToString:@""]) {
            [dicMbottomsection setObject:@"100" forKey:@"val"];
        }
        else{
            [dicMbottomsection setObject:obj.HRStatus forKey:@"val"];
        }
        [arrMbottomsection addObject:dicMbottomsection];
    }
    if (![obj.FinalAuthorityStatus isEqualToString:@""] || ![obj.L4Senior isEqualToString:@""]){
        noofbox=noofbox+1;
        NSMutableDictionary *dicMbottomsection=[[NSMutableDictionary alloc] init];
        [dicMbottomsection setObject:@"Final Approver" forKey:@"name"];
        if ([obj.FinalAuthorityStatus isEqualToString:@""]) {
            [dicMbottomsection setObject:@"100" forKey:@"val"];
        }
        else{
            [dicMbottomsection setObject:obj.FinalAuthorityStatus forKey:@"val"];
        }
        [arrMbottomsection addObject:dicMbottomsection];
    }
    
    NSLog(@"noofbox :%d",noofbox);
    NSLog(@"arrMbottomsection :%@",arrMbottomsection);
    
    for (int fdfd=0; fdfd<noofbox; fdfd++)
    {
        
        UIView *viewBox=[[UIView alloc] init];
        CGFloat fffx=fdfd * viewBottomCell.bounds.size.width/noofbox;
        [viewBox setFrame:CGRectMake(fffx,0.0f,viewBottomCell.bounds.size.width/noofbox,viewBottomCell.bounds.size.height)];
        viewBox.backgroundColor=[UIColor clearColor];
        [viewBottomCell addSubview:viewBox];
        
        UIButton *btnDonepdf=[UIButton buttonWithType:UIButtonTypeCustom];
        btnDonepdf.frame=CGRectMake(0,3,20,20);
        [btnDonepdf setBackgroundColor:[UIColor clearColor]];
        [btnDonepdf setImage:[UIImage imageNamed:@"circle-gray"] forState:UIControlStateNormal];
        btnDonepdf.tag= fdfd;
        [btnDonepdf.layer setMasksToBounds:YES];
        [btnDonepdf.layer setCornerRadius: btnDonepdf.frame.size.width/2];
        [btnDonepdf.layer setBorderWidth:0.0];
        [btnDonepdf.layer setBorderColor:[[UIColor clearColor] CGColor]];
        [viewBox addSubview:btnDonepdf];
        
        UILabel *lblNumber=[[UILabel alloc] initWithFrame:CGRectMake(0,3,20,20)];
        lblNumber.backgroundColor=[UIColor clearColor];
        lblNumber.textAlignment=NSTextAlignmentCenter;
        lblNumber.textColor=[UIColor darkGrayColor];
        lblNumber.font=[UIFont fontWithName:@"GothamBold" size:10];
        lblNumber.text=[NSString stringWithFormat:@"%d",fdfd+1];
        [viewBox addSubview:lblNumber];
        
        UILabel *lblLine;
        lblLine.numberOfLines=2;
        if (fdfd<noofbox-1)
        {
            lblLine=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnDonepdf.frame)-1,CGRectGetMidY(btnDonepdf.frame)-1,viewBox.frame.size.width-btnDonepdf.frame.size.width+2,2)];
            [lblLine.layer setMasksToBounds:YES];
            [lblLine.layer setCornerRadius:0.0];
            [lblLine.layer setBorderWidth:0.0];
            [lblLine.layer setBorderColor:[[UIColor clearColor] CGColor]];
            [viewBox addSubview:lblLine];
        }
        
        NSMutableDictionary *dictemp=[arrMbottomsection objectAtIndex:fdfd];
        if ([[dictemp valueForKey:@"val"] isEqualToString:@"100"]){
            [btnDonepdf setImage:[UIImage imageNamed:@"circle-gray"] forState:UIControlStateNormal];
            lblLine.backgroundColor=[UIColor colorWithRed:220/256.0 green:220/256.0 blue:220/256.0 alpha:1.0];
        }
        else if ([[dictemp valueForKey:@"val"] isEqualToString:@"101"]){
            [btnDonepdf setImage:[UIImage imageNamed:@"circle-green"] forState:UIControlStateNormal];
            lblLine.backgroundColor=[UIColor colorWithRed:141/256.0 green:221/256.0 blue:156/256.0 alpha:1.0];
        }
        else if ([[dictemp valueForKey:@"val"] isEqualToString:@"102"]){
            [btnDonepdf setImage:[UIImage imageNamed:@"circle-red"] forState:UIControlStateNormal];
            lblLine.backgroundColor=[UIColor colorWithRed:220/256.0 green:220/256.0 blue:220/256.0 alpha:1.0];
        }
        
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(viewBox.frame)-35,viewBox.frame.size.width,35)];
        lblTitle.text=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"name"]];
        lblTitle.numberOfLines=4;
        lblTitle.textAlignment=NSTextAlignmentLeft;
        lblTitle.textColor=[UIColor darkGrayColor];
        lblTitle.font=[UIFont fontWithName:@"GothamBook" size:13];
        lblTitle.backgroundColor=[UIColor clearColor];
        [viewBox addSubview:lblTitle];
    }
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:12];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:12];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:12];
            cellLable4.font=[UIFont fontWithName:@"GothamBook" size:12];
        }
        else if(screenSize.height == 667.0f){
            //6
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable4.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable4.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
        else if(screenSize.height == 812.0f){
            //X
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable4.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable4.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
        else{
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:11];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:11];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:11];
            cellLable4.font=[UIFont fontWithName:@"GothamBook" size:11];
        }
    }
    
    [cell.contentView addSubview:cellLable1];
    [cell.contentView addSubview:cellLable2];
    [cell.contentView addSubview:cellLable3];
    [cell.contentView addSubview:cellLable4];
    
    /*[cell.layer setMasksToBounds:YES];
    [cell.layer setCornerRadius: 4.0];
    [cell.layer setBorderWidth:0.2];
    [cell.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];*/
    
    UILabel *lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(0,189.7,_tabvApprovalAdvance.frame.size.width,0.3)];
    lblSeparator.backgroundColor=[UIColor lightGrayColor];
    [cell.contentView addSubview:lblSeparator];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    objAdvanceDetails *obj=[arrMAdvanceDetails objectAtIndex:indexPath.section];
    
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSLog(@"EmployeeID :%@",[dicTemp valueForKey:@"EmployeeID"]);
    NSLog(@"CompanyID :%@",[dicTemp valueForKey:@"CompanyID"]);
    NSLog(@"isManager :%@",[dicTemp valueForKey:@"isManager"]);
    NSLog(@"isHR :%@",[dicTemp valueForKey:@"isHR"]);
    
    NSLog(@"ReportedToStatus :%@",obj.ReportedToStatus);
    NSLog(@"ApprovalAuthorityStatus :%@",obj.ApprovalAuthorityStatus);
    NSLog(@"HRStatus :%@",obj.HRStatus);
    NSLog(@"FinalAuthorityStatus :%@",obj.FinalAuthorityStatus);
    
    NSLog(@"L1Senior :%@",obj.L1Senior);
    NSLog(@"L2Senior :%@",obj.L2Senior);
    NSLog(@"L3Senior :%@",obj.L3Senior);
    NSLog(@"L4Senior :%@",obj.L4Senior);
    
    
    if ([[dicTemp valueForKey:@"EmployeeID"]isEqualToString:obj.L1Senior])
    {
        //Line Manager
        if ([obj.ReportedToStatus isEqualToString:@"100"])
        {
            //pending
            ApprovalAdvanceDetails *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                }
                else{
                    //4S
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                }
            }
            else
            {
            }
            objDemo.objadssss=obj;
            [self.navigationController pushViewController:objDemo animated:YES];
        }
        else if ([obj.ReportedToStatus isEqualToString:@"101"])
        {
            //approved
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"You have already approved this application."
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
        else if ([obj.ReportedToStatus isEqualToString:@"102"])
        {
            //rejected
           
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"You have already rejected this application."
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
            //nothing
            ApprovalAdvanceDetails *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                }
                else{
                    //4S
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                }
            }
            else
            {
            }
            objDemo.objadssss=obj;
            [self.navigationController pushViewController:objDemo animated:YES];
        }
    }
    else if ([[dicTemp valueForKey:@"EmployeeID"]isEqualToString:obj.L2Senior])
    {
        //Approval authority
        if ([obj.ApprovalAuthorityStatus isEqualToString:@"100"])
        {
            //pending
            
            if ([obj.ReportedToStatus isEqualToString:@"100"])
            {
                //l1 pending
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"Line manager has not taken any action yet."
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
            else if ([obj.ReportedToStatus isEqualToString:@"101"])
            {
                //l1 approved
                ApprovalAdvanceDetails *objDemo;
                CGSize screenSize=[[UIScreen mainScreen]bounds].size;
                if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
                {
                    if (screenSize.height==568.0f){
                        //5S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                    }
                    else if(screenSize.height == 667.0f){
                        //6
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                    }
                    else if(screenSize.height == 736.0f){
                        //6Plus
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                    }
                    else if(screenSize.height == 812.0f){
                        //X
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                    }
                    else if(screenSize.height == 896.0f){
                        //XSMAX XR
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                    }
                    else{
                        //4S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                    }
                }
                else
                {
                }
                objDemo.objadssss=obj;
                [self.navigationController pushViewController:objDemo animated:YES];
            }
            else if ([obj.ReportedToStatus isEqualToString:@"102"])
            {
                //l1 rejected
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"Line manager has rejected this application."
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
                ApprovalAdvanceDetails *objDemo;
                CGSize screenSize=[[UIScreen mainScreen]bounds].size;
                if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
                {
                    if (screenSize.height==568.0f){
                        //5S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                    }
                    else if(screenSize.height == 667.0f){
                        //6
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                    }
                    else if(screenSize.height == 736.0f){
                        //6Plus
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                    }
                    else if(screenSize.height == 812.0f){
                        //X
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                    }
                    else if(screenSize.height == 896.0f){
                        //XSMAX XR
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                    }
                    else{
                        //4S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                    }
                }
                else
                {
                }
                objDemo.objadssss=obj;
                [self.navigationController pushViewController:objDemo animated:YES];
            }
        }
        else if ([obj.ApprovalAuthorityStatus isEqualToString:@"101"])
        {
            //approved
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"You have already approved this application."
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
        else if ([obj.ApprovalAuthorityStatus isEqualToString:@"102"])
        {
            //rejected
           
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"You have already rejected this application."
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
            //nothing
            ApprovalAdvanceDetails *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                }
                else{
                    //4S
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                }
            }
            else
            {
            }
            objDemo.objadssss=obj;
            [self.navigationController pushViewController:objDemo animated:YES];
        }
    }
    else if ([[dicTemp valueForKey:@"isHR"] isEqualToString:obj.L3Senior])
    {
        //HR
        if ([obj.HRStatus isEqualToString:@"100"])
        {
            //pending
            
            if ([obj.ReportedToStatus isEqualToString:@"100"])
            {
                //l1 pending
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"Line Manager still not take action."
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
            else if ([obj.ApprovalAuthorityStatus isEqualToString:@"100"])
            {
                //l2 pending
               
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"Approval authority has not taken any action yet."
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
            else if ([obj.ReportedToStatus isEqualToString:@"101"])
            {
                //l1 approved
                ApprovalAdvanceDetails *objDemo;
                CGSize screenSize=[[UIScreen mainScreen]bounds].size;
                if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
                {
                    if (screenSize.height==568.0f){
                        //5S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                    }
                    else if(screenSize.height == 667.0f){
                        //6
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                    }
                    else if(screenSize.height == 736.0f){
                        //6Plus
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                    }
                    else if(screenSize.height == 812.0f){
                        //X
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                    }
                    else if(screenSize.height == 896.0f){
                        //XSMAX XR
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                    }
                    else{
                        //4S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                    }
                }
                else
                {
                }
                objDemo.objadssss=obj;
                [self.navigationController pushViewController:objDemo animated:YES];
            }
            else if ([obj.ApprovalAuthorityStatus isEqualToString:@"101"])
            {
                //l2 approved
                ApprovalAdvanceDetails *objDemo;
                CGSize screenSize=[[UIScreen mainScreen]bounds].size;
                if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
                {
                    if (screenSize.height==568.0f){
                        //5S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                    }
                    else if(screenSize.height == 667.0f){
                        //6
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                    }
                    else if(screenSize.height == 736.0f){
                        //6Plus
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                    }
                    else if(screenSize.height == 812.0f){
                        //X
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                    }
                    else if(screenSize.height == 896.0f){
                        //XSMAX XR
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                    }
                    else{
                        //4S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                    }
                }
                else
                {
                }
                objDemo.objadssss=obj;
                [self.navigationController pushViewController:objDemo animated:YES];
            }
            else if ([obj.ReportedToStatus isEqualToString:@"102"])
            {
                //l1 rejected
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"Line Manager already rejected this application."
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
            else if ([obj.ApprovalAuthorityStatus isEqualToString:@"102"]){
                //l2 rejected
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"Approval authority has rejected this application."
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
                ApprovalAdvanceDetails *objDemo;
                CGSize screenSize=[[UIScreen mainScreen]bounds].size;
                if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
                {
                    if (screenSize.height==568.0f){
                        //5S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                    }
                    else if(screenSize.height == 667.0f){
                        //6
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                    }
                    else if(screenSize.height == 736.0f){
                        //6Plus
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                    }
                    else if(screenSize.height == 812.0f){
                        //X
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                    }
                    else if(screenSize.height == 896.0f){
                        //XSMAX XR
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                    }
                    else{
                        //4S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                    }
                }
                else
                {
                }
                objDemo.objadssss=obj;
                [self.navigationController pushViewController:objDemo animated:YES];
            }
        }
        else if ([obj.HRStatus isEqualToString:@"101"])
        {
            //approved
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"You have already approved this application."
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
        else if ([obj.HRStatus isEqualToString:@"102"])
        {
            //rejected
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"You have already rejected this application."
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
            //nothing
            ApprovalAdvanceDetails *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                }
                else{
                    //4S
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                }
            }
            else
            {
            }
            objDemo.objadssss=obj;
            [self.navigationController pushViewController:objDemo animated:YES];
        }
    }
    else if ([[dicTemp valueForKey:@"EmployeeID"]isEqualToString:obj.L4Senior])
    {
        //Final approval
        if ([obj.FinalAuthorityStatus isEqualToString:@"100"])
        {
            //pending
            
            if ([obj.ReportedToStatus isEqualToString:@"100"])
            {
                //l1 pending
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"Line manager has not taken any action yet."
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
            else if ([obj.ApprovalAuthorityStatus isEqualToString:@"100"])
            {
                //l2 pending
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"Approval authority has not taken any action yet."
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
            else if ([obj.HRStatus isEqualToString:@"100"])
            {
                //l3 pending
               
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"HR has not taken any action yet."
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
            else if ([obj.ReportedToStatus isEqualToString:@"101"])
            {
                //l1 approved
                ApprovalAdvanceDetails *objDemo;
                CGSize screenSize=[[UIScreen mainScreen]bounds].size;
                if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
                {
                    if (screenSize.height==568.0f){
                        //5S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                    }
                    else if(screenSize.height == 667.0f){
                        //6
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                    }
                    else if(screenSize.height == 736.0f){
                        //6Plus
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                    }
                    else if(screenSize.height == 812.0f){
                        //X
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                    }
                    else if(screenSize.height == 896.0f){
                        //XSMAX XR
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                    }
                    else{
                        //4S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                    }
                }
                else
                {
                }
                objDemo.objadssss=obj;
                [self.navigationController pushViewController:objDemo animated:YES];
            }
            else if ([obj.ApprovalAuthorityStatus isEqualToString:@"101"])
            {
                //l2 approved
                ApprovalAdvanceDetails *objDemo;
                CGSize screenSize=[[UIScreen mainScreen]bounds].size;
                if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
                {
                    if (screenSize.height==568.0f){
                        //5S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                    }
                    else if(screenSize.height == 667.0f){
                        //6
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                    }
                    else if(screenSize.height == 736.0f){
                        //6Plus
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                    }
                    else if(screenSize.height == 812.0f){
                        //X
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                    }
                    else if(screenSize.height == 896.0f){
                        //XSMAX XR
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                    }
                    else{
                        //4S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                    }
                }
                else
                {
                }
                objDemo.objadssss=obj;
                [self.navigationController pushViewController:objDemo animated:YES];
            }
            else if ([obj.HRStatus isEqualToString:@"101"])
            {
                //l3 approved
                ApprovalAdvanceDetails *objDemo;
                CGSize screenSize=[[UIScreen mainScreen]bounds].size;
                if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
                {
                    if (screenSize.height==568.0f){
                        //5S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                    }
                    else if(screenSize.height == 667.0f){
                        //6
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                    }
                    else if(screenSize.height == 736.0f){
                        //6Plus
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                    }
                    else if(screenSize.height == 812.0f){
                        //X
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                    }
                    else if(screenSize.height == 896.0f){
                        //XSMAX XR
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                    }
                    else{
                        //4S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                    }
                }
                else
                {
                }
                objDemo.objadssss=obj;
                [self.navigationController pushViewController:objDemo animated:YES];
            }
            else if ([obj.ReportedToStatus isEqualToString:@"102"])
            {
                //l1 rejected
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"Line manager has rejected this application."
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
            else if ([obj.ApprovalAuthorityStatus isEqualToString:@"102"])
            {
                //l2 rejected
               
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"Approval authority has rejected this application."
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
            else if ([obj.HRStatus isEqualToString:@"102"])
            {
                //l3 rejected
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:@"HR has rejected this application."
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
                ApprovalAdvanceDetails *objDemo;
                CGSize screenSize=[[UIScreen mainScreen]bounds].size;
                if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
                {
                    if (screenSize.height==568.0f){
                        //5S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                    }
                    else if(screenSize.height == 667.0f){
                        //6
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                    }
                    else if(screenSize.height == 736.0f){
                        //6Plus
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                    }
                    else if(screenSize.height == 812.0f){
                        //X
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                    }
                    else if(screenSize.height == 896.0f){
                        //XSMAX XR
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                    }
                    else{
                        //4S
                        objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                    }
                }
                else
                {
                }
                objDemo.objadssss=obj;
                [self.navigationController pushViewController:objDemo animated:YES];
            }
        }
        else if ([obj.FinalAuthorityStatus isEqualToString:@"101"])
        {
            //approved
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"You have already approved this application."
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
        else if ([obj.FinalAuthorityStatus isEqualToString:@"102"])
        {
            //rejected
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"You have already rejected this application."
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
            //nothing
            ApprovalAdvanceDetails *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetailsXSMAX" bundle:nil];
                }
                else{
                    //4S
                    objDemo = [[ApprovalAdvanceDetails alloc] initWithNibName:@"ApprovalAdvanceDetails" bundle:nil];
                }
            }
            else
            {
            }
            objDemo.objadssss=obj;
            [self.navigationController pushViewController:objDemo animated:YES];
        }
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
