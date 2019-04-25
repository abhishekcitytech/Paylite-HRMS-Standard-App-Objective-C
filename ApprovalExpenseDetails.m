//
//  ApprovalExpenseDetails.m
//  Paylite HR
//
//  Created by Sandipan on 10/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "ApprovalExpenseDetails.h"

@interface ApprovalExpenseDetails ()

@end

@implementation ApprovalExpenseDetails
@synthesize objldtsss;

#pragma mark - viewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self setupDetail];
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
    
    toolbar1 = [[UIToolbar alloc] init];
    [toolbar1 sizeToFit];
    UIBarButtonItem *flexible1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *btnClear1 = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pressDoneExpenseAmount)];
    [toolbar1 setItems:[[NSArray alloc] initWithObjects:flexible1,btnClear1, nil]];
    _txtAmount.inputAccessoryView=toolbar1;
    
    [_btnApprove.layer setMasksToBounds:YES];
    [_btnApprove.layer setCornerRadius: 4.0];
    [_btnApprove.layer setBorderWidth:0.0];
    [_btnApprove.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    [_btnReject.layer setMasksToBounds:YES];
    [_btnReject.layer setCornerRadius: 4.0];
    [_btnReject.layer setBorderWidth:0.0];
    [_btnReject.layer setBorderColor:[[UIColor clearColor] CGColor]];

    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+400)];
        }
        else if(screenSize.height == 667.0f){
            //6
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+200)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+200)];
        }
        else if(screenSize.height == 812.0f){
            //X
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+100)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+100)];
        }
        else{
            //4S
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+600)];
            
        }
    }
    
    [self setBorderStyleMethod];
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Toolbar Done Expense Amount
-(void)pressDoneExpenseAmount
{
    [_ScrollExpense setContentOffset:CGPointMake(0,0) animated:YES];
    [self.view endEditing:YES];
}

#pragma mark - Data SetUp Details Method
-(void)setupDetail
{
    _txtVoucherDate.text=objldtsss.voucherDate;
    _txtEmployee.text=objldtsss.Employee;
    _txtExpenseHead.text=objldtsss.expenseHeadType;
    _txtExpenseDate.text=objldtsss.expenseDate;
    
    NSString *strRemarks=[NSString stringWithFormat:@"%@",objldtsss.expenseRemarks];
    NSLog(@"strRemarks :%@",strRemarks);
    if (strRemarks.length>0)
    {
        _txtRemarks.text=strRemarks;
        _txtRemarks.textColor = [UIColor blackColor];
    }
    else{
        _txtRemarks.text=@" Remarks";
        _txtRemarks.textColor = [UIColor lightGrayColor];
    }
    
    NSString *strUrl=[NSString stringWithFormat:@"%@",objldtsss.expenseimages];
    if ([strUrl isEqualToString:@""]) {
    }
    else
    {
        btnAttch=[UIButton buttonWithType:UIButtonTypeCustom];
        btnAttch.frame=CGRectMake(CGRectGetMinX(_txtRemarks.frame)+10,CGRectGetMaxY(_txtRemarks.frame)+10,80,100);
        [btnAttch setBackgroundColor:[UIColor clearColor]];
        [btnAttch.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [btnAttch.layer setBorderWidth: 0.5];
        [btnAttch.layer setCornerRadius:4.0f];
        [btnAttch.layer setMasksToBounds:YES];
        
        btnAttchGrayOut=[UIButton buttonWithType:UIButtonTypeCustom];
        btnAttchGrayOut.frame=CGRectMake(CGRectGetMinX(_txtRemarks.frame)+10,CGRectGetMaxY(_txtRemarks.frame)+10,80,100);
        [btnAttchGrayOut setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6]];
        [btnAttchGrayOut setTitle:@"View" forState:UIControlStateNormal];
        btnAttchGrayOut.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:14];
        [btnAttchGrayOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnAttchGrayOut.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [btnAttchGrayOut.layer setBorderWidth: 0.5];
        [btnAttchGrayOut.layer setCornerRadius:4.0f];
        [btnAttchGrayOut.layer setMasksToBounds:YES];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        self.view.userInteractionEnabled=NO;
        [self showLoadingMode];
        NSURL *imgUrl = [NSURL URLWithString:[strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
        [self downloadImageWithURL:imgUrl completionBlock:^(BOOL succeeded, NSData *data) {
            if (succeeded)
            {
                btnAttch.contentMode=UIViewContentModeScaleToFill;
                [btnAttch setBackgroundImage:[[UIImage alloc] initWithData:data] forState:UIControlStateNormal];
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                self.view.userInteractionEnabled=YES;
                [self hideLoadingMode];
            }
            else
            {
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                self.view.userInteractionEnabled=YES;
                [self hideLoadingMode];
            }
        }];
        
        [btnAttchGrayOut addTarget:self action:@selector(pressOpenAttachment:) forControlEvents:UIControlEventTouchUpInside];
        [_ScrollExpense addSubview:btnAttch];
        [_ScrollExpense addSubview:btnAttchGrayOut];
        
        
        [_btnApprove setFrame:CGRectMake(_btnApprove.frame.origin.x,_btnApprove.frame.origin.y+btnAttch.frame.size.height+20, _btnApprove.frame.size.width, _btnApprove.frame.size.height)];
        [_btnReject setFrame:CGRectMake(_btnReject.frame.origin.x,CGRectGetMaxY(_btnApprove.frame)+10, _btnReject.frame.size.width, _btnReject.frame.size.height)];
    }
    
    NSString *string = [NSString stringWithFormat:@"%@",objldtsss.expenseAmount];
    float floatValue = [string floatValue];
    NSLog(@"%0.3f",floatValue);
    _txtAmount.text=[NSString stringWithFormat:@"%0.3f",floatValue];

    NSString *stringpayincash = [NSString stringWithFormat:@"%@",objldtsss.expensePayCash];
    NSLog(@"stringpayincash :%@",stringpayincash);
    
    if ([stringpayincash isEqualToString:@"true"]){
        _btnPayCash.selected=YES;
    }
    else{
        _btnPayCash.selected=NO;
    }
}

#pragma mark - pressAttachment Popup Method
-(void)pressOpenAttachment:(id)sender
{
    NSString *strUrl=[NSString stringWithFormat:@"%@",objldtsss.expenseimages];
    [self openAttachmentPopup:@"3" imgUrl:strUrl];
}

#pragma mark - Set Border Style Method
-(void)setBorderStyleMethod
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _txtVoucherDate.frame.size.height - borderWidth, _txtVoucherDate.frame.size.width, _txtVoucherDate.frame.size.height);
    border.borderWidth = borderWidth;
    [_txtVoucherDate.layer addSublayer:border];
    _txtVoucherDate.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 0.5;
    border1.borderColor = [UIColor lightGrayColor].CGColor;
    border1.frame = CGRectMake(0, _txtEmployee.frame.size.height - borderWidth1, _txtEmployee.frame.size.width, _txtEmployee.frame.size.height);
    border1.borderWidth = borderWidth1;
    [_txtEmployee.layer addSublayer:border1];
    _txtEmployee.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    CGFloat borderWidth2 = 0.5;
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.frame = CGRectMake(0, _txtExpenseHead.frame.size.height - borderWidth2, _txtExpenseHead.frame.size.width, _txtExpenseHead.frame.size.height);
    border2.borderWidth = borderWidth2;
    [_txtExpenseHead.layer addSublayer:border2];
    _txtExpenseHead.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    CGFloat borderWidth3 = 0.5;
    border3.borderColor = [UIColor lightGrayColor].CGColor;
    border3.frame = CGRectMake(0, _txtExpenseDate.frame.size.height - borderWidth3, _txtExpenseDate.frame.size.width, _txtExpenseDate.frame.size.height);
    border3.borderWidth = borderWidth3;
    [_txtExpenseDate.layer addSublayer:border3];
    _txtExpenseDate.layer.masksToBounds = YES;
    
    CALayer *border4 = [CALayer layer];
    CGFloat borderWidth4 = 0.5;
    border4.borderColor = [UIColor lightGrayColor].CGColor;
    border4.frame = CGRectMake(0, _txtAmount.frame.size.height - borderWidth4, _txtAmount.frame.size.width, _txtAmount.frame.size.height);
    border4.borderWidth = borderWidth4;
    [_txtAmount.layer addSublayer:border4];
    _txtAmount.layer.masksToBounds = YES;
    
    CALayer *border5 = [CALayer layer];
    CGFloat borderWidth5 = 0.5;
    border5.borderColor = [UIColor lightGrayColor].CGColor;
    border5.frame = CGRectMake(0, _txtRemarks.frame.size.height - borderWidth5, _txtRemarks.frame.size.width, _txtRemarks.frame.size.height);
    border5.borderWidth = borderWidth5;
    [_txtRemarks.layer addSublayer:border5];
    _txtRemarks.layer.masksToBounds = YES;
    
    CALayer *border6 = [CALayer layer];
    CGFloat borderWidth6 = 0.5;
    border6.borderColor = [UIColor lightGrayColor].CGColor;
    border6.frame = CGRectMake(0, _viewpaycash.frame.size.height - borderWidth6, _viewpaycash.frame.size.width, _viewpaycash.frame.size.height);
    border6.borderWidth = borderWidth6;
    [_viewpaycash.layer addSublayer:border6];
    _viewpaycash.layer.masksToBounds = YES;
    
}

#pragma mark - Back Press Method
- (IBAction)pressBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Pay In Cash Press Method
- (IBAction)pressPayCash:(id)sender
{
}

#pragma mark - UITextView Delegate Method
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if( [_txtRemarks.text isEqualToString:@" Remarks"] && [_txtRemarks.textColor isEqual:[UIColor lightGrayColor]] ){
        _txtRemarks.text = @"";
        _txtRemarks.textColor = [UIColor blackColor];
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView==_txtRemarks) {
        [_ScrollExpense setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if(_txtRemarks.text.length == 0){
        _txtRemarks.textColor = [UIColor lightGrayColor];
        _txtRemarks.text = @" Remarks";
    }
}

#pragma mark - Approve / Reject Press Method
- (IBAction)pressApprove:(id)sender
{
    Useraction=101;

    if ([_txtAmount.text isEqualToString:@""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter expense amount."
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
    else if ([_txtRemarks.text isEqualToString:@" Remarks"]||[_txtRemarks.text isEqualToString:@""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter your remarks."
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
        [self uploadData:@"101"];
    }
}
- (IBAction)pressReject:(id)sender
{
    Useraction=102;
    
    if ([_txtAmount.text isEqualToString:@""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter expense amount."
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
    else if ([_txtRemarks.text isEqualToString:@" Remarks"]||[_txtRemarks.text isEqualToString:@""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter your remarks."
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
        [self uploadData:@"102"];
    }
}


#pragma mark - Upload Expense Approval Data
-(void)uploadData:(NSString*)action
{
    NSInteger mode;
    if ([action isEqualToString:@"101"])
    {
        mode=101;
    }
    else
    {
        mode=102;
    }
    
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
                             "<ExpenseClaimApplicationApply xmlns=\"http://tempuri.org/\"><sCompanyID>%@</sCompanyID>,<sUsername>%@</sUsername>,<sExpenseID>%@</sExpenseID> ,<sEmployeeID>%@</sEmployeeID>,<sExpenseHeadId>%@</sExpenseHeadId>,<sExpenseDate>%@</sExpenseDate>,<dAmount>%@</dAmount>,<bPayCash>%@</bPayCash>,<sDocument>%@</sDocument>,<sRemark>%@</sRemark>,<iMode>%ld</iMode>,<sIsManagementScheme>%@</sIsManagementScheme>,<sRejectComment>%@</sRejectComment>"
                             "</ExpenseClaimApplicationApply> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"Username"]],objldtsss.expenseID,[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],objldtsss.expenseHeadID,objldtsss.expenseDate,_txtAmount.text,objldtsss.expensePayCash,@"",_txtRemarks.text,(long)mode,@"",_txtRemarks.text];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/ExpenseClaimApplicationApply" forHTTPHeaderField:@"SOAPAction"];
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
        //NSLog(@"theConnection is NULL");
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

#pragma mark - XML parser Delegate
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([strIdentifier isEqualToString:@"1"])
    {
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
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strExpenseMsgCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strExpenseMsgText=currentElementValue;
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
        int code=[strExpenseMsgCode intValue];
        if (code==0){
            if (Useraction==102)
            {
                
                [self GoTOThankYouPage:@"Expense request has been rejected."];
            }
            else if (Useraction==101)
            {
               
                [self GoTOThankYouPage:@"Expense request has been approved."];
            }
        }
        else{
           
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:strExpenseMsgText
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

#pragma mark - Go To ThankYou Page Method
-(void)GoTOThankYouPage:(NSString *)strMSG
{
    ThankYou *objDemo;
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYou5S" bundle:nil];
        }
        else if(screenSize.height == 667.0f){
            //6
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYou6" bundle:nil];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYou6Plus" bundle:nil];
        }
        else if(screenSize.height == 812.0f){
            //X
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYouX" bundle:nil];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYouXSMAX" bundle:nil];
        }
        else{
            objDemo = [[ThankYou alloc] initWithNibName:@"ThankYou" bundle:nil];
        }
    }
    else
    {
    }
    objDemo.strMessage=strMSG;
    [self.navigationController pushViewController:objDemo animated:YES];
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

#pragma mark - Attachment Popup Method
-(void)openAttachmentPopup:(NSString *)strSelectedCell imgUrl:(NSString *)strUrl
{
    [self showLoadingMode];
    mainBg = [[UIView alloc] initWithFrame:CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width,self.view.frame.size.height)];
    mainBg.backgroundColor =[UIColor whiteColor];
    
    bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,mainBg.frame.size.width,64)];
    bgVwHeader.backgroundColor =[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
    [mainBg addSubview:bgVwHeader];
    
    webvwImgPopup = [[UIImageView alloc]initWithFrame:CGRectMake(60,128,bgVwHeader.frame.size.width-120,300)];
    webvwImgPopup.backgroundColor=[UIColor whiteColor];
    [bgVwHeader addSubview:webvwImgPopup];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    self.view.userInteractionEnabled=NO;
    NSURL *imgUrl = [NSURL URLWithString:[strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    [self downloadImageWithURL:imgUrl completionBlock:^(BOOL succeeded, NSData *data) {
        if (succeeded)
        {
            //webvwImgPopup.contentMode=UIViewContentModeScaleAspectFit;
            webvwImgPopup.image= [[UIImage alloc] initWithData:data];
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            self.view.userInteractionEnabled=YES;
            [self hideLoadingMode];
        }
        else
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            self.view.userInteractionEnabled=YES;
            [self hideLoadingMode];
        }
    }];
    
    btnDonepdf=[UIButton buttonWithType:UIButtonTypeCustom];
    btnDonepdf.frame=CGRectMake(8, 28, 60, 28);
    [btnDonepdf setBackgroundColor:[UIColor clearColor]];
    [btnDonepdf setTitle:@"Done" forState:UIControlStateNormal];
    [btnDonepdf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnDonepdf.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16.0];
    [btnDonepdf addTarget:self action:@selector(donepdf:) forControlEvents:UIControlEventTouchUpInside];
    [btnDonepdf clipsToBounds];
    [bgVwHeader addSubview:btnDonepdf];
    
    [self.view addSubview:mainBg];
}
-(void)donepdf:(UIButton *)sender
{
    [mainBg removeFromSuperview];

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
