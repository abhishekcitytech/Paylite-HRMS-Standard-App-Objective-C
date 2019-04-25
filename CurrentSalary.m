//
//  CurrentSalary.m
//  Paylite HR
//
//  Created by Sandipan on 01/01/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "CurrentSalary.h"

@interface CurrentSalary ()

@end

@implementation CurrentSalary

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
    
    _vwH.layer.shadowRadius = 3.0f;
    _vwH.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _vwH.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _vwH.layer.shadowOpacity = 0.5f;
    _vwH.layer.masksToBounds = NO;
    
    _tabvSalaryinfo.backgroundView=nil;
    _tabvSalaryinfo.backgroundColor=[UIColor clearColor];
    _tabvSalaryinfo.separatorColor=[UIColor clearColor];
    _tabvSalaryinfo.showsVerticalScrollIndicator=NO;
    
    _tabvSalaryinfo.hidden=YES;
    
    [self downloadCurrentSalary];
    
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

#pragma mark - Fetch Current Salary Setup Method
-(void)downloadCurrentSalary
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
                             "<GetSalarySetup xmlns=\"http://tempuri.org/\"><sEmployeeID>%@</sEmployeeID>"
                             "</GetSalarySetup> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]]];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetSalarySetup" forHTTPHeaderField:@"SOAPAction"];
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
        if ([elementName isEqualToString:@"NewDataSet"])
        {
            dicData=[[NSMutableDictionary alloc] init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
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
        if ([elementName isEqualToString:@"Grade"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Designation"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"ActualProgressionDate"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Basic"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"GrossSalary"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"ProgressionDueDate"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"AllowanceNameAndAmount"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DeductionNameAndAmount"])
        {
            currentElementValue=[NSMutableString string];
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
        if ([elementName isEqualToString:@"ID"])
        {
            [dicData setObject:currentElementValue forKey:@"ID"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"EmployeeCode"])
        {
            [dicData setObject:currentElementValue forKey:@"EmployeeCode"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Employee"])
        {
            [dicData setObject:currentElementValue forKey:@"Employee"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Department"])
        {
            [dicData setObject:currentElementValue forKey:@"Department"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Grade"])
        {
            [dicData setObject:currentElementValue forKey:@"Grade"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Designation"])
        {
            [dicData setObject:currentElementValue forKey:@"Designation"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"ActualProgressionDate"])
        {
            [dicData setObject:currentElementValue forKey:@"ActualProgressionDate"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Basic"])
        {
            [dicData setObject:currentElementValue forKey:@"Basic"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"GrossSalary"])
        {
            [dicData setObject:currentElementValue forKey:@"GrossSalary"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"ProgressionDueDate"])
        {
            [dicData setObject:currentElementValue forKey:@"ProgressionDueDate"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"AllowanceNameAndAmount"])
        {
            if ([currentElementValue isEqualToString:@""]||currentElementValue == nil)
            {
                [dicData setObject:@"" forKey:@"AllowanceNameAndAmount"];
            }
            else{
                [dicData setObject:currentElementValue forKey:@"AllowanceNameAndAmount"];
            }
            
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DeductionNameAndAmount"])
        {
            if ([currentElementValue isEqualToString:@""]||currentElementValue == nil)
            {
                [dicData setObject:@"" forKey:@"DeductionNameAndAmount"];
            }
            else{
                [dicData setObject:currentElementValue forKey:@"DeductionNameAndAmount"];
            }
            
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strMessagecode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strMessagetext=currentElementValue;
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
        if ([strMessagecode isEqualToString:@"0"])
        {
            _tabvSalaryinfo.hidden=NO;
            
            NSMutableDictionary *dicTempComp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicCompanyDetails"];
            NSString *strCurrency=[NSString stringWithFormat:@"%@",[dicTempComp valueForKey:@"CurrencySymbol"]];
    
            
            NSLog(@"dicData :%@",dicData);
            
            //--------------------- Array Sorting Method --------------------
            arrMSortedData=[[NSMutableArray alloc] init];
            NSString *str1=[NSString stringWithFormat:@"Actual Progression Date: %@",[dicData valueForKey:@"ActualProgressionDate"]];
            NSString *str2=[NSString stringWithFormat:@"Progression Due Date: %@",[dicData valueForKey:@"ProgressionDueDate"]];
            NSString *str3=[NSString stringWithFormat:@"Basic Salary: %@ %@",strCurrency,[dicData valueForKey:@"Basic"]];
            [arrMSortedData addObject:str1];
            [arrMSortedData addObject:str2];
            [arrMSortedData addObject:str3];
            NSLog(@"arrMSortedData: %@",arrMSortedData);
            //---------------------------------------------------------------
            NSString *strAllowanceNameAndAmount=[NSString stringWithFormat:@"%@",[dicData valueForKey:@"AllowanceNameAndAmount"]];
            if ([strAllowanceNameAndAmount isEqualToString:@""]||strAllowanceNameAndAmount == nil){
                arrMAllowanceNameAndAmount=nil;
            }
            else{
                arrMAllowanceNameAndAmount = [strAllowanceNameAndAmount componentsSeparatedByString:@","];
            }
            NSLog(@"arrMAllowanceNameAndAmount:%@",arrMAllowanceNameAndAmount);
            //---------------------------------------------------------------
            NSString *strDeductionNameAndAmount=[NSString stringWithFormat:@"%@",[dicData valueForKey:@"DeductionNameAndAmount"]];
            if ([strDeductionNameAndAmount isEqualToString:@""]||strDeductionNameAndAmount == nil){
                arrMDeductionNameAndAmount=nil;
            }
            else{
                arrMDeductionNameAndAmount = [strDeductionNameAndAmount componentsSeparatedByString:@","];
            }
            NSLog(@"arrMDeductionNameAndAmount:%@",arrMDeductionNameAndAmount);
            
            //---------------------------------------------------------------
            arrMSortedData1=[[NSMutableArray alloc] init];
            NSString *str6=[NSString stringWithFormat:@"Total Salary: %@ %@",strCurrency,[dicData valueForKey:@"GrossSalary"]];
            [arrMSortedData1 addObject:str6];
            NSLog(@"arrMSortedData1: %@",arrMSortedData1);
            //---------------------------------------------------------------
        
            [_tabvSalaryinfo reloadData];
        }
        else
        {
            //Failure
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"There are no salary data."
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

#pragma mark - UITableView Delegate & DataSource Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"arrMAllowanceNameAndAmount count%ld",(unsigned long)[arrMAllowanceNameAndAmount count]);
    NSLog(@"arrMDeductionNameAndAmount count%ld",(unsigned long)[arrMDeductionNameAndAmount count]);
    
    if ([arrMAllowanceNameAndAmount count]==0 && [arrMDeductionNameAndAmount count]==0)
    {
        return 2;
    }
    if ([arrMDeductionNameAndAmount count]==0)
    {
        return 3;
    }
    else if ([arrMAllowanceNameAndAmount count]==0)
    {
        return 3;
    }
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([arrMAllowanceNameAndAmount count]==0 && [arrMDeductionNameAndAmount count]==0)
    {
        if (section==0)
        {
            return [arrMSortedData count];
        }
        else if (section==1)
        {
            return [arrMSortedData1 count];
        }
    }
    if ([arrMDeductionNameAndAmount count]==0)
    {
        if (section==0) {
            return [arrMSortedData count];
        }
        else if (section==1){
            return [arrMAllowanceNameAndAmount count];
        }
        else if (section==2){
            return [arrMSortedData1 count];
        }
    }
    else if ([arrMAllowanceNameAndAmount count]==0)
    {
        if (section==0) {
            return [arrMSortedData count];
        }
        else if (section==1){
            return [arrMDeductionNameAndAmount count];
        }
        else if (section==2){
            return [arrMSortedData1 count];
        }
    }
    else
    {
        if (section==0) {
            return [arrMSortedData count];
        }
        else if (section==1){
            return [arrMAllowanceNameAndAmount count];
        }
        else if (section==2){
            return [arrMDeductionNameAndAmount count];
        }
        else if (section==3){
            return [arrMSortedData1 count];
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([arrMAllowanceNameAndAmount count]==0 && [arrMDeductionNameAndAmount count]==0)
    {
        if (section==0)
        {
            return 1;
        }
        else if (section==1)
        {
            return 1;
        }
    }
    if ([arrMDeductionNameAndAmount count]==0)
    {
        if (section==0)
        {
            return 1;
        }
        else if (section==1)
        {
            return 44;
        }
        else if (section==2)
        {
            return 1;
        }
    }
    else if ([arrMAllowanceNameAndAmount count]==0)
    {
        if (section==0)
        {
            return 1;
        }
        else if (section==1)
        {
            return 44;
        }
        else if (section==2)
        {
            return 1;
        }
    }
    else
    {
        if (section==0)
        {
            return 1;
        }
        else if (section==1)
        {
            return 44;
        }
        else if (section==2)
        {
            return 44;
        }
        else if (section==3)
        {
            return 1;
        }
    }
    
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView;
    
    if ([arrMAllowanceNameAndAmount count]==0 && [arrMDeductionNameAndAmount count]==0)
    {
        if (section==0)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 0)];
            headerView.backgroundColor = [UIColor clearColor];
            
        }
        else if (section==1)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 0)];
            headerView.backgroundColor = [UIColor clearColor];
        }
    }
    if ([arrMDeductionNameAndAmount count]==0)
    {
        if (section==0)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 0)];
            headerView.backgroundColor = [UIColor clearColor];
        }
        else if (section==1)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 44)];
            
            UILabel *lbl1=[[UILabel alloc] initWithFrame:CGRectMake(10,0,145,44)];
            lbl1.textColor=[UIColor darkGrayColor];
            lbl1.textAlignment=NSTextAlignmentLeft;
            lbl1.font=[UIFont fontWithName:@"GothamBook" size:14];
            lbl1.backgroundColor=[UIColor clearColor];
            lbl1.text=[NSString stringWithFormat:@" %@",@"Allowance"];
            
            if ([arrMAllowanceNameAndAmount count]==0) {
                headerView.backgroundColor = [UIColor clearColor];
            }
            else{
                headerView.backgroundColor = [UIColor colorWithRed:222/256.0 green:222/256.0 blue:222/256.0 alpha:1.0];
                [headerView addSubview:lbl1];
            }
        }
        else if (section==2)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 0)];
            headerView.backgroundColor = [UIColor clearColor];
        }
    }
    else if ([arrMAllowanceNameAndAmount count]==0)
    {
        if (section==0)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 0)];
            headerView.backgroundColor = [UIColor clearColor];
        }
        else if (section==1)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 44)];
            
            UILabel *lbl1=[[UILabel alloc] initWithFrame:CGRectMake(10,0,145,44)];
            lbl1.textColor=[UIColor whiteColor];
            lbl1.textAlignment=NSTextAlignmentLeft;
            lbl1.font=[UIFont fontWithName:@"GothamBook" size:14];
            lbl1.backgroundColor=[UIColor clearColor];
            lbl1.text=[NSString stringWithFormat:@" %@",@"Deduction"];
           
            if ([arrMDeductionNameAndAmount count]==0) {
                headerView.backgroundColor = [UIColor clearColor];
            }
            else{
                headerView.backgroundColor = [UIColor colorWithRed:224/256.0 green:85/256.0 blue:55/256.0 alpha:1.0];
                [headerView addSubview:lbl1];
            }
        }
        else if (section==2)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 0)];
            headerView.backgroundColor = [UIColor clearColor];
        }
    }
    else
    {
        if (section==0)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 0)];
            headerView.backgroundColor = [UIColor clearColor];
        }
        else if (section==1)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 44)];
            
            UILabel *lbl1=[[UILabel alloc] initWithFrame:CGRectMake(10,0,145,44)];
            lbl1.textColor=[UIColor darkGrayColor];
            lbl1.textAlignment=NSTextAlignmentLeft;
            lbl1.font=[UIFont fontWithName:@"GothamBook" size:14];
            lbl1.backgroundColor=[UIColor clearColor];
            lbl1.text=[NSString stringWithFormat:@" %@",@"Allowance"];
            
            if ([arrMAllowanceNameAndAmount count]==0) {
                headerView.backgroundColor = [UIColor clearColor];
            }
            else{
                headerView.backgroundColor = [UIColor colorWithRed:222/256.0 green:222/256.0 blue:222/256.0 alpha:1.0];
                [headerView addSubview:lbl1];
            }
        }
        else if (section==2)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 44)];
            
            UILabel *lbl1=[[UILabel alloc] initWithFrame:CGRectMake(10,0,145,44)];
            lbl1.textColor=[UIColor whiteColor];
            lbl1.textAlignment=NSTextAlignmentLeft;
            lbl1.font=[UIFont fontWithName:@"GothamBook" size:14];
            lbl1.backgroundColor=[UIColor clearColor];
            lbl1.text=[NSString stringWithFormat:@" %@",@"Deduction"];
            
            if ([arrMDeductionNameAndAmount count]==0) {
                headerView.backgroundColor = [UIColor clearColor];
            }
            else{
                headerView.backgroundColor = [UIColor colorWithRed:224/256.0 green:85/256.0 blue:55/256.0 alpha:1.0];
                [headerView addSubview:lbl1];
            }
        }
        else if (section==3)
        {
            headerView = [[UIView alloc] init];
            [headerView setFrame:CGRectMake(0, 0, _tabvSalaryinfo.frame.size.width, 0)];
            headerView.backgroundColor = [UIColor clearColor];
        }
    }
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    
    NSMutableDictionary *dicTempComp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicCompanyDetails"];
    NSString *strCurrency=[NSString stringWithFormat:@"%@",[dicTempComp valueForKey:@"CurrencySymbol"]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    UILabel *lbl1=[[UILabel alloc] initWithFrame:CGRectMake(15,0,tableView.frame.size.width,44)];
    lbl1.textColor=[UIColor darkGrayColor];
    lbl1.textAlignment=NSTextAlignmentLeft;
    lbl1.font=[UIFont fontWithName:@"GothamBook" size:13];
    lbl1.backgroundColor=[UIColor clearColor];
    [cell.contentView addSubview:lbl1];
    
    if ([arrMAllowanceNameAndAmount count]==0 && [arrMDeductionNameAndAmount count]==0)
    {
        if (indexPath.section==0)
        {
            lbl1.text=[NSString stringWithFormat:@"%@",[arrMSortedData objectAtIndex:indexPath.row]];
        }
        else if (indexPath.section==1)
        {
            NSLog(@"gross :%@",[arrMSortedData1 objectAtIndex:indexPath.row]);
            
            cell.backgroundColor = [UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
            cell.textLabel.text=[NSString stringWithFormat:@"%@",[arrMSortedData1 objectAtIndex:indexPath.row]];
            cell.textLabel.textColor=[UIColor whiteColor];
            cell.textLabel.font=[UIFont fontWithName:@"GothamBook" size:14];
        }
    }
    if ([arrMDeductionNameAndAmount count]==0)
    {
        if (indexPath.section==0)
        {
            lbl1.text=[NSString stringWithFormat:@"%@",[arrMSortedData objectAtIndex:indexPath.row]];
        }
        else if (indexPath.section==1)
        {
            NSString *strValue=[arrMAllowanceNameAndAmount objectAtIndex:indexPath.row];
            if ([strValue rangeOfString:[NSString stringWithFormat:@"%@",@":"]].location != NSNotFound)
            {
                NSString *strModified = [strValue stringByReplacingOccurrencesOfString:@":" withString:[NSString stringWithFormat:@": %@ ",strCurrency]];
                
                lbl1.text=strModified;
            }
            else{
                lbl1.text=strValue;
            }
            
            
        }
        else if (indexPath.section==2)
        {
            NSLog(@"gross :%@",[arrMSortedData1 objectAtIndex:indexPath.row]);
            
            cell.backgroundColor = [UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
            cell.textLabel.text=[NSString stringWithFormat:@"%@",[arrMSortedData1 objectAtIndex:indexPath.row]];
            cell.textLabel.textColor=[UIColor whiteColor];
            cell.textLabel.font=[UIFont fontWithName:@"GothamBook" size:14];
        }
    }
    else if ([arrMAllowanceNameAndAmount count]==0)
    {
        if (indexPath.section==0)
        {
            lbl1.text=[NSString stringWithFormat:@"%@",[arrMSortedData objectAtIndex:indexPath.row]];
        }
        else if (indexPath.section==1)
        {
            NSString *strValue=[arrMDeductionNameAndAmount objectAtIndex:indexPath.row];
            if ([strValue rangeOfString:[NSString stringWithFormat:@"%@",@":"]].location != NSNotFound)
            {
                NSString *strModified = [strValue stringByReplacingOccurrencesOfString:@":" withString:[NSString stringWithFormat:@": %@ ",strCurrency]];
                
                lbl1.text=strModified;
            }
            else{
                lbl1.text=strValue;
            }
        }
        else if (indexPath.section==2)
        {
            NSLog(@"gross :%@",[arrMSortedData1 objectAtIndex:indexPath.row]);
            
            cell.backgroundColor = [UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
            cell.textLabel.text=[NSString stringWithFormat:@"%@",[arrMSortedData1 objectAtIndex:indexPath.row]];
            cell.textLabel.textColor=[UIColor whiteColor];
            cell.textLabel.font=[UIFont fontWithName:@"GothamBook" size:14];
        }
    }
    else
    {
        if (indexPath.section==0)
        {
            lbl1.text=[NSString stringWithFormat:@"%@",[arrMSortedData objectAtIndex:indexPath.row]];
        }
        else if (indexPath.section==1)
        {
            NSString *strValue=[arrMAllowanceNameAndAmount objectAtIndex:indexPath.row];
            if ([strValue rangeOfString:[NSString stringWithFormat:@"%@",@":"]].location != NSNotFound)
            {
                NSString *strModified = [strValue stringByReplacingOccurrencesOfString:@":" withString:[NSString stringWithFormat:@": %@ ",strCurrency]];
                
                lbl1.text=strModified;
            }
            else{
                lbl1.text=strValue;
            }
        }
        else if (indexPath.section==2)
        {
            NSString *strValue=[arrMDeductionNameAndAmount objectAtIndex:indexPath.row];
            if ([strValue rangeOfString:[NSString stringWithFormat:@"%@",@":"]].location != NSNotFound)
            {
                NSString *strModified = [strValue stringByReplacingOccurrencesOfString:@":" withString:[NSString stringWithFormat:@": %@ ",strCurrency]];
                
                lbl1.text=strModified;
            }
            else{
                lbl1.text=strValue;
            }
        }
        else if (indexPath.section==3)
        {
            NSLog(@"gross :%@",[arrMSortedData1 objectAtIndex:indexPath.row]);
            
            cell.backgroundColor = [UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
            cell.textLabel.text=[NSString stringWithFormat:@"%@",[arrMSortedData1 objectAtIndex:indexPath.row]];
            cell.textLabel.textColor=[UIColor whiteColor];
            cell.textLabel.font=[UIFont fontWithName:@"GothamBook" size:14];
            
        }
    }
    
    
    UILabel *lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(0,43.8,_tabvSalaryinfo.frame.size.width,0.2)];
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
