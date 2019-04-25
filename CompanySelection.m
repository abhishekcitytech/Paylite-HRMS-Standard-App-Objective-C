//
//  CompanySelection.m
//  Paylite HRMS
//
//  Created by Sandipan on 06/07/17.
//  Copyright © 2017 SANDIPAN. All rights reserved.
//

#import "CompanySelection.h"

@interface CompanySelection ()

@end

@implementation CompanySelection
@synthesize arrMCompanylist;


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
    appSelectCompany=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _txtselectCompany.frame.size.height - borderWidth, _txtselectCompany.frame.size.width, _txtselectCompany.frame.size.height);
    border.borderWidth = borderWidth;
    [_txtselectCompany.layer addSublayer:border];
    _txtselectCompany.layer.masksToBounds = YES;
    
    
    [_btnContinue.layer setMasksToBounds:YES];
    [_btnContinue.layer setCornerRadius: 4.0];
    [_btnContinue.layer setBorderWidth:0.0];
    [_btnContinue.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    
    [self setUpBorder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set Border Method
-(void)setUpBorder
{
    CALayer *border2 = [CALayer layer];
    CGFloat borderWidth2 = 0.5;
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.frame = CGRectMake(0, _txtselectCompany.frame.size.height - borderWidth2, _txtselectCompany.frame.size.width, _txtselectCompany.frame.size.height);
    border2.borderWidth = borderWidth2;
    [_txtselectCompany.layer addSublayer:border2];
    _txtselectCompany.layer.masksToBounds = YES;
}

#pragma mark - Press Continue Method
- (IBAction)pressContinue:(id)sender
{
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    [self fetchuserinfo:strIDDD empid:[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]]];
}

#pragma mark - UITextField Delegate Method
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_txtselectCompany){
        Activetxtfld=textField;
        [self popupList];
    }
    else{
    }
    
    actvtextbox=textField;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==_txtselectCompany){
        Activetxtfld=textField;
        [self popupList];
        return NO;
    }
    else{
    }
    actvtextbox=textField;
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


#pragma mark - Create LeaveType PopUP List Method
-(void)popupList
{
    if (tblView!=nil){
        [tblView removeFromSuperview];
        tblView=nil;
    }
    else{
        
        arrFeedTblPopup= [self GetDataForPoppup:Activetxtfld];
        tblView=[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(Activetxtfld.frame),CGRectGetMaxY(Activetxtfld.frame)+2, CGRectGetWidth(Activetxtfld.frame), 0) style:UITableViewStylePlain];
        tblView.delegate=self;
        tblView.dataSource=self;
        [self.view addSubview:tblView];
        
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
                             frame.size.height = 170;
                             tblView.frame = frame;
                         }
                         completion:^(BOOL finished){
                         }];
    }
}
-(NSArray *)GetDataForPoppup:(UITextField *)fld
{
    arrFeedTblPopup=nil;
    if(fld==_txtselectCompany)
    {
        arrFeedTblPopup=arrMCompanylist;
    }
    else{
        
    }
    return arrFeedTblPopup;
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
    return [arrFeedTblPopup count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    cell.accessoryType=UITableViewCellAccessoryNone;
    
    cell.backgroundColor=[UIColor whiteColor];
    
    objCompanydetails *obj=[arrFeedTblPopup objectAtIndex:indexPath.row];
    
    UILabel *title1;
    title1=[[UILabel alloc] initWithFrame:CGRectMake(15,0,280,44)];
    title1.textAlignment=NSTextAlignmentLeft;
    title1.textColor=[UIColor darkGrayColor];
    title1.font=[UIFont fontWithName:@"GothamBook" size:13.0];
    title1.backgroundColor=[UIColor clearColor];
    title1.text=[NSString stringWithFormat:@"%@",obj.strCompanyName];
    [cell.contentView addSubview:title1];
    
    UILabel *lblSeparator;
    lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(15,42.5,tableView.frame.size.width-30,0.5)];
    lblSeparator.backgroundColor=[UIColor lightGrayColor];
    [cell.contentView addSubview:lblSeparator];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    objCompanydetails *obj=[arrFeedTblPopup objectAtIndex:indexPath.row];
    _txtselectCompany.text=[NSString stringWithFormat:@"%@",obj.strCompanyName];
    strIDDD=[NSString stringWithFormat:@"%@",obj.strCompanyID];
    strIDDD1=[NSString stringWithFormat:@"%@",obj.strCurrencySymbol];
    
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



#pragma mark - Fetch User Type Method
-(void)fetchuserinfo:(NSString *)strCompanyID empid:(NSString *)strEmployeeID
{
    NSString *strDeviceID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]];
    NSLog(@"Device Token %@",strDeviceID);
    
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
                             "<GetUserInfo xmlns=\"http://tempuri.org/\"><CompanyID>%@</CompanyID>,<EmployeeID>%@</EmployeeID>,<DeviceId>%@</DeviceId>,<DeviceType>%@</DeviceType>"
                             "</GetUserInfo> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",strCompanyID,strEmployeeID,strDeviceID,@"I"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSLog(@"soapMessage %@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d",(int)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetUserInfo" forHTTPHeaderField:@"SOAPAction"];
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
        if ([elementName isEqualToString:@"mytable"])
        {
            NSLog(@"root is called..");
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"IsManager"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"IsHr"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"GeoLocation"])
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
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strMessageCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strMessageText=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"IsManager"])
        {
            strisManager=currentElementValue ;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"IsHr"])
        {
            strisHR=currentElementValue ;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"GeoLocation"])
        {
            strisGeoLocation=currentElementValue ;
            currentElementValue=nil;
        }
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        NSLog(@"MessageCode:%@",strMessageCode);
        int code=[strMessageCode intValue];
        if (code==0)
        {
            NSLog(@"strisManager :%@",strisManager);
            NSLog(@"strisHR :%@",strisHR);

            [appSelectCompany.dicCompanyDetails setObject:strIDDD forKey:@"CompanyID"];
            [appSelectCompany.dicCompanyDetails setObject:_txtselectCompany.text forKey:@"CompanyName"];
            [appSelectCompany.dicCompanyDetails setObject:strIDDD1 forKey:@"CurrencySymbol"];
            
            [[NSUserDefaults standardUserDefaults] setObject:appSelectCompany.dicCompanyDetails forKey:@"dicCompanyDetails"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [appSelectCompany.dicUserDetails setObject:strisManager forKey:@"isManager"];
            [appSelectCompany.dicUserDetails setObject:strisHR forKey:@"isHR"];
            [appSelectCompany.dicUserDetails setObject:strisGeoLocation forKey:@"isGeoLocation"];
            
            if ([strisGeoLocation isEqualToString:@""]) {
                
            }
            else{
                NSArray *items = [strisGeoLocation componentsSeparatedByString:@","];
                NSString *str1=[items objectAtIndex:0];
                NSString *str2=[items objectAtIndex:1];
                [appSelectCompany.dicUserDetails setObject:str1 forKey:@"CompanyLatitude"];
                [appSelectCompany.dicUserDetails setObject:str2 forKey:@"CompanyLongitude"];
            }
            
            
            
            //Dafarpur 22.646599 ,88.246674
            //Jumeriah Lake Tower 25.0693,55.1417
            //pasrkstreet 22.552172,88.349734
            
            [appSelectCompany.dicUserDetails setObject:strIDDD forKey:@"CompanyID"];
            [appSelectCompany.dicUserDetails setObject:_txtselectCompany.text forKey:@"CompanyName"];
            [appSelectCompany.dicUserDetails setObject:strIDDD1 forKey:@"CurrencySymbol"];
            
            [[NSUserDefaults standardUserDefaults] setObject:appSelectCompany.dicUserDetails forKey:@"dicUserDetails"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self gotoDashboardPage];
            
        }
        else
        {
           
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Please enter valid username/password."
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
    
    NSLog(@"dicCompanyDetails :%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"dicCompanyDetails"]);
    //NSLog(@"dicUserDetails :%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"dicUserDetails"]);
}

#pragma mark - Redirect To Dashboard Method
-(void)gotoDashboardPage
{
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    if ([[dicTemp valueForKey:@"isManager"] isEqualToString:@"0"]&&[[dicTemp valueForKey:@"isHR"] isEqualToString:@"0"])
    {
        DashboardE *objDemo;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                objDemo = [[DashboardE alloc] initWithNibName:@"DashboardE5S" bundle:nil];
            }
            else if(screenSize.height == 667.0f){
                //6
                objDemo = [[DashboardE alloc] initWithNibName:@"DashboardE6" bundle:nil];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                objDemo = [[DashboardE alloc] initWithNibName:@"DashboardE6Plus" bundle:nil];
            }
            else if(screenSize.height == 812.0f){
                //X
                objDemo = [[DashboardE alloc] initWithNibName:@"DashboardEX" bundle:nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                objDemo = [[DashboardE alloc] initWithNibName:@"DashboardEXSMAX" bundle:nil];
            }
            else{
                objDemo = [[DashboardE alloc] initWithNibName:@"DashboardE" bundle:nil];
            }
        }
        else
        {
        }
        [self.navigationController pushViewController:objDemo animated:YES];
        
    }
    else
    {
        DashboardMH *objDemo;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                objDemo = [[DashboardMH alloc] initWithNibName:@"DashboardMH5S" bundle:nil];
            }
            else if(screenSize.height == 667.0f){
                //6
                objDemo = [[DashboardMH alloc] initWithNibName:@"DashboardMH6" bundle:nil];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                objDemo = [[DashboardMH alloc] initWithNibName:@"DashboardMH6Plus" bundle:nil];
            }
            else if(screenSize.height == 812.0f){
                //X
                objDemo = [[DashboardMH alloc] initWithNibName:@"DashboardMHX" bundle:nil];
            }
            else if(screenSize.height == 812.0f){
                //XSMAX XR
                
            }
            else{
                objDemo = [[DashboardMH alloc] initWithNibName:@"DashboardMH" bundle:nil];
            }
        }
        else
        {
        }
        [self.navigationController pushViewController:objDemo animated:YES];
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
