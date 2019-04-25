//
//  MyDependents.m
//  Paylite HR
//
//  Created by Sabnam Nasrin on 10/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "MyDependents.h"

@interface MyDependents ()

@end

@implementation MyDependents


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
    
    [self downloadDependencyList];
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

#pragma mark - Fetch Dependency List Method
-(void)downloadDependencyList
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
                             "<GetDependentList xmlns=\"http://tempuri.org/\"><sEmployeeId>%@</sEmployeeId>"
                             "</GetDependentList> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]]];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetDependentList" forHTTPHeaderField:@"SOAPAction"];
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
        if ([elementName isEqualToString:@"GetDependentListResult"])
        {
            arrMAllList=[[NSMutableArray alloc]init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            objDL=[[objDependency alloc]init];
        }
        if ([elementName isEqualToString:@"ID"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"NAME"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Sex"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DateOfJoining"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Relation"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"IsEmployed"])
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
            [arrMAllList addObject:objDL];
        }
        if ([elementName isEqualToString:@"ID"])
        {
            objDL.ID=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"NAME"])
        {
            objDL.NAME=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Sex"])
        {
            objDL.Sex=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DateOfJoining"])
        {
            objDL.DateOfJoining=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Relation"])
        {
            objDL.Relation=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"IsEmployed"])
        {
            objDL.IsEmployed=currentElementValue;
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
        if ([arrMAllList count]==0){
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"There are no dependents."
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
        else{
            [self createCollectionView];
        }
    }
    else
    {
    }
}

#pragma mark - Collection view Creation Method
-(void)createCollectionView
{
    if (collectionDependent==nil) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f)
            {
                collectionDependent=[[UICollectionView alloc] initWithFrame:CGRectMake(0,70,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-70) collectionViewLayout:layout];
            }
            else if(screenSize.height == 667.0f)
            {
                collectionDependent=[[UICollectionView alloc] initWithFrame:CGRectMake(0,70,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-70) collectionViewLayout:layout];
            }
            else if(screenSize.height == 736.0f)
            {
                collectionDependent=[[UICollectionView alloc] initWithFrame:CGRectMake(0,70,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-70) collectionViewLayout:layout];
            }
            else if(screenSize.height == 812.0f)
            {
                collectionDependent=[[UICollectionView alloc] initWithFrame:CGRectMake(0,90,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-90) collectionViewLayout:layout];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                collectionDependent=[[UICollectionView alloc] initWithFrame:CGRectMake(0,90,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-90) collectionViewLayout:layout];
            }
            else
            {
                collectionDependent=[[UICollectionView alloc] initWithFrame:CGRectMake(0,70,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-70) collectionViewLayout:layout];
            }
        }
    }
    [collectionDependent registerClass:[DependentCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionDependent setBackgroundColor:[UIColor clearColor]];
    [collectionDependent setDataSource:self];
    [collectionDependent setDelegate:self];
    [self.view addSubview:collectionDependent];
}

#pragma mark - UICollectionView Delegate & DataSource Method
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrMAllList count];
}
- (DependentCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DependentCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    objDependency *obj=[arrMAllList objectAtIndex:indexPath.row];
    
    [cell.lblName setFrame:CGRectMake(0,CGRectGetMaxY(cell.imgvLogo.frame)+10,cell.lblName.frame.size.width,20)];
    [cell.lblTitle setFrame:CGRectMake(0,CGRectGetMaxY(cell.lblName.frame), cell.lblTitle.frame.size.width, 20)];
    [cell.lblDOJ setFrame:CGRectMake(0,CGRectGetMaxY(cell.lblTitle.frame), cell.lblDOJ.frame.size.width, 40)];
    
    cell.lblDOJ.numberOfLines=4;
    cell.lblDOJ.backgroundColor=[UIColor clearColor];
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",obj.Relation];
    cell.lblName.text=[NSString stringWithFormat:@"%@",obj.NAME];
    
    NSString *strDOJ=[NSString stringWithFormat:@"%@",obj.DateOfJoining];
    NSLog(@"strDOJ :%@",strDOJ);
    if ([strDOJ isEqualToString:@""]) {
        cell.lblDOJ.text=[NSString stringWithFormat:@"Dependent since: %@",@"NA"];
    }
    else{
        cell.lblDOJ.text=[NSString stringWithFormat:@"Dependent since: %@",strDOJ];
    }
    
    cell.lblTitle.textColor=[UIColor lightGrayColor];
    cell.lblDOJ.textColor=[UIColor lightGrayColor];
    cell.lblName.textColor=[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
    
    if ([[NSString stringWithFormat:@"%@",obj.Sex] isEqualToString:@"Male"]){
        [cell.imgvLogo setImage:[UIImage imageNamed:@"boy"]];
    }
    else  if ([[NSString stringWithFormat:@"%@",obj.Sex] isEqualToString:@"Female"]){
        [cell.imgvLogo setImage:[UIImage imageNamed:@"girl"]];
    }
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            cell.lblName.font=[UIFont fontWithName:@"GothamBook" size:13];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBook" size:13];
            cell.lblDOJ.font=[UIFont fontWithName:@"GothamBook" size:13];
            
        }
        else if(screenSize.height == 667.0f){
            //6
            cell.lblName.font=[UIFont fontWithName:@"GothamBook" size:14];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBook" size:14];
            cell.lblDOJ.font=[UIFont fontWithName:@"GothamBook" size:14];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            cell.lblName.font=[UIFont fontWithName:@"GothamBook" size:14];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBook" size:14];
            cell.lblDOJ.font=[UIFont fontWithName:@"GothamBook" size:14];
        }
        else if(screenSize.height == 812.0f){
            //X
            cell.lblName.font=[UIFont fontWithName:@"GothamBook" size:14];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBook" size:14];
            cell.lblDOJ.font=[UIFont fontWithName:@"GothamBook" size:14];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            cell.lblName.font=[UIFont fontWithName:@"GothamBook" size:14];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBook" size:14];
            cell.lblDOJ.font=[UIFont fontWithName:@"GothamBook" size:14];
        }
        else{
            cell.lblName.font=[UIFont fontWithName:@"GothamBook" size:13];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBook" size:13];
            cell.lblDOJ.font=[UIFont fontWithName:@"GothamBook" size:13];
        }
    }
    
    [cell.layer setMasksToBounds:YES];
    [cell.layer setCornerRadius: 4.0];
    [cell.layer setBorderWidth:0.2];
    [cell.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];

    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f)
        {
            return CGSizeMake(120,120);
        }
        else if(screenSize.height == 667.0f)
        {
            return CGSizeMake(180, 180);
        }
        else if(screenSize.height == 736.0f)
        {
            return CGSizeMake(180, 180);
        }
        else if(screenSize.height == 812.0f)
        {
            return CGSizeMake(160, 180);
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            return CGSizeMake(160, 180);
        }
        else
        {
            return CGSizeMake(120,120);
        }
    }
    return CGSizeMake(180, 180);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            return 2.5;
        }
        else if(screenSize.height == 667.0f){
            //6
            return 2.5;
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            return 2.5;
        }
        else if(screenSize.height == 812.0f){
            //X
            return 10;
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            return 10;
        }
        else
        {
            return 2.5;
        }
    }
    return 2.5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            return 2.5;
        }
        else if(screenSize.height == 667.0f){
            //6
            return 2.5;
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            return 2.5;
        }
        else if(screenSize.height == 812.0f){
            //X
            return 20;
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            return 20;
        }
        else
        {
            return 2.5;
        }
    }
    return 2.5;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            return UIEdgeInsetsMake(0,2.5,0,2.5);
        }
        else if(screenSize.height == 667.0f){
            //6
            return UIEdgeInsetsMake(0,2.5,0,2.5);
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            return UIEdgeInsetsMake(0,2.5,0,2.5);
        }
        else if(screenSize.height == 812.0f){
            //X
            return UIEdgeInsetsMake(0,10,0,20);
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            return UIEdgeInsetsMake(0,10,0,20);
        }
        else
        {
            return UIEdgeInsetsMake(0,2.5,0,2.5);
        }
    }
    return UIEdgeInsetsMake(0,2.5,0,2.5);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
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
