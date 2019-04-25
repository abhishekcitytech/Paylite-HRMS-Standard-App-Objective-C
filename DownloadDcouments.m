//
//  DownloadDcouments.m
//  Paylite HR
//
//  Created by Sandipan on 30/01/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "DownloadDcouments.h"

@interface DownloadDcouments ()

@end

@implementation DownloadDcouments

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
    
    [self fetchdownloadDocuments];
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


#pragma mark - Fetch Download Documents Method
-(void)fetchdownloadDocuments
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
                             "<GetEmployeeDocument xmlns=\"http://tempuri.org/\"><sEmployeeID>%@</sEmployeeID>"
                             "</GetEmployeeDocument> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]]];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetEmployeeDocument" forHTTPHeaderField:@"SOAPAction"];
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
            arrMData=[[NSMutableArray alloc] init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            dicData=[[NSMutableDictionary alloc] init];
        }
        if ([elementName isEqualToString:@"DocumentName"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DocumentURL"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"SRLNO"])
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
            [arrMData addObject:dicData];
        }
        if ([elementName isEqualToString:@"DocumentName"])
        {
            [dicData setObject:currentElementValue forKey:@"DocumentName"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DocumentURL"])
        {
            [dicData setObject:currentElementValue forKey:@"DocumentURL"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"SRLNO"])
        {
            [dicData setObject:currentElementValue forKey:@"SRLNO"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DateOfIssue"])
        {
            [dicData setObject:currentElementValue forKey:@"DateOfIssue"];
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DateOfExpiry"])
        {
            [dicData setObject:currentElementValue forKey:@"DateOfExpiry"];
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
            [self createCollectionView];
        }
        else{
            //Failure
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"There are no documents uploaded."
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
    else{
    }
}

#pragma mark - Collection view Creation Method
-(void)createCollectionView
{
    if (col==nil)
    {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f)
            {
                col=[[UICollectionView alloc] initWithFrame:CGRectMake(0,70,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-70) collectionViewLayout:layout];
            }
            else if(screenSize.height == 667.0f)
            {
                col=[[UICollectionView alloc] initWithFrame:CGRectMake(0,70,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-70) collectionViewLayout:layout];
            }
            else if(screenSize.height == 736.0f)
            {
                col=[[UICollectionView alloc] initWithFrame:CGRectMake(0,70,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-70) collectionViewLayout:layout];
            }
            else if(screenSize.height == 812.0f)
            {
                col=[[UICollectionView alloc] initWithFrame:CGRectMake(0,90,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-90) collectionViewLayout:layout];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                col=[[UICollectionView alloc] initWithFrame:CGRectMake(0,90,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-90) collectionViewLayout:layout];
            }
            else
            {
                col=[[UICollectionView alloc] initWithFrame:CGRectMake(0,70,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height-70) collectionViewLayout:layout];
            }
        }
    }
    [col registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [col setBackgroundColor:[UIColor clearColor]];
    [col setDataSource:self];
    [col setDelegate:self];
    [self.view addSubview:col];
}

#pragma mark - UICollectionView Delegate & DataSource Method
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrMData count];
}
- (CustomCollectionCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    NSMutableDictionary *dictemp=[arrMData objectAtIndex:indexPath.row];
  
    NSString *strName=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"DocumentName"]];
    NSString *strSRLNO=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"SRLNO"]];
    //NSString *strDateOfIssue=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"DateOfIssue"]];
    NSString *strDateOfExpiry=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"DateOfExpiry"]];
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //140
            [cell.imgvLogo setFrame:CGRectMake(40,30, 40, 40)];
        }
        else if(screenSize.height == 667.0f){
            //160
            [cell.imgvLogo setFrame:CGRectMake(60,30, 40, 40)];
        }
        else if(screenSize.height == 736.0f){
            //180
            [cell.imgvLogo setFrame:CGRectMake(70,30, 40, 40)];
        }
        else if(screenSize.height == 812.0f){
            //160
            [cell.imgvLogo setFrame:CGRectMake(60,30, 40, 40)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            [cell.imgvLogo setFrame:CGRectMake(60,30, 40, 40)];
        }
        else{
            //140
            [cell.imgvLogo setFrame:CGRectMake(40,30, 40, 40)];
        }
    }
    [cell.imgvLogo setImage:[UIImage imageNamed:@"folderdoc"]];
    
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        [cell.lblDocno setFrame:CGRectMake(0, CGRectGetHeight(cell.frame)-20, cell.frame.size.width,20)];
        cell.lblDocno.textAlignment=NSTextAlignmentCenter;
        cell.lblDocno.textColor=[UIColor lightGrayColor];
        cell.lblDocno.backgroundColor=[UIColor whiteColor];
        if ([strDateOfExpiry isEqualToString:@""]) {
            strDateOfExpiry=@"NA";
            cell.lblDocno.text=[NSString stringWithFormat:@"Expiry:%@",strDateOfExpiry];
        }
        else
        {
            cell.lblDocno.text=[NSString stringWithFormat:@"Expiry:%@",strDateOfExpiry];
        }
        
        
        [cell.lblTitle setFrame:CGRectMake(0, CGRectGetMinY(cell.lblDocno.frame)-20, cell.frame.size.width,20)];
        cell.lblTitle.textAlignment=NSTextAlignmentCenter;
        cell.lblTitle.textColor=[UIColor lightGrayColor];
        cell.lblTitle.backgroundColor=[UIColor whiteColor];
        cell.lblTitle.text=[NSString stringWithFormat:@"#%@",strSRLNO];
        
        [cell.lblDateofExpiry setFrame:CGRectMake(0, CGRectGetMinY(cell.lblTitle.frame)-20, cell.frame.size.width,20)];
        cell.lblDateofExpiry.textAlignment=NSTextAlignmentCenter;
        cell.lblDateofExpiry.textColor=[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
        cell.lblDateofExpiry.backgroundColor=[UIColor clearColor];
        cell.lblDateofExpiry.text=[NSString stringWithFormat:@"%@",strName];
        
        if (screenSize.height==568.0f){
            //5S
            cell.lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:11];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBold" size:13];
            cell.lblDocno.font=[UIFont fontWithName:@"GothamBook" size:11];
        }
        else if(screenSize.height == 667.0f){
            //6
            cell.lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:12];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBold" size:13];
            cell.lblDocno.font=[UIFont fontWithName:@"GothamBook" size:12];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            
            cell.lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:12];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBold" size:13];
            cell.lblDocno.font=[UIFont fontWithName:@"GothamBook" size:12];
        }
        else if(screenSize.height == 812.0f){
            //X
            
            cell.lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:11];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBold" size:13];
            cell.lblDocno.font=[UIFont fontWithName:@"GothamBook" size:11];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            
            cell.lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:11];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBold" size:13];
            cell.lblDocno.font=[UIFont fontWithName:@"GothamBook" size:11];
        }
        else{
            
            cell.lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:11];
            cell.lblTitle.font=[UIFont fontWithName:@"GothamBold" size:13];
            cell.lblDocno.font=[UIFont fontWithName:@"GothamBook" size:11];
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
            return CGSizeMake(140, 120);
        }
        else if(screenSize.height == 667.0f)
        {
            return CGSizeMake(160, 140);
        }
        else if(screenSize.height == 736.0f)
        {
            return CGSizeMake(180, 160);
        }
        else if(screenSize.height == 812.0f)
        {
            return CGSizeMake(160, 140);
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            return CGSizeMake(160, 140);
        }
        else{
            return CGSizeMake(140, 120);
        }
    }
    return CGSizeMake(180, 120);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f)
        {
            return 10;
        }
        else if(screenSize.height == 667.0f)
        {
            return 10;
        }
        else if(screenSize.height == 736.0f)
        {
            return 10;
        }
        else if(screenSize.height == 812.0f)
        {
            return 10;
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            return 30;
        }
        else{
            return 10;
        }
    }
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f)
        {
            return 10;
        }
        else if(screenSize.height == 667.0f)
        {
            return 10;
        }
        else if(screenSize.height == 736.0f)
        {
            return 10;
        }
        else if(screenSize.height == 812.0f)
        {
            return 10;
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            return 30;
        }
        else{
            return 10;
        }
    }
    return 10;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f)
        {
            return UIEdgeInsetsMake(0,10,0,10);
        }
        else if(screenSize.height == 667.0f)
        {
            return UIEdgeInsetsMake(0,10,0,10);
        }
        else if(screenSize.height == 736.0f)
        {
            return UIEdgeInsetsMake(0,10,0,10);
        }
        else if(screenSize.height == 812.0f)
        {
            return UIEdgeInsetsMake(0,10,0,10);
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            return UIEdgeInsetsMake(0,30,0,30);
        }
        else{
            return UIEdgeInsetsMake(0,10,0,10);
        }
    }
    return UIEdgeInsetsMake(0,10,0,10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dictemp=[arrMData objectAtIndex:indexPath.row];
    
    NSString *strNullStringCheck=[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"DocumentURL"]];
    if ([strNullStringCheck isEqualToString:@""])
    {
        arrUrlList=nil;
        NSLog(@"arrUrlList :%@",arrUrlList);
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"There are no attachments."
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
        arrUrlList = [[NSString stringWithFormat:@"%@",[dictemp valueForKey:@"DocumentURL"]] componentsSeparatedByString:@","];
        NSLog(@"arrUrlList :%@",arrUrlList);
        [self viewDocumentPopUpMethod];
    }
}

#pragma mark - Create Document WebView PopUp Method
-(void)viewDocumentPopUpMethod
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    
    mainBg = [[UIView alloc] initWithFrame:CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height)];
    mainBg.backgroundColor =[UIColor whiteColor];
    
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,mainBg.frame.size.width,64)];
        }
        else if(screenSize.height == 667.0f){
            //6
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,mainBg.frame.size.width,64)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,mainBg.frame.size.width,64)];
        }
        else if(screenSize.height == 812.0f){
            //X
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,mainBg.frame.size.width,84)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,mainBg.frame.size.width,84)];
        }
        else
        {
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,mainBg.frame.size.width,64)];
        }
    }
    bgVwHeader.backgroundColor =[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
    [mainBg addSubview:bgVwHeader];
    
    
    
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            btnDonepdf=[UIButton buttonWithType:UIButtonTypeCustom];
            btnDonepdf.frame=CGRectMake(8, 28, 60, 28);
            [btnDonepdf setBackgroundColor:[UIColor clearColor]];
            [btnDonepdf setTitle:@"Done" forState:UIControlStateNormal];
            [btnDonepdf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnDonepdf.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16.0];
            [btnDonepdf addTarget:self action:@selector(donepdf:) forControlEvents:UIControlEventTouchUpInside];
            [btnDonepdf clipsToBounds];
            [bgVwHeader addSubview:btnDonepdf];
        }
        else if(screenSize.height == 667.0f){
            //6
            btnDonepdf=[UIButton buttonWithType:UIButtonTypeCustom];
            btnDonepdf.frame=CGRectMake(8, 28, 60, 28);
            [btnDonepdf setBackgroundColor:[UIColor clearColor]];
            [btnDonepdf setTitle:@"Done" forState:UIControlStateNormal];
            [btnDonepdf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnDonepdf.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16.0];
            [btnDonepdf addTarget:self action:@selector(donepdf:) forControlEvents:UIControlEventTouchUpInside];
            [btnDonepdf clipsToBounds];
            [bgVwHeader addSubview:btnDonepdf];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            btnDonepdf=[UIButton buttonWithType:UIButtonTypeCustom];
            btnDonepdf.frame=CGRectMake(8, 28, 60, 28);
            [btnDonepdf setBackgroundColor:[UIColor clearColor]];
            [btnDonepdf setTitle:@"Done" forState:UIControlStateNormal];
            [btnDonepdf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnDonepdf.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16.0];
            [btnDonepdf addTarget:self action:@selector(donepdf:) forControlEvents:UIControlEventTouchUpInside];
            [btnDonepdf clipsToBounds];
            [bgVwHeader addSubview:btnDonepdf];
        }
        else if(screenSize.height == 812.0f){
            //X
            btnDonepdf=[UIButton buttonWithType:UIButtonTypeCustom];
            btnDonepdf.frame=CGRectMake(8, 42, 60, 28);
            [btnDonepdf setBackgroundColor:[UIColor clearColor]];
            [btnDonepdf setTitle:@"Done" forState:UIControlStateNormal];
            [btnDonepdf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnDonepdf.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16.0];
            [btnDonepdf addTarget:self action:@selector(donepdf:) forControlEvents:UIControlEventTouchUpInside];
            [btnDonepdf clipsToBounds];
            [bgVwHeader addSubview:btnDonepdf];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            btnDonepdf=[UIButton buttonWithType:UIButtonTypeCustom];
            btnDonepdf.frame=CGRectMake(8, 42, 60, 28);
            [btnDonepdf setBackgroundColor:[UIColor clearColor]];
            [btnDonepdf setTitle:@"Done" forState:UIControlStateNormal];
            [btnDonepdf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnDonepdf.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16.0];
            [btnDonepdf addTarget:self action:@selector(donepdf:) forControlEvents:UIControlEventTouchUpInside];
            [btnDonepdf clipsToBounds];
            [bgVwHeader addSubview:btnDonepdf];
        }
        else
        {
            btnDonepdf=[UIButton buttonWithType:UIButtonTypeCustom];
            btnDonepdf.frame=CGRectMake(8, 28, 60, 28);
            [btnDonepdf setBackgroundColor:[UIColor clearColor]];
            [btnDonepdf setTitle:@"Done" forState:UIControlStateNormal];
            [btnDonepdf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnDonepdf.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16.0];
            [btnDonepdf addTarget:self action:@selector(donepdf:) forControlEvents:UIControlEventTouchUpInside];
            [btnDonepdf clipsToBounds];
            [bgVwHeader addSubview:btnDonepdf];
        }
    }
    
    
    bgTopBarVw = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(bgVwHeader.frame),mainBg.frame.size.width,120)];
    bgTopBarVw.backgroundColor =[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    bgTopBarVw.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    bgTopBarVw.layer.shadowOffset = CGSizeMake(0, 2.0f);
    bgTopBarVw.layer.shadowOpacity = 1.0f;
    [bgTopBarVw.layer setMasksToBounds:NO];
    [bgTopBarVw.layer setCornerRadius: 0.0];
    [bgTopBarVw.layer setBorderWidth:0.0];
    [bgTopBarVw.layer setBorderColor:[[UIColor clearColor] CGColor]];
    [mainBg addSubview:bgTopBarVw];
    
    webViewPdfReader=[[UIWebView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(bgTopBarVw.frame)+10, bgTopBarVw.frame.size.width-20, mainBg.frame.size.height-194)];
    NSString *str1=[NSString stringWithFormat:@"%@",[arrUrlList objectAtIndex:0]];
    NSLog(@"str1:%@",str1);
    NSURL *url = [NSURL URLWithString:[str1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSLog(@"url :%@",url);
    webViewPdfReader.scalesPageToFit=YES;
    webViewPdfReader.delegate=self;
    webViewPdfReader.tag=333;
    [webViewPdfReader setBackgroundColor:[UIColor clearColor]];
    [webViewPdfReader.scrollView setZoomScale:4.0 animated:NO];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webViewPdfReader loadRequest:requestObj];
    [mainBg addSubview:webViewPdfReader];
    
    activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center = CGPointMake(CGRectGetMidX(webViewPdfReader.frame), CGRectGetMidY(webViewPdfReader.frame)-100);
    [activityView startAnimating];
    [webViewPdfReader addSubview:activityView];
    
    NSInteger numberOfPages = [arrUrlList count];
    
    scrollDoc=[[UIScrollView alloc] init];
    [scrollDoc setFrame:CGRectMake(0, 0, bgTopBarVw.frame.size.width, bgTopBarVw.frame.size.height)];
    scrollDoc.delegate=self;
    scrollDoc.backgroundColor=[UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    scrollDoc.showsHorizontalScrollIndicator=NO;
    scrollDoc.showsVerticalScrollIndicator=NO;
    scrollDoc.tag=222;
    [scrollDoc setPagingEnabled: YES];
    [bgTopBarVw addSubview:scrollDoc];
    
    UIView *viewBox;
    UIButton *pagebtn;
    UIWebView *webviewtemp;
    CGRect pageFrame ;
    int x=10;
    
    for (int i = 0 ; i < numberOfPages ; i++)
    {
        pageFrame = CGRectMake(x,10,80,90);
        
        viewBox=[[UIView alloc] init];
        [viewBox setFrame:pageFrame];
        viewBox.backgroundColor=[UIColor whiteColor];
        viewBox.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
        viewBox.layer.shadowOffset = CGSizeMake(0, 2.0f);
        viewBox.layer.shadowOpacity = 1.0f;
        [viewBox.layer setMasksToBounds:NO];
        [viewBox.layer setCornerRadius: 2.0];
        [viewBox.layer setBorderWidth:1.0];
        [viewBox.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [scrollDoc addSubview:viewBox];
        
        
        
        webviewtemp=[[UIWebView alloc] initWithFrame:CGRectMake(0,0,80,90)];
        NSString *str1=[NSString stringWithFormat:@"%@",[arrUrlList objectAtIndex:0]];
        NSLog(@"str1:%@",str1);
        NSURL *url = [NSURL URLWithString:[str1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        NSLog(@"url :%@",url);
        webviewtemp.scalesPageToFit=YES;
        webviewtemp.delegate=self;
        webviewtemp.tag=233;
        [webviewtemp setBackgroundColor:[UIColor clearColor]];
        [webviewtemp.scrollView setZoomScale:4.0 animated:NO];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [webviewtemp loadRequest:requestObj];
        [viewBox addSubview:webviewtemp];
        
        pagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [pagebtn setFrame:CGRectMake(0,0,80,90)];
        [pagebtn setBackgroundColor:[UIColor clearColor]];
        pagebtn.tag=i;
        [pagebtn addTarget:self action:@selector(pressPagebtn:) forControlEvents:UIControlEventTouchUpInside];
        [viewBox addSubview:pagebtn];
        
        activityView1 = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView1.center = pagebtn.center;
        [activityView1 startAnimating];
        [pagebtn addSubview:activityView1];
        
        x += viewBox.frame.size.width+10;
    }
    
    [scrollDoc setContentSize: CGSizeMake(scrollDoc.bounds.size.width/4*numberOfPages+10,scrollDoc.bounds.size.height)];
    
    [self.view addSubview:mainBg];
}
-(void)donepdf:(UIButton *)sender
{
    [mainBg removeFromSuperview];
}
-(void)pressPagebtn:(UIButton *)sender
{
    [activityView startAnimating];
    
    UIButton *btn=(UIButton *)sender;
    NSLog(@"selected url:%@",[arrUrlList objectAtIndex:btn.tag]);
    
    NSString *str1=[NSString stringWithFormat:@"%@",[arrUrlList objectAtIndex:btn.tag]];
    NSLog(@"str1:%@",str1);
    NSURL *url = [NSURL URLWithString:[str1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSLog(@"url:%@",url);
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webViewPdfReader loadRequest:requestObj];
    [webViewPdfReader reloadInputViews];
}

#pragma mark - UIWebview Delegate Method
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView.tag==233)
    {
        [activityView1 stopAnimating];
    }
    else if (webView.tag==333)
    {
        [activityView stopAnimating];
    }
}

#pragma mark - UIScrollView Delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    if (aScrollView.tag==222)
    {
        //Document Scroll Top View
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
    if (aScrollView.tag==222)
    {
        //Document Scroll Top View
    }
}


#pragma mark - Asynchronous Image Loading Method
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, NSData *data))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            completionBlock(YES, data);
        } else {
            completionBlock(NO, nil);
        }
    }];
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
