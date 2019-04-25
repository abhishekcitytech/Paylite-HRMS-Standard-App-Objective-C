//
//  PublicHoliday.m
//  Paylite HR
//
//  Created by Sandipan on 02/01/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "PublicHoliday.h"

@interface PublicHoliday ()

@end

@implementation PublicHoliday

#pragma mark - viewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    viewListview.hidden=YES;
    viewCalendarwithlist.hidden=YES;
    
    [self downloadPublicHoliday];
}

#pragma mark - viewWillAppear Method
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

#pragma mark - viewDidLoad Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    _vwH.layer.shadowRadius = 3.0f;
    _vwH.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _vwH.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _vwH.layer.shadowOpacity = 0.5f;
    _vwH.layer.masksToBounds = NO;
    
    strSelectedDate=@"";
    currentDT=[NSDate date];
    self.title = @"FSCalendar";
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter1 = [[NSDateFormatter alloc] init];
    self.dateFormatter1.dateFormat = @"dd/MM/yyyy";
    self.dateFormatter2 = [[NSDateFormatter alloc] init];
    self.dateFormatter2.dateFormat = @"dd-MM-yyyy";
    calendar.accessibilityIdentifier = @"calendar";
    
    [self loadOnlyListView];
    [self loadCalanderView];
    
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

#pragma mark - press Toggle Method
- (IBAction)pressbtnToggle:(id)sender
{
    UIButton *btn =(UIButton *)sender;
    if (btn.tag==1)
    {
        if (lblMessage!=nil) {
            [lblMessage removeFromSuperview];
        }
        
        [_btnToggle setBackgroundImage:[UIImage imageNamed:@"calendarview"] forState:UIControlStateNormal];
        _btnToggle.tag=2;
        viewListview.hidden=NO;
        viewCalendarwithlist.hidden=YES;
        [tabvListHolidayOverAll reloadData];
    }
    else if (btn.tag==2)
    {
        if (lblMessage!=nil) {
            [lblMessage removeFromSuperview];
        }
        
        [_btnToggle setBackgroundImage:[UIImage imageNamed:@"listview"] forState:UIControlStateNormal];
        _btnToggle.tag=1;
        viewListview.hidden=YES;
        viewCalendarwithlist.hidden=NO;
        
        //-------- Current Month page have any Holiday ---------------
        currentDT=calendar.currentPage;
        NSLog(@"currentDT :%@",currentDT);
        
        currentDT=calendar.currentPage;
        //NSLog(@"currentDT :%@",currentDT);//Wed Aug  1 00:00:00 2018
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
        NSDate *date = currentDT;
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"dd/MM/yyyy"];
        NSString *result = [df stringFromDate:date];
        NSArray *foo = [result componentsSeparatedByString: @"/"];
        NSString *monthvalue = [foo objectAtIndex: 1];
        NSString *yearvalue = [foo objectAtIndex: 2];
        NSLog(@"monthvalue :%@",monthvalue);
        NSLog(@"yearvalue :%@",yearvalue);
        
        NSString *strFilterVal=[NSString stringWithFormat:@"%@/%@",monthvalue,yearvalue];
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", strFilterVal];
        NSArray *filteredArray1 = [arrMallDateList filteredArrayUsingPredicate:predicate1];
        arrMallDateListFilter=[filteredArray1 mutableCopy];
        
        NSPredicate *p3 = [NSPredicate predicateWithFormat:@"(strHMonth = %@) AND (strHYear = %@)", monthvalue,yearvalue];
        NSLog(@"p3 :%@",p3);
        NSArray *filteredArray = [arrMHolidayListOverAll filteredArrayUsingPredicate:p3];
        arrMHolidayList=[filteredArray mutableCopy];
        
        if (lblMessage!=nil) {
            [lblMessage removeFromSuperview];
        }
        lblMessage=[[UILabel alloc] init];
        lblMessage.frame=CGRectMake(0,CGRectGetMaxY(calendar.frame)+30,UIScreen.mainScreen.bounds.size.width,200);
        lblMessage.textAlignment=NSTextAlignmentCenter;
        lblMessage.textColor=[UIColor darkGrayColor];
        lblMessage.text=@"There are no holidays in this month";
        lblMessage.font=[UIFont fontWithName:@"GothamBook" size:14.0];
        lblMessage.numberOfLines=10;
        lblMessage.backgroundColor=[UIColor clearColor];
        [self.view addSubview:lblMessage];
        
        if ([filteredArray count]>0) {
            tabvListHoliday.hidden=NO;
            lblMessage.hidden=YES;
        }else{
            lblMessage.hidden=NO;
            tabvListHoliday.hidden=YES;
        }
        [tabvListHoliday reloadData];
        
        if (self.datesWithEvent!=nil) {
            self.datesWithEvent=nil;
        }
        self.datesWithEvent = arrMallDateListFilter;
        [calendar reloadData];
    }
}

#pragma mark - Fetch Public Holiday Method
-(void)downloadPublicHoliday
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
                             "<GetHolidayList xmlns=\"http://tempuri.org/\"><sCompanyID>%@</sCompanyID>"
                             "</GetHolidayList> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]]];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetHolidayList" forHTTPHeaderField:@"SOAPAction"];
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
        if ([elementName isEqualToString:@"GetHolidayListResult"])
        {
            arrMHolidayListOverAll=[[NSMutableArray alloc]init];
            arrMallDateList=[[NSMutableArray alloc]init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            objHL=[[objHolidayList alloc]init];
        }
        if ([elementName isEqualToString:@"Holiday_Date"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"HolidayDescription"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Year"])
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
            [arrMHolidayListOverAll addObject:objHL];
        }
        if ([elementName isEqualToString:@"Holiday_Date"])
        {
            objHL.strHDate=currentElementValue;
            
            NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
            [dateFormat1 setDateFormat:@"dd/MM/yyyy"];
            NSDate *date = [dateFormat1 dateFromString:objHL.strHDate];
            NSString *result = [dateFormat1 stringFromDate:date];
            
            NSArray *foo = [result componentsSeparatedByString: @"/"];
            NSString *dayvalue = [foo objectAtIndex: 0];
            NSString *monthvalue = [foo objectAtIndex: 1];
            NSString *yearvalue = [foo objectAtIndex: 2];
            NSLog(@"dayvalue :%@",dayvalue);
            NSLog(@"monthvalue :%@",monthvalue);
            NSLog(@"yearvalue :%@",yearvalue);
            objHL.strHDay = [NSString stringWithFormat:@"%@",dayvalue];
            objHL.strHMonth = [NSString stringWithFormat:@"%@",monthvalue];
            objHL.strHYear = [NSString stringWithFormat:@"%@",yearvalue];
            
            [arrMallDateList addObject:objHL.strHDate];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"HolidayDescription"])
        {
            objHL.strHName=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Year"])
        {
            strGetLatestYear=currentElementValue;
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
        if ([arrMHolidayListOverAll count]==0){
        }
        else
        {
            _lblHeaderTitle.text=@"Public Holiday";
            //NSLog(@"arrMHolidayListOverAll :%@",arrMHolidayListOverAll);
            //NSLog(@"arrMallDateList >>>>> %@",arrMallDateList);
            
            [_btnToggle setBackgroundImage:[UIImage imageNamed:@"listview"] forState:UIControlStateNormal];
            _btnToggle.tag=1;
            viewListview.hidden=YES;
            viewCalendarwithlist.hidden=NO;
            
            currentDT=calendar.currentPage;
            //NSLog(@"currentDT :%@",currentDT);//Wed Aug  1 00:00:00 2018
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
            NSDate *date = currentDT;
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"dd/MM/yyyy"];
            NSString *result = [df stringFromDate:date];
            NSArray *foo = [result componentsSeparatedByString: @"/"];
            NSString *monthvalue = [foo objectAtIndex: 1];
            NSString *yearvalue = [foo objectAtIndex: 2];
            NSLog(@"monthvalue :%@",monthvalue);
            NSLog(@"yearvalue :%@",yearvalue);
            
            NSString *strFilterVal=[NSString stringWithFormat:@"%@/%@",monthvalue,yearvalue];
            NSLog(@"strFilterVal :%@",strFilterVal);
            NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", strFilterVal];
            NSArray *filteredArray1 = [arrMallDateList filteredArrayUsingPredicate:predicate1];
            arrMallDateListFilter=[filteredArray1 mutableCopy];
            
            NSPredicate *p3 = [NSPredicate predicateWithFormat:@"(strHMonth = %@) AND (strHYear = %@)", monthvalue,yearvalue];
            NSLog(@"p3 :%@",p3);
            NSArray *filteredArray = [arrMHolidayListOverAll filteredArrayUsingPredicate:p3];
            arrMHolidayList=[filteredArray mutableCopy];
            
            if (lblMessage!=nil) {
                [lblMessage removeFromSuperview];
            }
            lblMessage=[[UILabel alloc] init];
            lblMessage.frame=CGRectMake(0,CGRectGetMaxY(calendar.frame)+30,UIScreen.mainScreen.bounds.size.width,200);
            lblMessage.textAlignment=NSTextAlignmentCenter;
            lblMessage.textColor=[UIColor darkGrayColor];
            lblMessage.text=@"There are no holidays this month.";
            lblMessage.font=[UIFont fontWithName:@"GothamBook" size:14.0];
            lblMessage.numberOfLines=10;
            lblMessage.backgroundColor=[UIColor clearColor];
            [self.view addSubview:lblMessage];
            
            if ([filteredArray count]>0) {
                tabvListHoliday.hidden=NO;
                lblMessage.hidden=YES;
            }else{
                lblMessage.hidden=NO;
                tabvListHoliday.hidden=YES;
            }
            [tabvListHoliday reloadData];
            
            if (self.datesWithEvent!=nil) {
                self.datesWithEvent=nil;
            }
            self.datesWithEvent = arrMallDateListFilter;
            [calendar reloadData];
            
        }
    }
}


#pragma mark - Create Only List View Method
- (void)loadOnlyListView
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            viewListview=[[UIView alloc] initWithFrame:CGRectMake(0,64, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-64)];
        }
        else if(screenSize.height == 667.0f){
            //6
            viewListview=[[UIView alloc] initWithFrame:CGRectMake(0,64, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-64)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            viewListview=[[UIView alloc] initWithFrame:CGRectMake(0,64, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-64)];
        }
        else if(screenSize.height == 812.0f){
            //X
            viewListview=[[UIView alloc] initWithFrame:CGRectMake(0,84, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-84)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            viewListview=[[UIView alloc] initWithFrame:CGRectMake(0,84, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-84)];
        }
        else{
            viewListview=[[UIView alloc] initWithFrame:CGRectMake(0,64, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-64)];
        }
    }
    else
    {
    }
    
    viewListview.backgroundColor=[UIColor whiteColor];
    viewListview.tag=232;
    
    if (tabvListHolidayOverAll) {
        [tabvListHolidayOverAll removeFromSuperview];
        tabvListHolidayOverAll=nil;
    }
    tabvListHolidayOverAll=[[UITableView alloc]initWithFrame:CGRectMake(0,0,viewListview.bounds.size.width,viewListview.bounds.size.height) style:UITableViewStylePlain];
    tabvListHolidayOverAll.delegate=self;
    tabvListHolidayOverAll.dataSource=self;
    tabvListHolidayOverAll.tag=232;
    tabvListHolidayOverAll.backgroundView=nil;
    tabvListHolidayOverAll.backgroundColor=[UIColor clearColor];
    tabvListHolidayOverAll.separatorColor=[UIColor clearColor];
    [viewListview addSubview:tabvListHolidayOverAll];
    
    [self.view addSubview: viewListview];
}

#pragma mark - UITableView Delegate & DataSource Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tabvListHolidayOverAll)
    {
        return [arrMHolidayListOverAll count];
    }
    else
    {
        return [arrMHolidayList count];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.00f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    [view setBackgroundColor:[UIColor colorWithRed:222/256.0 green:222/256.0 blue:222/256.0 alpha:1.0]];
    
    UILabel *lblMonthYr=[[UILabel alloc] initWithFrame:CGRectMake(0,0,tabvListHoliday.frame.size.width/2,30)];
    UILabel *lblPrint=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblMonthYr.frame)-10,0,tabvListHoliday.frame.size.width/2,30)];
    
    lblMonthYr.font=[UIFont fontWithName:@"GothamBook" size:14];
    lblPrint.font=[UIFont fontWithName:@"GothamBook" size:14];
    lblMonthYr.textColor=[UIColor darkGrayColor];
    lblPrint.textColor=[UIColor darkGrayColor];
    lblMonthYr.backgroundColor=[UIColor clearColor];
    lblPrint.backgroundColor=[UIColor clearColor];
    lblMonthYr.textAlignment=NSTextAlignmentLeft;
    lblPrint.textAlignment=NSTextAlignmentRight;
    lblMonthYr.text=@"  Date";
    lblPrint.text=@"Holiday";
    [view addSubview:lblMonthYr];
    [view addSubview:lblPrint];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    objHolidayList *obj;
    if (tableView==tabvListHolidayOverAll)
    {
        obj=[arrMHolidayListOverAll objectAtIndex:indexPath.row];
    }
    else{
        obj=[arrMHolidayList objectAtIndex:indexPath.row];
    }
    
    NSString *strDate=[NSString stringWithFormat:@"%@",obj.strHDate];
    //NSString *strLatestYear=[NSString stringWithFormat:@"%@",strGetLatestYear];

    UILabel *lblDate=[[UILabel alloc] initWithFrame:CGRectMake(0,0,tabvListHoliday.frame.size.width/2,44)];
    lblDate.numberOfLines=3;
    lblDate.font=[UIFont fontWithName:@"GothamBook" size:13];
    lblDate.backgroundColor=[UIColor clearColor];
    lblDate.text=[NSString stringWithFormat:@"  %@",strDate];
    lblDate.textAlignment=NSTextAlignmentLeft;
    lblDate.textColor=[UIColor darkGrayColor];
    
    UILabel *lblEvent=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblDate.frame)-10,0,tabvListHoliday.frame.size.width/2,44)];
    lblEvent.numberOfLines=3;
    if (tableView==tabvListHolidayOverAll)
    {
        lblEvent.font=[UIFont fontWithName:@"GothamBold" size:13];
    }
    else{
        lblEvent.font=[UIFont fontWithName:@"GothamBold" size:13];
    }
    lblEvent.backgroundColor=[UIColor clearColor];
    lblEvent.text=[NSString stringWithFormat:@"%@",obj.strHName];
    lblEvent.textAlignment=NSTextAlignmentRight;
    lblEvent.textColor=[UIColor colorWithRed:61/256.0 green:169/256.0 blue:225/256.0 alpha:1.0];
    
    [cell.contentView addSubview:lblDate];
    [cell.contentView addSubview:lblEvent];
    
    UILabel *lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(15,43.7,tabvListHoliday.frame.size.width,0.3)];
    lblSeparator.backgroundColor=[UIColor lightGrayColor];
    [cell.contentView addSubview:lblSeparator];
    
    if ([strCalenderSpecofic isEqualToString:@"1"])
    {
        if ([strDate isEqualToString:strSelectedDate]) {
            cell.backgroundColor=[UIColor colorWithRed:155/256.0 green:212/256.0 blue:245/256.0 alpha:0.5];
        }
        else{
            cell.backgroundColor = [UIColor whiteColor];
        }
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}




#pragma mark - Create Calander View Method
- (void)loadCalanderView
{
    strCalenderSpecofic=@"";
    
    arrMHolidayList=[[NSMutableArray alloc] init];
    arrMallDateListFilter=[[NSMutableArray alloc] init];
    
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            viewCalendarwithlist=[[UIView alloc] initWithFrame:CGRectMake(0, 64, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-64)];
        }
        else if(screenSize.height == 667.0f){
            //6
            viewCalendarwithlist=[[UIView alloc] initWithFrame:CGRectMake(0, 64, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-64)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            viewCalendarwithlist=[[UIView alloc] initWithFrame:CGRectMake(0, 64, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-64)];
        }
        else if(screenSize.height == 812.0f){
            //X
            viewCalendarwithlist=[[UIView alloc] initWithFrame:CGRectMake(0, 84, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-84)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            viewCalendarwithlist=[[UIView alloc] initWithFrame:CGRectMake(0, 84, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-84)];
        }
        else{
            viewCalendarwithlist=[[UIView alloc] initWithFrame:CGRectMake(0, 64, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height-64)];
        }
    }
    else
    {
    }
    
    viewCalendarwithlist.backgroundColor=[UIColor whiteColor];
    viewCalendarwithlist.tag=332;
    
    if (calendar) {
        [calendar removeFromSuperview];
        calendar=nil;
    }
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    
    calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0,0,viewCalendarwithlist.bounds.size.width,height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.allowsMultipleSelection = NO;
    calendar.swipeToChooseGesture.enabled = YES;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    [viewCalendarwithlist addSubview:calendar];
    [calendar setCurrentPage:currentDT animated:NO];
    
    
    if (tabvListHoliday) {
        [tabvListHoliday removeFromSuperview];
        tabvListHoliday=nil;
    }
    tabvListHoliday=[[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(calendar.frame),viewCalendarwithlist.bounds.size.width,viewCalendarwithlist.bounds.size.height-calendar.frame.size.height) style:UITableViewStylePlain];
    tabvListHoliday.delegate=self;
    tabvListHoliday.dataSource=self;
    tabvListHoliday.tag=332;
    tabvListHoliday.backgroundView=nil;
    tabvListHoliday.backgroundColor=[UIColor clearColor];
    tabvListHoliday.separatorColor=[UIColor clearColor];
    [viewCalendarwithlist addSubview:tabvListHoliday];
    [self.view addSubview: viewCalendarwithlist];
    
    //-------- Today have any Holiday ---------------
    strCAlEN = [self.dateFormatter1 stringFromDate:[NSDate date]];
    BOOL contains = [arrMallDateList containsObject:strCAlEN];
    if (contains==YES)
    {
        NSLog(@"strCAlEN :%@",strCAlEN);
    }
    else{
        NSLog(@"Current Today date out of array list");
    }
    //---------------------------------------------------------
}

#pragma mark - FSCalendar Delegate Mthods and datasoruce
- (void)todayItemClicked:(id)sender
{
    [calendar setCurrentPage:[NSDate date] animated:NO];
}
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter1 stringFromDate:date];
    if ([_datesWithEvent containsObject:dateString])
    {
        return 1;
    }
    if ([_datesWithMultipleEvents containsObject:dateString])
    {
        return 3;
    }
    return 0;
}
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventColorForDate:(NSDate *)date
{
    return [UIColor colorWithRed:61/255.0 green:169/255.0 blue:225/255.0 alpha:1.0];
}
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date
{
    return nil;
}
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter1 stringFromDate:date];
    if ([_datesWithEvent containsObject:dateString])
    {
        return [UIColor colorWithRed:61/255.0 green:169/255.0 blue:225/255.0 alpha:1.0];
    }
    return nil;
}
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date
{
     return nil;
}
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderSelectionColorForDate:(NSDate *)date
{
     return nil;
}
-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date
{
    return [UIColor blackColor];
}
-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date
{
    return [UIColor whiteColor];
}
/*- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    NSDateFormatter *dfDevice = [[NSDateFormatter alloc]init];
    [dfDevice setDateFormat:@"dd/MM/yyyy"];
    NSString *currentdevicedate = [dfDevice stringFromDate:[NSDate date]];
    NSArray *fooDevice = [currentdevicedate componentsSeparatedByString: @"/"];
    NSString *yearDevice = [fooDevice objectAtIndex: 2];
    NSString *strFirstDate =[NSString stringWithFormat:@"%@-01-01",yearDevice];
    NSLog(@"strFirstDate :%@",strFirstDate);
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *yourMinimumDate = [dateFormatter1 dateFromString:strFirstDate];
    
    return yourMinimumDate;
}
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    NSDateFormatter *dfDevice = [[NSDateFormatter alloc]init];
    [dfDevice setDateFormat:@"dd/MM/yyyy"];
    NSString *currentdevicedate = [dfDevice stringFromDate:[NSDate date]];
    NSArray *fooDevice = [currentdevicedate componentsSeparatedByString: @"/"];
    NSString *yearDevice = [fooDevice objectAtIndex: 2];
    NSString *strLastDate =[NSString stringWithFormat:@"%@-12-31",yearDevice];
    NSLog(@"strLastDate :%@",strLastDate);
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *yourMaximumDate = [dateFormatter1 dateFromString:strLastDate];
    
    return yourMaximumDate;
}*/
- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    strCalenderSpecofic=@"";
    strSelectedDate=@"";
    
    currentDT=calendar.currentPage;
    NSLog(@"currentDT :%@",currentDT);//Wed Aug  1 00:00:00 2018
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    NSDate *date = currentDT;
   
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSString *result = [df stringFromDate:date];
    NSArray *foo = [result componentsSeparatedByString: @"/"];
    NSString *monthvalue = [foo objectAtIndex: 1];
    NSString *yearvalue = [foo objectAtIndex: 2];
    NSLog(@"monthvalue :%@",monthvalue);
    NSLog(@"yearvalue :%@",yearvalue);
    
    
    NSString *strFilterVal=[NSString stringWithFormat:@"%@/%@",monthvalue,yearvalue];
    NSLog(@"strFilterVal :%@",strFilterVal);
    
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", strFilterVal];
    NSArray *filteredArray1 = [arrMallDateList filteredArrayUsingPredicate:predicate1];
    arrMallDateListFilter=[filteredArray1 mutableCopy];
    NSLog(@"Filter :%@",arrMallDateListFilter);
    
    if (self.datesWithEvent!=nil) {
        self.datesWithEvent=nil;
    }
    self.datesWithEvent=arrMallDateListFilter;
    
    for (NSDate *date in calendar.selectedDates) {
        [calendar deselectDate:date];
    }
    [calendar reloadData];
    
    
    //--------- Tableview Reload Data------------------------
    
    NSPredicate *p3 = [NSPredicate predicateWithFormat:@"(strHMonth = %@) AND (strHYear = %@)", monthvalue,yearvalue];
    NSLog(@"p3 :%@",p3);
    NSArray *filteredArray = [arrMHolidayListOverAll filteredArrayUsingPredicate:p3];
    arrMHolidayList=[filteredArray mutableCopy];
    
    NSLog(@"arrMHolidayList :%@",arrMHolidayList);
    
    if (lblMessage!=nil) {
        [lblMessage removeFromSuperview];
    }
    lblMessage=[[UILabel alloc] init];
    lblMessage.frame=CGRectMake(0,CGRectGetMaxY(calendar.frame)+30,UIScreen.mainScreen.bounds.size.width,200);
    lblMessage.textAlignment=NSTextAlignmentCenter;
    lblMessage.textColor=[UIColor darkGrayColor];
    lblMessage.text=@"There are no holidays in this month";
    lblMessage.font=[UIFont fontWithName:@"GothamBook" size:14.0];
    lblMessage.numberOfLines=10;
    lblMessage.backgroundColor=[UIColor clearColor];
    [self.view addSubview:lblMessage];
    
    if ([filteredArray count]>0) {
        tabvListHoliday.hidden=NO;
        lblMessage.hidden=YES;
    }
    else{
        lblMessage.hidden=NO;
        tabvListHoliday.hidden=YES;
    }
    [tabvListHoliday reloadData];
}
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    strCAlEN = [self.dateFormatter1 stringFromDate:date];
    strSelectedDate=strCAlEN;
    //NSLog(@"strSelectedDate:%@",strSelectedDate);
    
    BOOL contains = [arrMallDateList containsObject:strSelectedDate];
    if (contains==YES)
    {
        tabvListHoliday.hidden=NO;
    
        strCalenderSpecofic=@"1";
        [tabvListHoliday reloadData];
    }
    else
    {
        tabvListHoliday.hidden=YES;
    }
}
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSString *dateString = [self.dateFormatter1 stringFromDate:date];
    if ([_datesWithEvent containsObject:dateString]){
        return YES; //stop selection animation by Force
    }
    else{
        return NO;
    }
}
- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return NO;
}
- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
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
