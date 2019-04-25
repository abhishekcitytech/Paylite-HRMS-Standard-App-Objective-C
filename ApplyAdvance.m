//
//  ApplyAdvance.m
//  Paylite HRMS
//
//  Created by SANDIPAN on 31/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "ApplyAdvance.h"

@interface ApplyAdvance ()

@end

@implementation ApplyAdvance


#pragma mark - viewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self fetchAdvanceType];
}

#pragma mark - viewDidLoad Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    app7=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _txtvReason.text=@" Remarks";
    _txtvReason.textColor = [UIColor lightGrayColor];
    
    _vwH.layer.shadowRadius = 3.0f;
    _vwH.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _vwH.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _vwH.layer.shadowOpacity = 0.5f;
    _vwH.layer.masksToBounds = NO;
    
    _btnOutstandingAdvance.hidden=NO;
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            [_scrollApplyAdvance setContentSize:CGSizeMake(_scrollApplyAdvance.frame.size.width, _scrollApplyAdvance.frame.size.height+200)];
        }
        else if(screenSize.height == 667.0f){
            //6
            [_scrollApplyAdvance setContentSize:CGSizeMake(_scrollApplyAdvance.frame.size.width, _scrollApplyAdvance.frame.size.height+180)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            [_scrollApplyAdvance setContentSize:CGSizeMake(_scrollApplyAdvance.frame.size.width, _scrollApplyAdvance.frame.size.height+180)];
        }
        else if(screenSize.height == 812.0f){
            //X
            [_scrollApplyAdvance setContentSize:CGSizeMake(_scrollApplyAdvance.frame.size.width, _scrollApplyAdvance.frame.size.height+180)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            [_scrollApplyAdvance setContentSize:CGSizeMake(_scrollApplyAdvance.frame.size.width, _scrollApplyAdvance.frame.size.height+180)];
        }
        else{
            //4S
            [_scrollApplyAdvance setContentSize:CGSizeMake(_scrollApplyAdvance.frame.size.width, _scrollApplyAdvance.frame.size.height+200)];
        }
    }
    else
    {
    }
    
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    _txtEmployeename.text=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeName"]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _txtApplicationDate.text=[formatter stringFromDate:[NSDate date]];
    
    toolbar1 = [[UIToolbar alloc] init];
    [toolbar1 sizeToFit];
    UIBarButtonItem *flexible1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *btnClear1 = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pressDoneAdvanceAmount)];
    [toolbar1 setItems:[[NSArray alloc] initWithObjects:flexible1,btnClear1, nil]];
    _txtAdvanceamount.inputAccessoryView=toolbar1;
    
    toolbar2 = [[UIToolbar alloc] init];
    [toolbar2 sizeToFit];
    UIBarButtonItem *flexible2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *btnClear2 = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pressDoneNoofInstallment)];
    [toolbar2 setItems:[[NSArray alloc] initWithObjects:flexible2,btnClear2, nil]];
    _txtNoofinstallment.inputAccessoryView=toolbar2;
    
    [_btnApply.layer setMasksToBounds:YES];
    [_btnApply.layer setCornerRadius: 4.0];
    [_btnApply.layer setBorderWidth:0.0];
    [_btnApply.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
//    NSString *tem = _btnOutstandingAdvance.titleLabel.text;
//    if (tem != nil && ![tem isEqualToString:@""]) {
//        NSMutableAttributedString *temString=[[NSMutableAttributedString alloc]initWithString:tem];
//        [temString addAttribute:NSUnderlineStyleAttributeName
//                          value:[NSNumber numberWithInt:2]
//                          range:(NSRange){0,[temString length]}];
//        _btnOutstandingAdvance.titleLabel.attributedText = temString;
//    }
    
    [self setBorderStyleMethod];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [_scrollApplyAdvance setContentOffset:CGPointMake(0,0) animated:YES];
    [self.view endEditing:YES];
    
    [self calculateRepaymentAmount];
}
#pragma mark - Toolbar Done NoofInstallment
-(void)pressDoneNoofInstallment
{
    [_scrollApplyAdvance setContentOffset:CGPointMake(0,0) animated:YES];
    [self.view endEditing:YES];
    
    [self calculateRepaymentAmount];
}


#pragma mark - UItextField Delegate Method
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString: (NSString*) string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray  *arrayOfString = [newString componentsSeparatedByString:@"."];
    
    if ([arrayOfString count] > 2 )
    {
        return NO;
    }
    
    if (textField==_txtAdvanceamount)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        NSString *filtered= [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    if (textField==_txtNoofinstallment)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        NSString *filtered= [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (![string isEqualToString:filtered]) {
        }
        return [string isEqualToString:filtered];
    }
    
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==_txtAdvancetype)
    {
        [self.view endEditing:YES];
        [self downloadAdvanceType];
        
        if (![_txtNoofinstallment.text isEqualToString:@""]) {
            [self calculateRepaymentAmount];
        }
        return NO;
    }
    else if (textField==_txtdeductionmonthyear)
    {
        [self.view endEditing:YES];
        [self selectdate];
        
        if (![_txtNoofinstallment.text isEqualToString:@""]) {
            [self calculateRepaymentAmount];
        }
        return NO;
    }
    
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


#pragma mark - UItextView Delegate Method
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
    else if (![_txtNoofinstallment.text isEqualToString:@""]) {
        [self calculateRepaymentAmount];
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView isEqual:_txtvReason])
    {
        [_scrollApplyAdvance setContentOffset:CGPointMake(0, 200) animated:YES];
    }
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView==_txtvReason) {
        [_scrollApplyAdvance setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //NSLog(@"keyboardWillBeHidden");
    //Manage comment field placeholdertext
    if(_txtvReason.text.length == 0){
        _txtvReason.textColor = [UIColor lightGrayColor];
        _txtvReason.text = @" Remarks";
    }
}


#pragma mark - RepaymentAmount Calculation Method
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

#pragma mark- ApplyAdvance Method
- (IBAction)pressApplyAdvance:(id)sender
{
    
    if (_txtApplicationDate.text.length<=0 || _txtAdvanceamount.text.length <=0 || _txtNoofinstallment.text.length<=0 || _txtrepaymentamount.text.length<=0)
    {
      
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter all fields."
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
    else if (_txtAdvanceamount.text.length <=0)
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
    }
    else if (_txtNoofinstallment.text.length<=0)
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
    else if (_txtrepaymentamount.text.length<=0)
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Repayment amount can't be blank."
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
        if (_txtAdvancetype.text.length<=0)
        {
          
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Please select advance type."
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
            
            return;
        }
        
        //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
        NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
        
        NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
        NSLog(@"strConUrl :%@",strConUrl);
        
        if ([_txtvReason.text isEqualToString:@" Remarks"]) {
            _txtvReason.text=@"";
        }
        
        strIdentifier=@"2";
        NSString *soapMessage = [NSString stringWithFormat:
                                 @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                                 "<SOAP-ENV:Envelope \n"
                                 "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                                 "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                                 "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                                 "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                                 "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                                 "<SOAP-ENV:Body> \n"
                                 "<ApplyAdvance xmlns=\"http://tempuri.org/\"><sCompanyID>%@</sCompanyID>,<sUsername>%@</sUsername>,<AdvanceID></AdvanceID>,<sEmployeeID>%@</sEmployeeID>,<dAdvanceAmount>%@</dAdvanceAmount>,<iNoOfInstalment>%@</iNoOfInstalment>,<dRepaymentAmount>%@</dRepaymentAmount>,<sAdvanceType>%@</sAdvanceType>,<iDeductionMonth>%@</iDeductionMonth>,<iDeductionYear>%@</iDeductionYear>,<Remarks>%@</Remarks>,<iMode>%@</iMode>"
                                 "</ApplyAdvance> \n"
                                 "</SOAP-ENV:Body> \n"
                                 "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"Username"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],_txtAdvanceamount.text,_txtNoofinstallment.text,_txtrepaymentamount.text,strIDDD,month,year,_txtvReason.text,@"0"];
        
        NSLog(@"soapMessage---%@",soapMessage);
        NSURL *url = [NSURL URLWithString:strConUrl];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"http://tempuri.org/ISelfService/ApplyAdvance" forHTTPHeaderField:@"SOAPAction"];
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
        else{
        }
        
    }
    
}

#pragma mark - Outstanding Advance Method
- (IBAction)pressOutstandingAdvance:(id)sender
{
    GetOutstandingAdvance *objDemo;
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            objDemo = [[GetOutstandingAdvance alloc] initWithNibName:@"GetOutstandingAdvance5S" bundle:nil];
        }
        else if(screenSize.height == 667.0f){
            //6
            objDemo = [[GetOutstandingAdvance alloc] initWithNibName:@"GetOutstandingAdvance6" bundle:nil];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            objDemo = [[GetOutstandingAdvance alloc] initWithNibName:@"GetOutstandingAdvance6Plus" bundle:nil];
        }
        else if(screenSize.height == 812.0f){
            //X
            objDemo = [[GetOutstandingAdvance alloc] initWithNibName:@"GetOutstandingAdvanceX" bundle:nil];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            objDemo = [[GetOutstandingAdvance alloc] initWithNibName:@"GetOutstandingAdvanceXSMAX" bundle:nil];
        }
        else{
            objDemo = [[GetOutstandingAdvance alloc] initWithNibName:@"GetOutstandingAdvance" bundle:nil];
        }
    }
    else
    {
    }
    [self.navigationController pushViewController:objDemo animated:YES];
}



#pragma mark - Create AdvanceType PopUp List Method
-(void)downloadAdvanceType
{
    arrFeedTblPopup=arrMAdvanceType;
    
    if (tabViewDropdown!=nil){
        [tabViewDropdown removeFromSuperview];
        tabViewDropdown=nil;
    }
    else
    {
        tabViewDropdown=[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_txtAdvancetype.frame),CGRectGetMaxY(_txtAdvancetype.frame)+2, CGRectGetWidth(_txtAdvancetype.frame), 0) style:UITableViewStylePlain];
        tabViewDropdown.delegate=self;
        tabViewDropdown.dataSource=self;
        [_scrollApplyAdvance addSubview:tabViewDropdown];
        
        tabViewDropdown.backgroundView=nil;
        tabViewDropdown.backgroundColor=[UIColor whiteColor];
        tabViewDropdown.separatorColor=[UIColor clearColor];
        
        [tabViewDropdown.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [tabViewDropdown.layer setBorderWidth: 0.6];
        [tabViewDropdown.layer setCornerRadius:2.0f];
        [tabViewDropdown.layer setMasksToBounds:YES];
        
        [UIView animateWithDuration:0.35
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             CGRect frame = tabViewDropdown.frame;
                             frame.size.height = 176;
                             tabViewDropdown.frame = frame;
                         }
                         completion:^(BOOL finished){
                         }];
    }
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
    
    objAdvanceType *obj=[arrFeedTblPopup objectAtIndex:indexPath.row];
    
    UILabel *title1;
    title1=[[UILabel alloc] initWithFrame:CGRectMake(15,0,280,44)];
    title1.textAlignment=NSTextAlignmentLeft;
    title1.textColor=[UIColor darkGrayColor];
    title1.font=[UIFont fontWithName:@"GothamBook" size:13.0];
    title1.backgroundColor=[UIColor clearColor];
    title1.text=[NSString stringWithFormat:@"%@",obj.strAdvanceType];
    [cell.contentView addSubview:title1];
    
    UILabel *lblSeparator;
    lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(15,42.5,tableView.frame.size.width-30,0.5)];
    lblSeparator.backgroundColor=[UIColor lightGrayColor];
    [cell.contentView addSubview:lblSeparator];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    objAdvanceType *obj=[arrFeedTblPopup objectAtIndex:indexPath.row];
    _txtAdvancetype.text=[NSString stringWithFormat:@"%@",obj.strAdvanceType];
    strIDDD=[NSString stringWithFormat:@"%@",obj.strAdvanceID];
    
    [self handleTap];
}
-(void)handleTap
{
    [UIView animateWithDuration:0.35
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = tabViewDropdown.frame;
                         frame.size.height = 0;
                         tabViewDropdown.frame = frame;
                     }
                     completion:^(BOOL finished){
                         [tabViewDropdown removeFromSuperview];
                         tabViewDropdown=nil;
                     }];
}


#pragma mark- Fetch LevaeType Method
-(void)fetchAdvanceType
{
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
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
                             "<GetAdvanceType xmlns=\"http://tempuri.org/\"><sCompanyID>%@</sCompanyID>"
                             "</GetAdvanceType> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]]];
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetAdvanceType" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //NSLog(@"contentlength=%@",msgLength);
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if(theConnection)
    {
        arrMAdvanceType=[[NSMutableArray alloc] init];
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

#pragma mark - XML Parser Method
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
            objadt=[[objAdvanceType alloc] init];
        }
        if ([elementName isEqualToString:@"ID"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"AdvanceType"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if([strIdentifier isEqualToString:@"2"])
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
            [arrMAdvanceType addObject:objadt];
        }
        if ([elementName isEqualToString:@"ID"])
        {
            objadt.strAdvanceID=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"AdvanceType"])
        {
            objadt.strAdvanceType=currentElementValue;
            currentElementValue=nil;
        }
    }
    else if([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strAdvanceApplyMessageCode=currentElementValue;
            currentElementValue=nil;
        }
        
        if ([elementName isEqualToString:@"MessageText"])
        {
            strAdvanceApplyMessageText=currentElementValue;
            currentElementValue=nil;
        }
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        NSLog(@"arrMAdvanceType :%@",arrMAdvanceType);
        if ([arrMAdvanceType count]==0)
        {
           
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Error in advance type."
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
            
            
        }
    }
    else if ([strIdentifier isEqualToString:@"2"])
    {
        int code=[strAdvanceApplyMessageCode intValue];
        if (code==0){
            [self GoTOThankYouPage:@"Your request has been forwarded for approval."];
        }
        else{
           
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:strAdvanceApplyMessageText
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

#pragma mark - Create Deduction Month/Year PickerView Method
-(void)selectdate
{
    [_txtrepaymentamount resignFirstResponder];
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if (IsDatePickerShown==NO)
    {
        IsDatePickerShown=YES;
        
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                VwDatePick=[[UIView alloc]initWithFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 240)];
                VwDatePick.backgroundColor=[UIColor clearColor];
            }
            else if(screenSize.height == 667.0f){
                //6
                VwDatePick=[[UIView alloc]initWithFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 240)];
                VwDatePick.backgroundColor=[UIColor clearColor];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                VwDatePick=[[UIView alloc]initWithFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 280)];
                VwDatePick.backgroundColor=[UIColor clearColor];
            }
            else if(screenSize.height == 812.0f){
                //X
                VwDatePick=[[UIView alloc]initWithFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 280)];
                VwDatePick.backgroundColor=[UIColor clearColor];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                VwDatePick=[[UIView alloc]initWithFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 280)];
                VwDatePick.backgroundColor=[UIColor clearColor];
            }
            else{
                VwDatePick=[[UIView alloc]initWithFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 240)];
                VwDatePick.backgroundColor=[UIColor clearColor];
            }
        }
        
        UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame: CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 40)];
        toolbar.barStyle = UIBarStyleDefault;
        toolbar.barTintColor=[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Done" style: UIBarButtonItemStylePlain target: self action: @selector(donePressed:)];
        doneButton.tintColor=[UIColor whiteColor];
        doneButton.width=UIScreen.mainScreen.bounds.size.width-30;
        toolbar.items = [NSArray arrayWithObject: doneButton];
        [VwDatePick addSubview: toolbar];
        
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                datePicker = [[UIMonthYearPicker alloc] initWithFrame:CGRectMake(0, 40, UIScreen.mainScreen.bounds.size.width, 200)];
            }
            else if(screenSize.height == 667.0f){
                //6
                datePicker = [[UIMonthYearPicker alloc] initWithFrame:CGRectMake(0, 40, UIScreen.mainScreen.bounds.size.width, 200)];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                datePicker = [[UIMonthYearPicker alloc] initWithFrame:CGRectMake(0, 40, UIScreen.mainScreen.bounds.size.width, 240)];
            }
            else if(screenSize.height == 812.0f){
                //X
                datePicker = [[UIMonthYearPicker alloc] initWithFrame:CGRectMake(0, 40, UIScreen.mainScreen.bounds.size.width, 240)];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                datePicker = [[UIMonthYearPicker alloc] initWithFrame:CGRectMake(0, 40, UIScreen.mainScreen.bounds.size.width, 240)];
            }
            else{
                datePicker = [[UIMonthYearPicker alloc] initWithFrame:CGRectMake(0, 40, UIScreen.mainScreen.bounds.size.width, 200)];
            }
        }
        
        dateFormatter = [[NSDateFormatter alloc] init];
        datePicker._delegate=self;
        [dateFormatter setDateFormat:@"MMMM-yyyy"];
        datePicker.backgroundColor=[UIColor whiteColor];
        [VwDatePick addSubview:datePicker];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [NSDateComponents new];
        comps.month = -1;
        comps.year  = 0;
        NSDate *date = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        
        NSDate *dateFromTextfield = [dateFormatter dateFromString:_txtdeductionmonthyear.text];
        NSDate *dateFromTextfield1 = [calendar dateByAddingComponents:comps toDate:dateFromTextfield options:0];
        NSLog(@"%@",dateFromTextfield);
        
        NSDateComponents *components;
        //NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date]; // Get necessary date components
        //NSLog(@"Previous month: %d",[components month]);
        //NSLog(@"Previous day  : %d",[components day]);
        //NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *currentDate = [NSDate date];
        //NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:10];
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        [comps setYear:-20];
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        [datePicker setMaximumDate:maxDate];
        [datePicker setMinimumDate:minDate];
        if ([_txtdeductionmonthyear.text isEqualToString:@""])
        {
            components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
            [datePicker setDate:date];
        }
        else
        {
            components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateFromTextfield1];
            [datePicker setDate:dateFromTextfield1];
        }
        
        //[datePicker setDate:date];
        //NSString *stre=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: [NSDate date]]];
        strDateSelect=@"";
        [self.view addSubview:VwDatePick];
        
        [UIView animateWithDuration:0.5
                              delay:0.1
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
                             {
                                 if (screenSize.height==568.0f){
                                     //5S
                                     [VwDatePick setFrame:CGRectMake(0, result.height-240, UIScreen.mainScreen.bounds.size.width, 240)];
                                 }
                                 else if(screenSize.height == 667.0f){
                                     //6
                                     [VwDatePick setFrame:CGRectMake(0, result.height-240, UIScreen.mainScreen.bounds.size.width, 240)];
                                 }
                                 else if(screenSize.height == 736.0f){
                                     //6Plus
                                     [VwDatePick setFrame:CGRectMake(0, result.height-280, UIScreen.mainScreen.bounds.size.width, 280)];
                                 }
                                 else if(screenSize.height == 812.0f){
                                     //X
                                     [VwDatePick setFrame:CGRectMake(0, result.height-280, UIScreen.mainScreen.bounds.size.width, 280)];
                                 }
                                 else if(screenSize.height == 896.0f){
                                     //XSMAX XR
                                     [VwDatePick setFrame:CGRectMake(0, result.height-280, UIScreen.mainScreen.bounds.size.width, 280)];
                                 }
                                 else{
                                     [VwDatePick setFrame:CGRectMake(0, result.height-240, UIScreen.mainScreen.bounds.size.width, 240)];
                                 }
                             }
                             
                         }completion:^(BOOL finished){
                             NSLog(@"Completed");
                         }];
    }
    else{
    }
}
-(void)donePressed:(id)sender
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    CGSize result = [[UIScreen mainScreen] bounds].size;
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
                         {
                             if (screenSize.height==568.0f){
                                 //5S
                                 [VwDatePick setFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 240)];
                             }
                             else if(screenSize.height == 667.0f){
                                 //6
                                 [VwDatePick setFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 240)];
                             }
                             else if(screenSize.height == 736.0f){
                                 //6Plus
                                 [VwDatePick setFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 280)];
                             }
                             else if(screenSize.height == 812.0f){
                                 //X
                                 [VwDatePick setFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 280)];
                             }
                             else if(screenSize.height == 896.0f){
                                 //XSMAX XR
                                 [VwDatePick setFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 280)];
                             }
                             else{
                                 [VwDatePick setFrame:CGRectMake(0, result.height, UIScreen.mainScreen.bounds.size.width, 240)];
                             }
                         }
                     }completion:^(BOOL finished){
                         NSLog(@"Completed");
                         [VwDatePick removeFromSuperview];
                     }];
    
    IsDatePickerShown=NO;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendar *gregorian = [[NSCalendar alloc]  initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componentsYear = [gregorian components:(NSCalendarUnitYear| NSCalendarUnitMonth) fromDate:selDate];
    NSInteger SelyearNum = [ componentsYear year];
    NSInteger SelmonthNum = [componentsYear month];
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger CuryearNum = [components year];
    NSInteger CurmonthNum =[components month];
    
    //NSLog(@"Cure:%@",currentDate);
    //NSLog(@"Cur Month %ld, Year %ld", (long)CurmonthNum, (long)CuryearNum);
    //NSLog(@"selected Month %ld, Year %ld", (long)SelmonthNum, (long)SelyearNum);
    
    if ([strDateSelect isEqualToString:@""]){
    }
    else
    {
        if ((CuryearNum==SelyearNum && SelmonthNum<CurmonthNum)||(CuryearNum>SelyearNum))
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Please select from current month."
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
            
            return;
        }
    }
    month=[NSString stringWithFormat:@"%ld",(long)SelmonthNum];
    year=[NSString stringWithFormat:@"%ld",(long)SelyearNum];
    
    NSLog(@"strDateSelect :%@",strDateSelect);
    
    if ([strDateSelect isEqualToString:@"1"])
    {
        strDateFromPicker=[dateFormatter stringFromDate:selDate];
        _txtdeductionmonthyear.text=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:selDate]];
    }
    else
    {
        NSString *stre=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate: [NSDate date]]];
        NSLog(@"stre :%@",stre);
        
        NSDate *currentDate = [NSDate date];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
        NSInteger CuryearNum1 = [components year];
        NSInteger CurmonthNum1=[components month];
        month=[NSString stringWithFormat:@"%ld",(long)CurmonthNum1];
        year=[NSString stringWithFormat:@"%ld",(long)CuryearNum1];
        
        _txtdeductionmonthyear.text=[NSString stringWithFormat:@"%@",stre];
    }
}

#pragma mark - UIMonthYearPicker Delegate Method
- (void) pickerView:(UIPickerView *)pickerView didChangeDate:(NSDate *)newDate
{
    strDateSelect=@"1";
    NSLog(@"new date---%@",newDate);
    selDate=newDate;//rrr4
    strDateFromPicker=[dateFormatter stringFromDate:newDate];
    NSLog(@">>>>>>>>>>>>....%@",[dateFormatter stringFromDate:newDate]);
    //[self.btnDeductionMonth setTitle:[dateFormatter stringFromDate:newDate] forState:UIControlStateNormal];
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
    viewAddcartPopup.frame=CGRectMake(10,-20, UIScreen.mainScreen.bounds.size.width-20,80);
    viewAddcartPopup.backgroundColor=[UIColor colorWithRed:254/256.0 green:91/256.0 blue:65/256.0 alpha:1.0];
    
    viewAddcartPopup.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    viewAddcartPopup.layer.shadowOffset = CGSizeMake(0, 2.0f);
    viewAddcartPopup.layer.shadowOpacity = 1.0f;
    [viewAddcartPopup.layer setMasksToBounds:NO];
    [viewAddcartPopup.layer setCornerRadius: 6.0];
    [viewAddcartPopup.layer setBorderWidth:0.0];
    [viewAddcartPopup.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    UILabel *lblC1=[[UILabel alloc] init];
    lblC1.font=[UIFont fontWithName:@"GothamBold" size:12];
    lblC1.textColor=[UIColor whiteColor];
    lblC1.textAlignment=NSTextAlignmentLeft;
    lblC1.backgroundColor=[UIColor clearColor];
    [lblC1 setFrame:CGRectMake(5,3,viewAddcartPopup.frame.size.width-10,10)];
    lblC1.text = [NSString stringWithFormat:@"%@",@" Message"];
    [viewAddcartPopup addSubview:lblC1];
    
    
    UILabel *lblC=[[UILabel alloc] init];
    lblC.font=[UIFont fontWithName:@"GothamBook" size:13];
    lblC.textColor=[UIColor whiteColor];
    lblC.textAlignment=NSTextAlignmentLeft;
    lblC.backgroundColor=[UIColor clearColor];
    [lblC setFrame:CGRectMake(5,5,viewAddcartPopup.frame.size.width-10,viewAddcartPopup.frame.size.height-10)];
    lblC.text = [NSString stringWithFormat:@"%@",strmsg];
    lblC.numberOfLines=4;
    [viewAddcartPopup addSubview:lblC];
    
    
    viewAddcartPopup.layer.zPosition = 1;
    [UIView animateWithDuration:1.0 delay:0.3 options: UIViewAnimationOptionCurveEaseIn animations:^{
        [viewAddcartPopup setFrame:CGRectMake(10,20, UIScreen.mainScreen.bounds.size.width-20,80)];
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
