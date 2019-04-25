//
//  ExpiringDocuments.m
//  Paylite HR
//
//  Created by Sabnam Nasrin on 06/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "ExpiringDocuments.h"

@interface ExpiringDocuments ()

@end

@implementation ExpiringDocuments

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
    
    _tableDocument.backgroundView=nil;
    _tableDocument.backgroundColor=[UIColor clearColor];
    _tableDocument.separatorColor=[UIColor clearColor];
    _tableDocument.showsVerticalScrollIndicator=NO;
   
    [self downloadExpDoc];
    
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

#pragma mark - UITableView Delegate & DataSource Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrMDocList count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 64.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.00f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    [view setBackgroundColor:[UIColor colorWithRed:222/256.0 green:222/256.0 blue:222/256.0 alpha:1.0]];
    
    UILabel *cellDocument=[[UILabel alloc] initWithFrame:CGRectMake(8,12,tableView.frame.size.width/2.0f, 17)];
    UILabel *lblStatus=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cellDocument.frame)-10,12,tableView.frame.size.width/2.0f, 17)];
    
    cellDocument.font=[UIFont fontWithName:@"GothamBook" size:14];
    lblStatus.font=[UIFont fontWithName:@"GothamBook" size:14];
    cellDocument.textColor=[UIColor darkGrayColor];
    lblStatus.textColor=[UIColor darkGrayColor];
    cellDocument.textAlignment=NSTextAlignmentLeft;
    lblStatus.textAlignment=NSTextAlignmentCenter;
    cellDocument.text=@"Your Documents";
    lblStatus.text=@"Status";
    [view addSubview:cellDocument];
    [view addSubview:lblStatus];
    
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSMutableDictionary *dictemp=[arrMDocList objectAtIndex:indexPath.row];
    
    //Document label
    UILabel *cellHeading1=[[UILabel alloc] initWithFrame:CGRectMake(8,7,200, 17)];
    UILabel *cellHeading2=[[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(cellHeading1.frame)+5, 110, 17)];
    
    //status image
     UIImageView *imgVstatus=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.frame)-70,18,20,20)];
    imgVstatus.backgroundColor=[UIColor clearColor];
    [cell.contentView addSubview:imgVstatus];
    
    //status label
    UILabel *lblStatus=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgVstatus.frame)+2,15,80, 35)];
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
            
            lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
          
        }
        else if(screenSize.height == 667.0f){
            //6
            cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
            
            lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
           
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
            lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
                   }
        else if(screenSize.height == 812.0f){
            //X
            cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
            
            lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
            
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
            
            lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
        }
        else
        {
            cellHeading1.font=[UIFont fontWithName:@"GothamBook" size:13];
            cellHeading2.font=[UIFont fontWithName:@"GothamBook" size:13];
            
            lblStatus.font=[UIFont fontWithName:@"GothamBook" size:11];
            
        }
    }
    
    cellHeading1.backgroundColor=[UIColor clearColor];
    cellHeading2.backgroundColor=[UIColor clearColor];
    lblStatus.numberOfLines=4;
    lblStatus.backgroundColor=[UIColor clearColor];
    
    [cell.contentView addSubview:lblStatus];
    [cell.contentView addSubview:cellHeading1];
    [cell.contentView addSubview:cellHeading2];
    
    
    cellHeading1.text=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"DocumentName"]];
    cellHeading2.text=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"DateOfExpiry"]];
    
    NSString *strStatus=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"Status"]];
    if ([strStatus isEqualToString:@"0"]) {
        //Already expired
        lblStatus.textColor=[UIColor redColor];
        lblStatus.text=[NSString stringWithFormat:@"%@",@"Expired"];
        [imgVstatus setImage:[UIImage imageNamed:@"warningRed"]];
    }
    else if ([strStatus isEqualToString:@"1"]) {
        //Expiring Today
        lblStatus.textColor=[UIColor darkGrayColor];
        lblStatus.text=[NSString stringWithFormat:@"%@",@"Expiring Today"];
        [imgVstatus setImage:[UIImage imageNamed:@"warningGray"]];
    }
    else{
        //Expiring withing -- days
        lblStatus.textColor=[UIColor darkGrayColor];
        //lblStatus.text=[NSString stringWithFormat:@"Expiring withing %@ days",strStatus];
        lblStatus.text=@"About to Expire";
        [imgVstatus setImage:[UIImage imageNamed:@"warningGray"]];
    }
    
    cellHeading1.textColor=[UIColor darkGrayColor];
    cellHeading2.textColor=[UIColor blackColor];
    
    
    UILabel *lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(0,63.7,tableView.frame.size.width,0.3)];
    lblSeparator.backgroundColor=[UIColor lightGrayColor];
    [cell.contentView addSubview:lblSeparator];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - Fetch Exiring Doc Method
-(void)downloadExpDoc
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
                             "<GetExpiringDocumentslist xmlns=\"http://tempuri.org/\"><sEmployeeId>%@</sEmployeeId>"
                             "</GetExpiringDocumentslist> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]]];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetExpiringDocumentslist" forHTTPHeaderField:@"SOAPAction"];
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
        if ([elementName isEqualToString:@"GetExpiringDocumentslistResult"])
        {
            arrMDocList=[[NSMutableArray alloc]init];
        }
        if ([elementName isEqualToString:@"Table1"])
        {
            dicMDoc=[[NSMutableDictionary alloc]init];
        }
        if ([elementName isEqualToString:@"EmployeeId"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"EmployeeName"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DocumentId"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DocumentName"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DateOfIssue"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DateOfExpiry"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Status"])
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
        if ([elementName isEqualToString:@"Table1"])
        {
            [arrMDocList addObject:dicMDoc];
        }
        if ([elementName isEqualToString:@"EmployeeId"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"EmployeeId"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"EmployeeName"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"EmployeeName"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DocumentId"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"DocumentId"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DocumentName"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"DocumentName"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DateOfIssue"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"DateOfIssue"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DateOfExpiry"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"DateOfExpiry"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Status"])
        {
            [dicMDoc setObject:currentElementValue forKey:@"Status"];
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
        if ([arrMDocList count]==0)
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"There are no expiring documents."
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
            NSLog(@"arrMDocList :%@",arrMDocList);
            [_tableDocument reloadData];
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
