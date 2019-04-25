//
//  MyAdvance.m
//  Paylite HRMS
//
//  Created by SANDIPAN on 31/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "MyAdvance.h"

@interface MyAdvance ()

@end

@implementation MyAdvance

#pragma mark - viewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self downloadMYAdvance];
}

#pragma mark - viewDidLoad Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    app6=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _vwH.layer.shadowRadius = 3.0f;
    _vwH.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _vwH.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _vwH.layer.shadowOpacity = 0.5f;
    _vwH.layer.masksToBounds = NO;
    
    _tabvAdvance.backgroundView=nil;
    _tabvAdvance.backgroundColor=[UIColor whiteColor];
    _tabvAdvance.separatorColor=[UIColor clearColor];
    _tabvAdvance.showsVerticalScrollIndicator=NO;
    
    
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

#pragma mark - Fetch MyAdvance Method
-(void)downloadMYAdvance
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
                             "<GetMyAdvance xmlns=\"http://tempuri.org/\"><sCompanyID>%@</sCompanyID>,<sEmployeeID>%@</sEmployeeID>"
                             "</GetMyAdvance> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]]];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetMyAdvance" forHTTPHeaderField:@"SOAPAction"];
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
        if ([elementName isEqualToString:@"GetMyAdvanceResult"])
        {
            NSLog(@"rootis called..");
            arrMAdvanceDetails=[[NSMutableArray alloc] init];
        }
        if ([elementName isEqualToString:@"mytable"]) //Advance mytable
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
        if ([elementName isEqualToString:@"DESCRIPTION_ALIAS"])
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
        if ([elementName isEqualToString:@"mytable"]) //Advance mytable
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
        if ([elementName isEqualToString:@"DESCRIPTION_ALIAS"])
        {
            objad.DESCRIPTION_ALIAS=currentElementValue;
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
            
            [_tabvAdvance reloadData];
        }
        else
        {
            [_tabvAdvance reloadData];
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
    return 150.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
    cell.accessoryType = UITableViewCellAccessoryNone;
   
    NSMutableDictionary *dicTempComp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicCompanyDetails"];
    NSString *strCurrency=[NSString stringWithFormat:@"%@",[dicTempComp valueForKey:@"CurrencySymbol"]];
    objAdvanceDetails *obj=[arrMAdvanceDetails objectAtIndex:indexPath.section];
    
    UILabel *cellLable1,*cellLable3,*cellLable2;
    
    cellLable1=[[UILabel alloc] initWithFrame:CGRectMake(14,10, _tabvAdvance.frame.size.width-10, 17)];
    cellLable2=[[UILabel alloc] initWithFrame:CGRectMake(14,CGRectGetMaxY(cellLable1.frame)+5,_tabvAdvance.frame.size.width-10, 17)];
    cellLable3=[[UILabel alloc] initWithFrame:CGRectMake(14,CGRectGetMaxY(cellLable2.frame)+5, _tabvAdvance.frame.size.width-10, 17)];
    
    cellLable1.textColor=[UIColor darkGrayColor];
    cellLable2.textColor=[UIColor darkGrayColor];
    cellLable3.textColor=[UIColor darkGrayColor];
    
    cellLable1.backgroundColor=[UIColor clearColor];
    cellLable2.backgroundColor=[UIColor clearColor];
    cellLable3.backgroundColor=[UIColor clearColor];
    
    cellLable1.text=[NSString stringWithFormat:@"%@",obj.AdvanceType];
    cellLable3.text=obj.ApplicationDate;
    
    NSString *string = [NSString stringWithFormat:@"%@",obj.AdvanceAmount];
    cellLable2.text=[NSString stringWithFormat:@"%@ %@",string,strCurrency];
    
    
    UIView *viewBottomCell=[[UIView alloc] init];
    viewBottomCell.frame=CGRectMake(14,80,_tabvAdvance.frame.size.width-28,60);
    viewBottomCell.backgroundColor=[UIColor whiteColor];
    [cell.contentView addSubview:viewBottomCell];
    
    NSLog(@"obj.ReportedToStatus   %@",obj.ReportedToStatus);
    NSLog(@"obj.ApprovalAuthorityStatus   %@",obj.ApprovalAuthorityStatus);
    NSLog(@"obj.HRStatus   %@",obj.HRStatus);
    NSLog(@"obj.FinalAuthorityStatus   %@",obj.FinalAuthorityStatus);
    
    NSMutableArray *arrMbottomsection=[[NSMutableArray alloc] init];
    int noofbox=0;
    
    if (![obj.ReportedToStatus isEqualToString:@""]){
        noofbox=noofbox+1;
        NSMutableDictionary *dicMbottomsection=[[NSMutableDictionary alloc] init];
        [dicMbottomsection setObject:@"Line\nManager" forKey:@"name"];
        [dicMbottomsection setObject:obj.ReportedToStatus forKey:@"val"];
        [arrMbottomsection addObject:dicMbottomsection];
    }
    if (![obj.ApprovalAuthorityStatus isEqualToString:@""]){
        noofbox=noofbox+1;
        NSMutableDictionary *dicMbottomsection=[[NSMutableDictionary alloc] init];
        [dicMbottomsection setObject:@"Approval Authority" forKey:@"name"];
        [dicMbottomsection setObject:obj.ApprovalAuthorityStatus forKey:@"val"];
        [arrMbottomsection addObject:dicMbottomsection];
    }
    if (![obj.HRStatus isEqualToString:@""]){
        noofbox=noofbox+1;
        NSMutableDictionary *dicMbottomsection=[[NSMutableDictionary alloc] init];
        [dicMbottomsection setObject:@"HR" forKey:@"name"];
        [dicMbottomsection setObject:obj.HRStatus forKey:@"val"];
        [arrMbottomsection addObject:dicMbottomsection];
    }
    if (![obj.FinalAuthorityStatus isEqualToString:@""]){
        noofbox=noofbox+1;
        NSMutableDictionary *dicMbottomsection=[[NSMutableDictionary alloc] init];
        [dicMbottomsection setObject:@"Final Approver" forKey:@"name"];
        [dicMbottomsection setObject:obj.FinalAuthorityStatus forKey:@"val"];
        [arrMbottomsection addObject:dicMbottomsection];
    }
    NSLog(@"noofbox :%d",noofbox);
    //NSLog(@"arrMbottomsection :%@",arrMbottomsection);
    
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
    /*
    for (int fdfd=0; fdfd<noofbox; fdfd++)
    {
        UIView *viewBox=[[UIView alloc] init];
        CGFloat fffx=fdfd * viewBottomCell.bounds.size.width/noofbox;
        [viewBox setFrame:CGRectMake(fffx,0.0f,viewBottomCell.bounds.size.width/noofbox,viewBottomCell.bounds.size.height)];
        
        viewBox.backgroundColor=[UIColor whiteColor];
        
        [viewBox.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [viewBox.layer setBorderWidth: 0.0];
        [viewBox.layer setCornerRadius:0.0f];
        [viewBox.layer setMasksToBounds:YES];
        [viewBottomCell addSubview:viewBox];
        
        NSMutableDictionary *dictemp=[arrMbottomsection objectAtIndex:fdfd];
        
        UIImageView *imgVstatus=[[UIImageView alloc] initWithFrame:CGRectMake(10,8,20,20)];
        if ([[dictemp valueForKey:@"val"] isEqualToString:@"100"]){
            [imgVstatus setImage:[UIImage imageNamed:@"pending"]];
        }
        else if ([[dictemp valueForKey:@"val"] isEqualToString:@"101"]){
            [imgVstatus setImage:[UIImage imageNamed:@"approved"]];
        }
        else if ([[dictemp valueForKey:@"val"] isEqualToString:@"102"]){
            [imgVstatus setImage:[UIImage imageNamed:@"reject"]];
        }
        imgVstatus.backgroundColor=[UIColor clearColor];
        [viewBox addSubview:imgVstatus];
        
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgVstatus.frame)+10,0,viewBox.frame.size.width-30-imgVstatus.frame.size.width,40)];
        lblTitle.text=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"name"]];
        lblTitle.numberOfLines=4;
        lblTitle.textAlignment=NSTextAlignmentLeft;
        lblTitle.textColor=[UIColor lightGrayColor];
        lblTitle.font=[UIFont fontWithName:@"GothamBook" size:13];
        lblTitle.backgroundColor=[UIColor clearColor];
        [viewBox addSubview:lblTitle];
    }
*/
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
        else if(screenSize.height == 667.0f){
            //6
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
        else if(screenSize.height == 812.0f){
            //X
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
        else{
            cellLable1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable2.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellLable3.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
    }
    
    [cell.contentView addSubview:cellLable1];
    [cell.contentView addSubview:cellLable3];
    [cell.contentView addSubview:cellLable2];
    
    UILabel *lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(15,149.7,_tabvAdvance.frame.size.width-15,0.3)];
    lblSeparator.backgroundColor=[UIColor lightGrayColor];
    [cell.contentView addSubview:lblSeparator];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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


#pragma  mark - Apply  Advance Method
- (IBAction)pressApplyAdvance:(id)sender
{
    ApplyAdvance *objDemo;
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            objDemo = [[ApplyAdvance alloc] initWithNibName:@"ApplyAdvance5S" bundle:nil];
        }
        else if(screenSize.height == 667.0f){
            //6
            objDemo = [[ApplyAdvance alloc] initWithNibName:@"ApplyAdvance6" bundle:nil];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            objDemo = [[ApplyAdvance alloc] initWithNibName:@"ApplyAdvance6Plus" bundle:nil];
        }
        else if(screenSize.height == 812.0f){
            //X
            objDemo = [[ApplyAdvance alloc] initWithNibName:@"ApplyAdvanceX" bundle:nil];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            objDemo = [[ApplyAdvance alloc] initWithNibName:@"ApplyAdvanceXSMAX" bundle:nil];
        }
        else{
            objDemo = [[ApplyAdvance alloc] initWithNibName:@"ApplyAdvance" bundle:nil];
        }
    }
    else
    {
    }
    [self.navigationController pushViewController:objDemo animated:YES];
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
