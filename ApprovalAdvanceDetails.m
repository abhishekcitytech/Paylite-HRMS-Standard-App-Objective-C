//
//  ApprovalAdvanceDetails.m
//  Paylite HRMS
//
//  Created by SANDIPAN on 21/06/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ApprovalAdvanceDetails.h"

@interface ApprovalAdvanceDetails ()

@end

@implementation ApprovalAdvanceDetails
@synthesize objadssss;

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
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            [_scrollAdvance setContentSize:CGSizeMake(_scrollAdvance.frame.size.width, _scrollAdvance.frame.size.height+150)];
        }
        else if(screenSize.height == 667.0f){
            //6
            [_scrollAdvance setContentSize:CGSizeMake(_scrollAdvance.frame.size.width, _scrollAdvance.frame.size.height+100)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            [_scrollAdvance setContentSize:CGSizeMake(_scrollAdvance.frame.size.width, _scrollAdvance.frame.size.height+100)];
        }
        else if(screenSize.height == 812.0f){
            //X
            [_scrollAdvance setContentSize:CGSizeMake(_scrollAdvance.frame.size.width, _scrollAdvance.frame.size.height+100)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            [_scrollAdvance setContentSize:CGSizeMake(_scrollAdvance.frame.size.width, _scrollAdvance.frame.size.height+100)];
        }
        else{
            //4S
            [_scrollAdvance setContentSize:CGSizeMake(_scrollAdvance.frame.size.width, _scrollAdvance.frame.size.height+150)];
        }
    }
    else
    {
    }
    
    
    [_btnApprove.layer setMasksToBounds:YES];
    [_btnApprove.layer setCornerRadius: 4.0];
    [_btnApprove.layer setBorderWidth:0.0];
    [_btnApprove.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    [_btnReject.layer setMasksToBounds:YES];
    [_btnReject.layer setCornerRadius: 4.0];
    [_btnReject.layer setBorderWidth:0.0];
    [_btnReject.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    [self setBorderStyleMethod];
    
    UIToolbar *toolbar1 = [[UIToolbar alloc] init];
    [toolbar1 sizeToFit];
    UIBarButtonItem *flexible1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *btnClear1 = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pressDoneAdvanceAmount)];
    [toolbar1 setItems:[[NSArray alloc] initWithObjects:flexible1,btnClear1, nil]];
    _txtAdvanceamount.inputAccessoryView=toolbar1;
    
    UIToolbar *toolbar2 = [[UIToolbar alloc] init];
    [toolbar2 sizeToFit];
    UIBarButtonItem *flexible2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *btnClear2 = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pressDoneNoofInstallment)];
    [toolbar2 setItems:[[NSArray alloc] initWithObjects:flexible2,btnClear2, nil]];
    _txtNoofinstallment.inputAccessoryView=toolbar2;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data SetUp Details Method
-(void)setupDetail
{
    _txtApplicationDate.text=objadssss.ApplicationDate;
    _txtEmployeename.text=objadssss.Employee;
    _txtAdvancetype.text=objadssss.AdvanceType;
    
    NSString *strRemarks=[NSString stringWithFormat:@"%@",objadssss.reason];
    NSLog(@"strRemarks :%@",strRemarks);
    if (strRemarks.length>0)
    {
        _txtvReason.text=strRemarks;
        _txtvReason.textColor = [UIColor blackColor];
    }
    else{
        _txtvReason.text=@" Remarks";
        _txtvReason.textColor = [UIColor lightGrayColor];
    }
    
    NSString *string = [NSString stringWithFormat:@"%@",objadssss.AdvanceAmount];
    float floatValue = [string floatValue];
    NSLog(@"%0.2f",floatValue);
    _txtAdvanceamount.text=[NSString stringWithFormat:@"%0.2f",floatValue];
   
    _txtNoofinstallment.text=objadssss.NoOfInstallmentMonth;
    
    NSString *string1 = [NSString stringWithFormat:@"%@",objadssss.RepaymentAmount];
    float floatValue1 = [string1 floatValue];
    NSLog(@"%0.2f",floatValue1);
    _txtrepaymentamount.text=[NSString stringWithFormat:@"%0.2f",floatValue1];
    
    _txtdeductionmonthyear.text=[NSString stringWithFormat:@"%@/%@",objadssss.MonthName,objadssss.YearNO];
}

#pragma mark - Set Border Style Method
-(void)setBorderStyleMethod
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _txtApplicationDate.frame.size.height - borderWidth, _txtApplicationDate.frame.size.width, _txtApplicationDate.frame.size.height);
    border.borderWidth = borderWidth;
    [_txtApplicationDate.layer addSublayer:border];
    _txtApplicationDate.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 0.5;
    border1.borderColor = [UIColor lightGrayColor].CGColor;
    border1.frame = CGRectMake(0, _txtEmployeename.frame.size.height - borderWidth1, _txtEmployeename.frame.size.width, _txtApplicationDate.frame.size.height);
    border1.borderWidth = borderWidth1;
    [_txtEmployeename.layer addSublayer:border1];
    _txtEmployeename.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    CGFloat borderWidth2 = 0.5;
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.frame = CGRectMake(0, _txtAdvancetype.frame.size.height - borderWidth2, _txtAdvancetype.frame.size.width, _txtAdvancetype.frame.size.height);
    border2.borderWidth = borderWidth2;
    [_txtAdvancetype.layer addSublayer:border2];
    _txtAdvancetype.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    CGFloat borderWidth3 = 0.5;
    border3.borderColor = [UIColor lightGrayColor].CGColor;
    border3.frame = CGRectMake(0, _txtAdvanceamount.frame.size.height - borderWidth3, _txtAdvanceamount.frame.size.width, _txtAdvanceamount.frame.size.height);
    border3.borderWidth = borderWidth3;
    [_txtAdvanceamount.layer addSublayer:border3];
    _txtAdvanceamount.layer.masksToBounds = YES;
    
    CALayer *border4 = [CALayer layer];
    CGFloat borderWidth4 = 0.5;
    border4.borderColor = [UIColor lightGrayColor].CGColor;
    border4.frame = CGRectMake(0, _txtNoofinstallment.frame.size.height - borderWidth4, _txtNoofinstallment.frame.size.width, _txtNoofinstallment.frame.size.height);
    border4.borderWidth = borderWidth4;
    [_txtNoofinstallment.layer addSublayer:border4];
    _txtNoofinstallment.layer.masksToBounds = YES;
    
    CALayer *border5 = [CALayer layer];
    CGFloat borderWidth5 = 0.5;
    border5.borderColor = [UIColor lightGrayColor].CGColor;
    border5.frame = CGRectMake(0, _txtrepaymentamount.frame.size.height - borderWidth5, _txtrepaymentamount.frame.size.width, _txtrepaymentamount.frame.size.height);
    border5.borderWidth = borderWidth5;
    [_txtrepaymentamount.layer addSublayer:border5];
    _txtrepaymentamount.layer.masksToBounds = YES;
    
    CALayer *border6 = [CALayer layer];
    CGFloat borderWidth6 = 0.5;
    border6.borderColor = [UIColor lightGrayColor].CGColor;
    border6.frame = CGRectMake(0, _txtdeductionmonthyear.frame.size.height - borderWidth6, _txtdeductionmonthyear.frame.size.width, _txtdeductionmonthyear.frame.size.height);
    border6.borderWidth = borderWidth6;
    [_txtdeductionmonthyear.layer addSublayer:border6];
    _txtdeductionmonthyear.layer.masksToBounds = YES;
    
    CALayer *border7 = [CALayer layer];
    CGFloat borderWidth7 = 0.5;
    border7.borderColor = [UIColor lightGrayColor].CGColor;
    border7.frame = CGRectMake(0, _txtvReason.frame.size.height - borderWidth7, _txtvReason.frame.size.width, _txtvReason.frame.size.height);
    border7.borderWidth = borderWidth7;
    [_txtvReason.layer addSublayer:border7];
    _txtvReason.layer.masksToBounds = YES;
    
}

#pragma mark - Back Press Method
- (IBAction)pressBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Toolbar Done AdvanceAmount
-(void)pressDoneAdvanceAmount
{
    [self calculateRepaymentAmount];
    [self.view endEditing:YES];
}
#pragma mark - Toolbar Done NoofInstallment
-(void)pressDoneNoofInstallment
{
    [self calculateRepaymentAmount];
    [self.view endEditing:YES];
}
#pragma mark- RepaymentAmount Calculation Method
-(void)calculateRepaymentAmount
{
    double a=[_txtAdvanceamount.text doubleValue];
    double b=[_txtNoofinstallment.text doubleValue];
    double c=a/b;
    if([_txtNoofinstallment.text isEqual:@""] || [_txtAdvanceamount.text isEqual:@""])
    {
        _txtrepaymentamount.text=@"";
    }
    else{
        _txtrepaymentamount.text=[NSString stringWithFormat:@"%g",c];
    }
}

#pragma mark - TextView Delegate Method
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
    if( [_txtvReason.text isEqualToString:@" Remarks"] && [_txtvReason.textColor isEqual:[UIColor lightGrayColor]] ){
        _txtvReason.text = @"";
        _txtvReason.textColor = [UIColor blackColor];
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView isEqual:_txtvReason])
    {
        [_scrollAdvance setContentOffset:CGPointMake(0, 100) animated:YES];
    }
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView==_txtvReason)
    {
        [_scrollAdvance setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if(_txtvReason.text.length == 0){
        _txtvReason.textColor = [UIColor lightGrayColor];
        _txtvReason.text = @" Remarks";
    }
}

#pragma mark - UItextField Delegate Method
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString: (NSString*) string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray  *arrayOfString = [newString componentsSeparatedByString:@"."];
    
    if ([arrayOfString count] > 2 )
        return NO;
    
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
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
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark - Approve  Method
- (IBAction)pressApprove:(id)sender
{
    Useraction=101;
    
    if ([_txtAdvanceamount.text isEqualToString:@""])
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter advance amount."
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
        
    }else if ([_txtNoofinstallment.text isEqualToString:@""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter no of installments."
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
    else if ([_txtrepaymentamount.text isEqualToString:@""])
    {
       
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter repayment amount."
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
    else if ([_txtvReason.text isEqualToString:@" Remarks"]||[_txtvReason.text isEqualToString:@""])
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

#pragma mark - Reject  Method
- (IBAction)pressReject:(id)sender
{
    Useraction=102;
    
    if ([_txtAdvanceamount.text isEqualToString:@""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter advance amount."
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
        
    }else if ([_txtNoofinstallment.text isEqualToString:@""])
    {
       
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter no of installments."
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
    else if ([_txtrepaymentamount.text isEqualToString:@""])
    {
       
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter repayment amount."
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
    else if ([_txtvReason.text isEqualToString:@" Remarks"]||[_txtvReason.text isEqualToString:@""])
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

#pragma mark - Upload Advance Approval Data
-(void)uploadData:(NSString*)action
{
    strIdentifier=@"1";
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];
    NSDate *aDate = [formatter dateFromString:objadssss.MonthName];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:aDate];
    int month =(int)[components month];
    
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
                             "<ApplyAdvance xmlns=\"http://tempuri.org/\"><sCompanyID>%@</sCompanyID>,<sUsername>%@</sUsername>,<AdvanceID>%@</AdvanceID>,<sEmployeeID>%@</sEmployeeID>,<dAdvanceAmount>%@</dAdvanceAmount>,<iNoOfInstalment>%@</iNoOfInstalment>,<dRepaymentAmount>%@</dRepaymentAmount>,<sAdvanceType>%@</sAdvanceType>,<iDeductionMonth>%d</iDeductionMonth>,<iDeductionYear>%@</iDeductionYear>,<sRejectComment>%@</sRejectComment>,<Remarks>%@</Remarks>,<iMode>%@</iMode>"
                             "</ApplyAdvance> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"Username"]],objadssss.ID,[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],_txtAdvanceamount.text,_txtNoofinstallment.text,_txtrepaymentamount.text,objadssss.AdvanceTypeID,month,objadssss.YearNO,_txtvReason.text,_txtvReason.text,action];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/ApplyAdvance" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
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
            strAdvanceMsgCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strAdvanceMsgText=currentElementValue;
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
        int code=[strAdvanceMsgCode intValue];
        if (code==0){
            if (Useraction==102)
            {
               
                [self GoTOThankYouPage:@"Advance request has been rejected."];
            }
            else if (Useraction==101)
            {
               
                [self GoTOThankYouPage:@"Advance request has been approved."];
            }
        }
        else{
          
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:strAdvanceMsgText
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
