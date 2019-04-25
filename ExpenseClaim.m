//
//  ExpenseClaim.m
//  Paylite HR
//
//  Created by Sabnam Nasrin on 04/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "ExpenseClaim.h"

@interface ExpenseClaim ()

@end

@implementation ExpenseClaim

#pragma mark - viewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self fetchExpenseType];
}

#pragma mark - viewDidLoad Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    app4=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    currX=2.0f;
    arrImages = [[NSMutableArray alloc] init];
    
    
    _txtRemarks.text=@" Remarks";
    _txtRemarks.textColor = [UIColor lightGrayColor];
    
    _vwH.layer.shadowRadius = 3.0f;
    _vwH.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _vwH.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _vwH.layer.shadowOpacity = 0.5f;
    _vwH.layer.masksToBounds = NO;
    
    strPayCash=@"0";
    
    toolbar1 = [[UIToolbar alloc] init];
    [toolbar1 sizeToFit];
    UIBarButtonItem *flexible1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *btnClear1 = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pressDoneExpenseAmount)];
    [toolbar1 setItems:[[NSArray alloc] initWithObjects:flexible1,btnClear1, nil]];
    _txtAmount.inputAccessoryView=toolbar1;
    
    
    
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    _txtEmployee.userInteractionEnabled=NO;
   _txtEmployee.text=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeName"]];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    _txtVoucherDate.text =[formatter stringFromDate:[NSDate date]];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.barTintColor=[UIColor whiteColor];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancell)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(Done)],
                           nil];
    [numberToolbar sizeToFit];
    _txtVoucherDate.inputAccessoryView = numberToolbar;
    
    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.barTintColor=[UIColor whiteColor];
    numberToolbar1.items = [NSArray arrayWithObjects:
                            [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancell)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(Done)],
                            nil];
    [numberToolbar1 sizeToFit];
    _txtExpenseDate.inputAccessoryView = numberToolbar1;

    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+200)];
        }
        else if(screenSize.height == 667.0f){
            //6
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+110)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+110)];
        }
        else if(screenSize.height == 812.0f){
            //X
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+110)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+110)];
        }
        else{
            //4S
            [_ScrollExpense setContentSize:CGSizeMake(_ScrollExpense.frame.size.width, _ScrollExpense.frame.size.height+600)];
        }
    }
    
    [_btnSave.layer setMasksToBounds:YES];
    [_btnSave.layer setCornerRadius: 4.0];
    [_btnSave.layer setBorderWidth:0.0];
    [_btnSave.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    [self setupBorderStyleMethod];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Border Method
-(void)setupBorderStyleMethod
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _txtRemarks.frame.size.height - borderWidth, _txtRemarks.frame.size.width, _txtRemarks.frame.size.height);
    border.borderWidth = borderWidth;
    [_txtRemarks.layer addSublayer:border];
    _txtRemarks.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 0.5;
    border1.borderColor = [UIColor lightGrayColor].CGColor;
    border1.frame = CGRectMake(0, _txtVoucherDate.frame.size.height - borderWidth1, _txtVoucherDate.frame.size.width, _txtVoucherDate.frame.size.height);
    border1.borderWidth = borderWidth1;
    [_txtVoucherDate.layer addSublayer:border1];
    _txtVoucherDate.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    CGFloat borderWidth2 = 0.5;
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.frame = CGRectMake(0, _txtEmployee.frame.size.height - borderWidth2, _txtEmployee.frame.size.width, _txtEmployee.frame.size.height);
    border2.borderWidth = borderWidth2;
    [_txtEmployee.layer addSublayer:border2];
    _txtEmployee.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    CGFloat borderWidth3 = 0.5;
    border3.borderColor = [UIColor lightGrayColor].CGColor;
    border3.frame = CGRectMake(0, _txtExpenseHead.frame.size.height - borderWidth3, _txtExpenseHead.frame.size.width, _txtExpenseHead.frame.size.height);
    border3.borderWidth = borderWidth3;
    [_txtExpenseHead.layer addSublayer:border3];
    _txtExpenseHead.layer.masksToBounds = YES;
    
    CALayer *border4 = [CALayer layer];
    CGFloat borderWidth4 = 0.5;
    border4.borderColor = [UIColor lightGrayColor].CGColor;
    border4.frame = CGRectMake(0, _txtExpenseDate.frame.size.height - borderWidth4, _txtExpenseDate.frame.size.width, _txtExpenseDate.frame.size.height);
    border4.borderWidth = borderWidth4;
    [_txtExpenseDate.layer addSublayer:border4];
    _txtExpenseDate.layer.masksToBounds = YES;
    
    CALayer *border5 = [CALayer layer];
    CGFloat borderWidth5 = 0.5;
    border5.borderColor = [UIColor lightGrayColor].CGColor;
    border5.frame = CGRectMake(0, _txtAmount.frame.size.height - borderWidth5, _txtAmount.frame.size.width, _txtAmount.frame.size.height);
    border5.borderWidth = borderWidth5;
    [_txtAmount.layer addSublayer:border5];
    _txtAmount.layer.masksToBounds = YES;
    
    CALayer *border6 = [CALayer layer];
    CGFloat borderWidth6 = 0.5;
    border6.borderColor = [UIColor lightGrayColor].CGColor;
    border6.frame = CGRectMake(0, _viewPayinCash.frame.size.height - borderWidth6, _viewPayinCash.frame.size.width, _viewPayinCash.frame.size.height);
    border6.borderWidth = borderWidth6;
    [_viewPayinCash.layer addSublayer:border6];
    _viewPayinCash.layer.masksToBounds = YES;
}

#pragma mark - Back Press Method
- (IBAction)pressBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Toolbar Done Expense Amount
-(void)pressDoneExpenseAmount
{
    [_ScrollExpense setContentOffset:CGPointMake(0,0) animated:YES];
    [self.view endEditing:YES];
}

#pragma mark - Create UIDatePicker Method for Voucher Date
- (void) initializeTextFieldInputView1
{
    
    datePicker1 = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    
    datePicker1.date=[NSDate date];
    datePicker1.backgroundColor = [UIColor whiteColor];
    [datePicker1 addTarget:self action:@selector(dateUpdated1:) forControlEvents:UIControlEventValueChanged];
    _txtVoucherDate.inputView = datePicker1;
}
- (void) dateUpdated1:(UIDatePicker *)datePicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    _txtVoucherDate.text =[formatter stringFromDate:datePicker.date];
}
#pragma mark - Create UIDatePicker Method for Expanse Date
- (void) initializeTextFieldInputView2
{
    datePicker2 = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker2.datePickerMode = UIDatePickerModeDate;
    
    datePicker2.date=[NSDate date];
    datePicker2.backgroundColor = [UIColor whiteColor];
    [datePicker2 addTarget:self action:@selector(dateUpdated2:) forControlEvents:UIControlEventValueChanged];
    _txtExpenseDate.inputView = datePicker2;
    
}
- (void) dateUpdated2:(UIDatePicker *)datePicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    _txtExpenseDate.text =[formatter stringFromDate:datePicker.date];
}

#pragma mark - Done/Cancel Press Method for both UIDatePicker
-(void)Done
{
    //sabnam
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    _txtExpenseDate.text =[formatter stringFromDate:datePicker2.date];
    
    [_txtVoucherDate resignFirstResponder];
    [_txtExpenseDate resignFirstResponder];
    
    [datePicker1 removeFromSuperview];
    datePicker1=nil;
    
    [datePicker2 removeFromSuperview];
    datePicker2=nil;
}
-(void)cancell
{
    [_txtVoucherDate resignFirstResponder];
    [_txtExpenseDate resignFirstResponder];
    
    [datePicker1 removeFromSuperview];
    datePicker1=nil;
    
    [datePicker2 removeFromSuperview];
    datePicker2=nil;
}

#pragma mark - UITextField Delegate Method
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _txtVoucherDate)
    {
        [self initializeTextFieldInputView1];
    }
    else if (textField == _txtExpenseDate)
    {
        [self initializeTextFieldInputView2];
    }
    else
    {
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _txtVoucherDate)
    {
    }
    else if (textField == _txtExpenseDate)
    {
    }
    if (textField==_txtExpenseHead)
    {
        [self.view endEditing:YES];
        [self downloadExpenceType];
        return NO;
    }
    else
    {
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField==_txtVoucherDate)
    {
        [datePicker1 removeFromSuperview];
        datePicker1=nil;
    }
    else if (textField==_txtExpenseDate)
    {
        [datePicker2 removeFromSuperview];
        datePicker2=nil;
    }
    else
    {
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString: (NSString*) string
{
    if (textField==_txtAmount)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        NSString *filtered= [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    return YES;
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
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if(screenSize.height == 667.0f)
        {
            [_ScrollExpense setContentOffset:CGPointMake(0, 100) animated:YES];
        }
        else if(screenSize.height == 736.0f)
        {
            [_ScrollExpense setContentOffset:CGPointMake(0, 100) animated:YES];
        }
        else if(screenSize.height == 812.0f)
        {
            [_ScrollExpense setContentOffset:CGPointMake(0, 100) animated:YES];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            [_ScrollExpense setContentOffset:CGPointMake(0, 100) animated:YES];
        }
        else if(screenSize.height == 568.0f)
        {
            [_ScrollExpense setContentOffset:CGPointMake(0, textView.frame.origin.y-10) animated:YES];
        }
        else
        {
            [_ScrollExpense setContentOffset:CGPointMake(0, textView.frame.origin.y-10) animated:YES];
        }
    }
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
    //NSLog(@"keyboardWillBeHidden");
    //Manage comment field placeholdertext
    if(_txtRemarks.text.length == 0){
        _txtRemarks.textColor = [UIColor lightGrayColor];
        _txtRemarks.text = @" Remarks";
    }
}



#pragma mark - Pay In Cash Press Method
- (IBAction)pressPayCash:(id)sender
{
    if (_btnPayCash.selected==YES)
    {
        _btnPayCash.selected=NO;
          strPayCash=@"0";
        [_btnPayCash setImage:[UIImage imageNamed:@"uncheckbox"] forState:UIControlStateNormal];
    }
    else
    {
        _btnPayCash.selected=YES;
        strPayCash=@"1";
        [_btnPayCash setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateSelected];
    }
}





#pragma mark - Create Expence head Method
-(void)downloadExpenceType
{
    arrFeedTblPopup=arrMExpenseType;
    
    if (tabViewDropdown!=nil){
        [tabViewDropdown removeFromSuperview];
        tabViewDropdown=nil;
    }
    else
    {
        tabViewDropdown=[[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_txtExpenseHead.frame),CGRectGetMaxY(_txtExpenseHead.frame)+2, CGRectGetWidth(_txtExpenseHead.frame), 0) style:UITableViewStylePlain];
        tabViewDropdown.delegate=self;
        tabViewDropdown.dataSource=self;
        [_ScrollExpense addSubview:tabViewDropdown];
        
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
    
   objExpenseType *obj=[arrFeedTblPopup objectAtIndex:indexPath.row];
    
    UILabel *title1;
    title1=[[UILabel alloc] initWithFrame:CGRectMake(15,0,280,44)];
    title1.textAlignment=NSTextAlignmentLeft;
    title1.textColor=[UIColor darkGrayColor];
    title1.font=[UIFont fontWithName:@"GothamBook" size:13.0];
    title1.backgroundColor=[UIColor clearColor];
    title1.text=[NSString stringWithFormat:@"%@",obj.strExpenseType];
    [cell.contentView addSubview:title1];
    
    UILabel *lblSeparator;
    lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(15,42.5,tableView.frame.size.width-30,0.5)];
    lblSeparator.backgroundColor=[UIColor lightGrayColor];
    [cell.contentView addSubview:lblSeparator];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    objExpenseType *obj=[arrFeedTblPopup objectAtIndex:indexPath.row];
    _txtExpenseHead.text=[NSString stringWithFormat:@"%@",obj.strExpenseType];
    strIDDD=[NSString stringWithFormat:@"%@",obj.strExpenseID];
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

#pragma mark - Fetch ExpenseType Method
-(void)fetchExpenseType
{
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    //NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
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
                             "<GetExpenseHeadList xmlns=\"http://tempuri.org/\">"
                             "</GetExpenseHeadList> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>"];
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetExpenseHeadList" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    //NSLog(@"contentlength=%@",msgLength);
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if(theConnection)
    {
        arrMExpenseType=[[NSMutableArray alloc] init];
        NSLog(@"Connected..");
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        self.view.userInteractionEnabled=NO;
        [self showLoadingMode];
    }
    else
    {
    }
}

#pragma mark - Save Press Method
- (IBAction)pressSave:(id)sender
{
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    //NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    if ([_txtVoucherDate.text isEqualToString:@""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter voucher date."
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
    else if ([_txtExpenseHead.text isEqualToString:@""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter expense claim."
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
    else if ([_txtExpenseDate.text isEqualToString:@""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter expense date."
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
    else if ([_txtAmount.text isEqualToString:@""])
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
    else
    {
        NSString *base64String,*base64String1;
        NSData* imageData;
        
        for (UIImageView *imgvw in arrImages)
        {
            UIImage  *img = imgvw.image;
            
            imageData = [NSData dataWithData:UIImageJPEGRepresentation([self imageByScalingProportionallyToSize:CGSizeMake(200, 200) imageToResize:img], 1.0)];
            
            //imageData =[NSData dataWithData:UIImagePNGRepresentation([self imageWithImage:img scaledToSize:CGSizeMake(200, 200) isAspectRation:YES])];
            //imageData = [NSData dataWithData:UIImagePNGRepresentation([self compressImage:img])];
            //imageData = UIImageJPEGRepresentation(image,0.1);
            
            base64String1 =[Base64 encode:imageData];
            base64String=[base64String1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            base64String=[base64String1 stringByRemovingPercentEncoding];
            
        }
        
        
        //NSLog(@"imageData length:%lu",[imageData length]);
        NSLog(@"imageData size: %.2f KB", (float)[imageData length]/1024);
        NSLog(@"base64String length:%lu KB",(unsigned long)[base64String length]/1024);
        //NSLog(@"base64String :%@",base64String);
        
        if ([arrImages count]==0) {
            base64String=@"";
        }
        
        NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
        [self uploadExpenseClaimApplicationApply:[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]] username:[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"Username"]] expenseID:@"" employeeID:[dicTemp valueForKey:@"EmployeeID"] expenseHeadId:strIDDD expenseDate:_txtExpenseDate.text dAmount:_txtAmount.text PayCash:strPayCash imageattached:base64String remark:_txtRemarks.text iMode:0 managementScheme:@"" rejectComment:@""];
    }
}

#pragma mark - Post ExpenseApply Method
-(void)uploadExpenseClaimApplicationApply:(NSString *)sCompanyID username:(NSString *)sUsername expenseID:(NSString *)sExpenseID employeeID:(NSString *)sEmployeeID expenseHeadId:(NSString *)sExpenseHeadId expenseDate:(NSString *)sExpenseDate dAmount:(NSString *)amount  PayCash:(NSString *)payCash imageattached:(NSString*)strAttached remark:(NSString *)sRemark iMode:(NSInteger)imode managementScheme:(NSString *)smanagementScheme rejectComment:(NSString *)rejectComment
{
    
    strIdentifier=@"2";
    //NSLog(@"dicUserDetails ::%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]);
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    NSLog(@"imode---%lu",(unsigned long)imode);
    NSLog(@"reject Comment--%@",rejectComment);
    NSString *strReject;
    NSInteger mode;
    if (imode==0)
    {
        mode=0;
    }
    else
    {
        mode=102;
    }
    if ([rejectComment isEqualToString:@""])
    {
        strReject=@"";
    }
    else
    {
        strReject=rejectComment;
    }
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSString *strExtension;
    if ([strAttached isEqualToString:@""]) {
        strExtension=@"";
    }
    else{
        strExtension=@"jpg";
    }
    
    if ([_txtRemarks.text isEqualToString:@" Remarks"]) {
        _txtRemarks.text=@"";
        sRemark=_txtRemarks.text;
    }
    
    NSLog(@" username---%@", [dicTemp valueForKey:@"Username"]);
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<SOAP-ENV:Envelope \n"
                             "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" \n"
                             "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" \n"
                             "xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "SOAP-ENV:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" \n"
                             "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"> \n"
                             "<SOAP-ENV:Body> \n"
                             "<ExpenseClaimApplicationApply xmlns=\"http://tempuri.org/\"><sCompanyID>%@</sCompanyID>,<sUsername>%@</sUsername>,<sExpenseID>%@</sExpenseID> ,<sEmployeeID>%@</sEmployeeID>,<sExpenseHeadId>%@</sExpenseHeadId>,<sExpenseDate>%@</sExpenseDate>,<dAmount>%@</dAmount>,<bPayCash>%@</bPayCash>,<sDocument>%@</sDocument>,<extTag>%@</extTag>,<sRemark>%@</sRemark>,<iMode>%ld</iMode>,<sIsManagementScheme>%@</sIsManagementScheme>,<sRejectComment>%@</sRejectComment>"
                             "</ExpenseClaimApplicationApply> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"CompanyID"]],[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"Username"]],sExpenseID,[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],sExpenseHeadId,sExpenseDate,amount,payCash,strAttached,strExtension,sRemark,(long)mode,smanagementScheme,strReject];
    
    NSLog(@"soapMessage---%@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%ld",(long)[soapMessage length]];
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
    else{
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
            objept=[[objExpenseType alloc] init];
        }
        if ([elementName isEqualToString:@"ID"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"ExpenseHead"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
            NSLog(@"mytable is called..");
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
            [arrMExpenseType addObject:objept];
        }
        if ([elementName isEqualToString:@"ID"])
        {
            objept.strExpenseID=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"ExpenseHead"])
        {
            objept.strExpenseType=currentElementValue;
            currentElementValue=nil;
        }
    }
    else if([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"mytable"])
        {
            NSLog(@"mytable is called..");
        }
        if ([elementName isEqualToString:@"ExpenseID"])
        {
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strExpenseApplyMessageCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strExpenseApplyMessageText=currentElementValue;
            currentElementValue=nil;
        }
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        NSLog(@"arrMExpenseType :%@",arrMExpenseType);
        
        if ([arrMExpenseType count]==0)
        {
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Error in expense type."
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
    else if([strIdentifier isEqualToString:@"2"])
    {
        int code=[strExpenseApplyMessageCode intValue];
        if (code==0)
        {
            
            [self GoTOThankYouPage:@"Your request has been forwarded for approval."];
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:strExpenseApplyMessageText
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



#pragma mark - Press Add Document Method
- (IBAction)pressDocument:(id)sender
{
    if ([arrImages count]<1)
    {
        [self openCameraRoll];
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Can not upload more than one attachment."
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

#pragma mark - Camera Roll && Attach Document Flow Method
-(void)openCameraRoll
{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Take photo"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [self selfPhotoLibraryCamera];
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Choose from gallery"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [self selfPhotoLibraryPhone];
                              }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)selfPhotoLibraryPhone
{
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    //[imagePickerController setAllowsEditing:YES];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
-(void)selfPhotoLibraryCamera
{
    // if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    NSLog(@"%@",[[UIDevice currentDevice] model]);
    
    // if (![[[UIDevice currentDevice] model]isEqualToString:@"iPhone Simulator"])
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        //[imagePickerController setAllowsEditing:YES];
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Sorry!"
                                                                            message:@""
                                                                     preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *alertActionCancel = [UIAlertAction actionWithTitle: @"Your device does not have this facility."
                                                                    style: UIAlertActionStyleDestructive
                                                                  handler: ^(UIAlertAction *action) {
                                                                      NSLog(@"Dismiss button tapped!");
                                                                  }];
        [controller addAction: alertActionCancel];
        [self presentViewController: controller animated: YES completion: nil];
    }
}

#pragma mark image picker controler delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
     
    [self ScrollImgSetup:image];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    picker=nil;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{
    //NSLog(@"imageview subview :- %@",_scrollDocument.subviews);
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize imageToResize:(UIImage*)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    return newImage ;
}

#pragma mark - Setup Attachment ScrollView Method
-(void)ScrollImgSetup:(id)img
{
    ImageViewCat *imgvw;
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,80, 100)];
        }
        else if(screenSize.height == 667.0f){
            //6
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,100, 120)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,100, 120)];
        }
        else if(screenSize.height == 812.0f){
            //X
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,100, 120)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,100, 120)];
        }
        else
        {
            imgvw=[[ImageViewCat alloc]initWithFrame:CGRectMake(currX+2, 2,100, 90)];
        }
    }
    
    imgvw.userInteractionEnabled=YES;
    if ([img isKindOfClass:[NSString class]])
    {
        imgvw.strURL=(NSString*)img;
    }
    else
    {
        imgvw.strURL = @"";
        imgvw.image=(UIImage*)img;
    }
    
    UIButton *btnDlt=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(imgvw.frame)-24,0,24, 24)];
    [btnDlt setBackgroundColor:[UIColor clearColor]];
    [btnDlt setBackgroundImage:[UIImage imageNamed:@"crossR"] forState:UIControlStateNormal];
    [btnDlt addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    btnDlt.tag=arrImages.count+1;
    imgvw.tag=arrImages.count+1+100;
    [imgvw addSubview:btnDlt];
    
    
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            _scrollDocument.contentSize=CGSizeMake(currX+80, _scrollDocument.frame.size.height);
        }
        else if(screenSize.height == 667.0f){
            //6
            _scrollDocument.contentSize=CGSizeMake(currX+100, _scrollDocument.frame.size.height);
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            _scrollDocument.contentSize=CGSizeMake(currX+100, _scrollDocument.frame.size.height);
        }
        else if(screenSize.height == 812.0f){
            //X
            _scrollDocument.contentSize=CGSizeMake(currX+100, _scrollDocument.frame.size.height);
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            _scrollDocument.contentSize=CGSizeMake(currX+100, _scrollDocument.frame.size.height);
        }
        else{
            _scrollDocument.contentSize=CGSizeMake(currX+100, _scrollDocument.frame.size.height);
        }
    }
    currX=CGRectGetMaxX(imgvw.frame);
    [_scrollDocument addSubview:imgvw];
    [arrImages addObject:imgvw];
}
-(void)deleteImage:(UIButton *)sender
{
    NSLog(@"tapped Arr count ::-%lu",(unsigned long)arrImages.count);
    NSLog(@"senderctag::-%lu\n\nNo of subviews ::%@",(unsigned long)sender.tag,[_scrollDocument subviews]);
    CGFloat currXimg=0.0f;
    int i=1;
    
    NSMutableArray *toDestroy = [NSMutableArray arrayWithCapacity:arrImages.count];
    for (UIImageView *vw in arrImages)
    {
        if ([vw isKindOfClass:[UIImageView class]]){
            UIImageView *imgVw=(UIImageView *)vw;
            if (imgVw.tag-100 == sender.tag){
                [imgVw removeFromSuperview];
                [toDestroy addObject:[arrImages objectAtIndex:sender.tag-1]];
                currX=currX-CGRectGetWidth(imgVw.frame);
                imgVw=nil;
            }
        }
    }
    [arrImages removeObjectsInArray:toDestroy];
    
    for (UIImageView *vw in arrImages){
        vw.frame=CGRectMake(currXimg+2, CGRectGetMinY(vw.frame), CGRectGetWidth(vw.frame), CGRectGetHeight(vw.frame));
        currXimg=CGRectGetMaxX(vw.frame);
        vw.tag=i+100;
        for (UIButton *btn in [vw subviews]) {
            btn.tag=i;
        }
        i++;
        _scrollDocument.contentSize=CGSizeMake(CGRectGetWidth(vw.frame)*i, _scrollDocument.frame.size.height);
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
