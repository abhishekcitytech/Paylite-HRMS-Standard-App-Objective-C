//
//  LeaveCalanderController.m
//  Paylite HR
//
//  Created by Macmini2 on 4/12/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "LeaveCalanderController.h"

@interface LeaveCalanderController ()

@end

@implementation LeaveCalanderController

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
    
    arrMallDateList = [[NSMutableArray alloc] init];
    arrTable=[[NSMutableArray alloc]init];
    strSelectedDate=@"";
    
    _vwH.layer.shadowRadius = 3.0f;
    _vwH.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _vwH.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _vwH.layer.shadowOpacity = 0.5f;
    _vwH.layer.masksToBounds = NO;
    
    currentDT=[NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    _tableCalendar.hidden=YES;
    _tableCalendar.backgroundView=nil;
    _tableCalendar.backgroundColor=[UIColor clearColor];
    _tableCalendar.separatorColor=[UIColor clearColor];
    _tableCalendar.showsVerticalScrollIndicator=NO;
   
    
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    [self GetLeaveCalanderList:[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]] month:[NSString stringWithFormat:@"%ld",(long)month] year:[NSString stringWithFormat:@"%ld",(long)year]];
    
    self.title = @"FSCalendar";
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter1 = [[NSDateFormatter alloc] init];
    self.dateFormatter1.dateFormat = @"dd/MM/yyyy";
    self.dateFormatter2 = [[NSDateFormatter alloc] init];
    self.dateFormatter2.dateFormat = @"dd-MM-yyyy";
    self.calendar.accessibilityIdentifier = @"calendar";
    [self loadCalanderView];
}

#pragma mark - Back Press Method
- (IBAction)BackPress:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Fetch Leave Calendar Details Method
-(void)GetLeaveCalanderDetails :(NSString *)strDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:strDate];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy/MM/dd"];
    NSString *strrr = [dateFormatter1 stringFromDate:dateFromString];
    strDate=strrr;
    NSLog(@"strDate:::%@",strDate);
    
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
                             "<GetLeaveListOnParticularDate xmlns=\"http://tempuri.org/\"><sEmployeeId>%@</sEmployeeId>,<sDate>%@</sDate>"
                             "</GetLeaveListOnParticularDate> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],strDate];
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetLeaveListOnParticularDate" forHTTPHeaderField:@"SOAPAction"];
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


#pragma mark - Fetch Leave Calendar List Method
-(void)GetLeaveCalanderList :(NSString *)empID  month:(NSString *)sMonth year:(NSString *)syear
{
    strIdentifier=@"1";

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
                             "<GetLeaveDateListOnly xmlns=\"http://tempuri.org/\"><sEmployeeId>%@</sEmployeeId>,<sMonth>%@</sMonth>,<sYear>%@</sYear>"
                             "</GetLeaveDateListOnly> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",empID,sMonth,syear];
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetLeaveDateListOnly" forHTTPHeaderField:@"SOAPAction"];
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
        if ([elementName isEqualToString:@"GetLeaveDateListOnlyResult"])
        {
            arrMLeaveList=[[NSMutableArray alloc]init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            dicMLeave=[[NSMutableDictionary alloc]init];
        }
        if ([elementName isEqualToString:@"LeaveDate"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if ([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"GetLeaveListOnParticularDateResult"])
        {
            arrMLDT=[[NSMutableArray alloc]init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            dicMLDT=[[NSMutableDictionary alloc]init];
        }
        if ([elementName isEqualToString:@"Employee"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"EmployeeName"])
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
        if ([elementName isEqualToString:@"LeaveType"])
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
            [arrMLeaveList addObject:dicMLeave];
        }
        if ([elementName isEqualToString:@"LeaveDate"])
        {
            [dicMLeave setObject:currentElementValue forKey:@"LeaveDate"];
            currentElementValue=nil;
        }
    }
    else if ([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
            [arrMLDT addObject:dicMLDT];
        }
        if ([elementName isEqualToString:@"Employee"])
        {
            [dicMLDT setObject:currentElementValue forKey:@"Employee"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"EmployeeName"])
        {
            [dicMLDT setObject:currentElementValue forKey:@"EmployeeName"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"FromDate"])
        {
            [dicMLDT setObject:currentElementValue forKey:@"FromDate"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"ToDate"])
        {
            [dicMLDT setObject:currentElementValue forKey:@"ToDate"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"LeaveType"])
        {
            [dicMLDT setObject:currentElementValue forKey:@"LeaveType"];
            currentElementValue=nil;
        }
        
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        if ([arrMLeaveList count]==0)
        {
            if (lblMessage!=nil) {
                [lblMessage removeFromSuperview];
            }
            lblMessage=[[UILabel alloc] init];
            lblMessage.frame=CGRectMake(0,CGRectGetMaxY(self.calendar.frame)+30,UIScreen.mainScreen.bounds.size.width,150);
            lblMessage.textAlignment=NSTextAlignmentCenter;
            lblMessage.textColor=[UIColor darkGrayColor];
            lblMessage.text=@"No one on leave in this month";
            lblMessage.font=[UIFont fontWithName:@"GothamBook" size:14.0];
            lblMessage.numberOfLines=10;
            lblMessage.backgroundColor=[UIColor clearColor];
            [self.view addSubview:lblMessage];
        }
        else
        {
            if (lblMessage!=nil) {
                [lblMessage removeFromSuperview];
            }
            
            arrMallDateList = [[NSMutableArray alloc] init];
            NSMutableArray   *allDates = [[NSMutableArray alloc] init];
            
            for (int hg=0; hg<[arrMLeaveList count]; hg++)
            {
                NSMutableDictionary *dictemp=[arrMLeaveList objectAtIndex:hg];
                NSString *strDates=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"LeaveDate"]];
                [allDates addObject:strDates];
            }
            
            
            NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:allDates];
            NSArray *arrayWithoutDuplicates = [orderedSet array];
            [arrMallDateList addObjectsFromArray:arrayWithoutDuplicates];
            NSLog(@"arrMallDateList >>>>> %@",arrMallDateList);
            
            self.datesWithEvent = arrMallDateList;
            [self loadCalanderView];
            
           //-------- Today have any Leave Application ---------------
            strCAlEN = [self.dateFormatter1 stringFromDate:[NSDate date]];
            BOOL contains = [arrMallDateList containsObject:strCAlEN];
            if (contains==YES)
            {
                NSLog(@"strCAlEN :%@",strCAlEN);
                [self GetLeaveCalanderDetails:strCAlEN];
            }
            else{
                NSLog(@"Current Today date out of array list");
            }
            //---------------------------------------------------------
            
        }
    }
    else if ([strIdentifier isEqualToString:@"2"])
    {
        if ([arrMLDT count]>0)
        {
            _tableCalendar.hidden=NO;
            [_tableCalendar reloadData];
        }
    }
}

#pragma mark - Replace Null from String Method
-(NSString*)ReplaceStringNull:(id)str
{
    NSString *st=[NSString stringWithFormat:@"%@",str];
    st = [st stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    st = [st stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    st = [st stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return st;
}

#pragma mark - load Calander View Method
- (void)loadCalanderView
{
    if (self.calendar) {
        [self.calendar removeFromSuperview];
        self.calendar=nil;
    }
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_vwH.frame),self.view.bounds.size.width,height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.allowsMultipleSelection = NO;
    calendar.swipeToChooseGesture.enabled = YES;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    [calendar setCurrentPage:currentDT animated:NO];
}

#pragma mark - FSCalendar Delegate & DataSource Method
- (void)todayItemClicked:(id)sender
{
    [_calendar setCurrentPage:[NSDate date] animated:NO];
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
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date
{
    return [UIColor colorWithRed:61/255.0 green:169/255.0 blue:225/255.0 alpha:1.0];
}
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventColorForDate:(NSDate *)date
{
    return [UIColor colorWithRed:61/255.0 green:169/255.0 blue:225/255.0 alpha:1.0];
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
- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"arrMLDT count %ld",[arrMLDT count]);
    
    if ([arrMLDT count]>0)
    {
        arrMLDT=nil;
        _tableCalendar.hidden=NO;
        [_tableCalendar reloadData];
    }
    
    strSelectedDate=@"";
    currentDT=calendar.currentPage;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:calendar.currentPage];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    [self GetLeaveCalanderList:[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]] month:[NSString stringWithFormat:@"%ld",(long)month] year:[NSString stringWithFormat:@"%ld",(long)year]];
}
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    strCAlEN = [self.dateFormatter1 stringFromDate:date];
    strSelectedDate=strCAlEN;
    
    BOOL contains = [arrMallDateList containsObject:strSelectedDate];
    if (contains==YES)
    {
        [self GetLeaveCalanderDetails:strSelectedDate];
    }
    else
    {
        arrMLDT=nil;
        [_tableCalendar reloadData];
        NSLog(@"date out of array list");
    }
}
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    strSelectedDate=[NSString stringWithFormat:@"%@",[self.dateFormatter1 stringFromDate:date]];
    return YES;
}



#pragma mark - UITableView Delegate & DataSource Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrMLDT count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.backgroundColor=[UIColor whiteColor];
    
    NSMutableDictionary *dic=  [arrMLDT objectAtIndex:indexPath.row];
    NSLog(@"dic :%@",dic);
  
    UILabel *cellLable1,*cellLable2,*cellLable3;
    
    cellLable1=[[UILabel alloc] initWithFrame:CGRectMake(14,10, _tableCalendar.frame.size.width-10, 17)];
    cellLable2=[[UILabel alloc] initWithFrame:CGRectMake(14,CGRectGetMaxY(cellLable1.frame)+5,_tableCalendar.frame.size.width-10, 17)];
    cellLable3=[[UILabel alloc] initWithFrame:CGRectMake(14,CGRectGetMaxY(cellLable2.frame)+5, _tableCalendar.frame.size.width-10, 17)];
    
    cellLable1.textColor=[UIColor blackColor];
    cellLable2.textColor=[UIColor darkGrayColor];
    cellLable3.textColor=[UIColor darkGrayColor];
    
    cellLable1.backgroundColor=[UIColor clearColor];
    cellLable2.backgroundColor=[UIColor clearColor];
    cellLable3.backgroundColor=[UIColor clearColor];
    
    cellLable1.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"EmployeeName"]];
    cellLable2.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"LeaveType"]];
    cellLable3.text=[NSString stringWithFormat:@"From %@ To %@",[dic objectForKey:@"FromDate"],[dic objectForKey:@"ToDate"]];
    
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
    [cell.contentView addSubview:cellLable2];
    [cell.contentView addSubview:cellLable3];
    
    UILabel *lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(0,79.7,_tableCalendar.frame.size.width,0.3)];
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
