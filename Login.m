//
//  Login.m
//  Paylite HRMS
//
//  Created by SANDIPAN on 29/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "Login.h"

@interface Login ()
@property (nonatomic,retain)NSMutableArray *arrListNotification;
@end

@implementation Login

#pragma mark - viewWillAppear Method
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
   
    NSLog(@"%f",_imgvBanner.frame.origin.x);
    NSLog(@"%f",_imgvBanner.frame.origin.y);
    NSLog(@"%f",_imgvBanner.frame.size.width);
    NSLog(@"%f",_imgvBanner.frame.size.height);
    
    NSLog(@"%f",_viewbglog.frame.origin.x);
    NSLog(@"%f",_viewbglog.frame.origin.y);
    NSLog(@"%f",_viewbglog.frame.size.width);
    NSLog(@"%f",_viewbglog.frame.size.height);
    
}

#pragma mark - viewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"strFlagforDBFetching"] isEqualToString:@"0"]){
    }
    else{
    }
    
    NSLog(@"username:%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"username"]);
    NSLog(@"password:%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"password"]);
    NSLog(@"rememberme:%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"rememberme"]);
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"username"]){
        _txtUsername.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"username"];
    }
    else{
        _txtUsername.text=@"";
    }
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"password"]){
        _txtPassword.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"password"];
    }else{
        _txtPassword.text=@"";
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isAccountActiveDeactiveiOSPlatform"] isEqualToString:@"1"])
    {
        //Account still inactive from 50 server
        [self openACCnumber];
    }
    else
    {
        //Account active now from 50 server
    }

}

#pragma mark - viewDidLoad Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    app1=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    isKeyBoardAnimated=NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    NSLog(@"strFlagforDBFetching  %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"strFlagforDBFetching"]);
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"strFlagforDBFetching"] isEqualToString:@"0"]){
    }
    else
    {
        [self openACCnumber];
    }
    
    [_btnLogin.layer setMasksToBounds:YES];
    [_btnLogin.layer setCornerRadius: 4.0];
    [_btnLogin.layer setBorderWidth:0.0];
    [_btnLogin.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _txtUsername.frame.size.height - borderWidth, _txtUsername.frame.size.width, _txtUsername.frame.size.height);
    border.borderWidth = borderWidth;
    [_txtUsername.layer addSublayer:border];
    _txtUsername.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 0.5;
    border1.borderColor = [UIColor lightGrayColor].CGColor;
    border1.frame = CGRectMake(0, _txtPassword.frame.size.height - borderWidth1, _txtPassword.frame.size.width, _txtPassword.frame.size.height);
    border1.borderWidth = borderWidth1;
    [_txtPassword.layer addSublayer:border1];
    _txtPassword.layer.masksToBounds = YES;
    
    app1.dicUserDetails=[[NSMutableDictionary alloc] init];
    app1.dicCompanyDetails=[[NSMutableDictionary alloc] init];
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"username"]){
        _txtUsername.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"username"];
    }
    else{
        _txtUsername.text=@"";
    }
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"password"]){
        _txtPassword.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"password"];
    }else{
        _txtPassword.text=@"";
    }
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"]!=nil)
    {
        [self gotoDashboardPage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Remember Me Method
-(void)RememberMEData
{
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"username"]){
        _txtUsername.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"username"];
    }
    else{
        _txtUsername.text=@"";
    }
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"password"]){
        _txtPassword.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"password"];
    }else{
        _txtPassword.text=@"";
    }
}

#pragma mark - openACCnumber PopUp Method
-(void)openACCnumber
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    
    NSLog(@"screenSize.height:::: %f",screenSize.width);
    NSLog(@"screenSize.height:::: %f",screenSize.height);
    
    ctrlPop=[[UIControl alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
    ctrlPop.alpha=1.0;
    ctrlPop.backgroundColor=[UIColor whiteColor];
    
    viewPop=[[UIView alloc] init];
    viewPop.frame=CGRectMake(0,0,ctrlPop.frame.size.width,ctrlPop.frame.size.height/2);
    viewPop.backgroundColor =[UIColor whiteColor];
    [ctrlPop addSubview:viewPop];
    
    imgvPop1=[[UIImageView alloc] init];
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            [imgvPop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-90,110, 180, 46)];
        }
        else if(screenSize.height == 667.0f){
            //6
            [imgvPop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-90,170, 180, 46)];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            [imgvPop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-90,170, 180, 46)];
        }
        else if(screenSize.height == 812.0f){
            //X
            [imgvPop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-90,170, 180, 46)];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            [imgvPop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-90,180, 180, 46)];
        }
        else
        {
            [imgvPop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-90,110, 180, 46)];
        }
    }
    
    [imgvPop1 setImage:[UIImage imageNamed:@"paylitelogo"]];
    imgvPop1.backgroundColor=[UIColor clearColor];
    [viewPop addSubview:imgvPop1];
    
    txtfpop1=[[UITextField alloc] init];
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            [txtfpop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-viewPop.frame.size.width/2+30,CGRectGetMaxY(imgvPop1.frame)+60,viewPop.frame.size.width-60,44)];
            
            CALayer *border = [CALayer layer];
            CGFloat borderWidth = 0.5;
            border.borderColor = [UIColor lightGrayColor].CGColor;
            border.frame = CGRectMake(0, txtfpop1.frame.size.height - borderWidth, txtfpop1.frame.size.width, txtfpop1.frame.size.height);
            border.borderWidth = borderWidth;
            [txtfpop1.layer addSublayer:border];
            txtfpop1.layer.masksToBounds = YES;
        }
        else if(screenSize.height == 667.0f){
            //6
            [txtfpop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-viewPop.frame.size.width/2+30,CGRectGetMaxY(imgvPop1.frame)+60,viewPop.frame.size.width-60,44)];
            
            CALayer *border = [CALayer layer];
            CGFloat borderWidth = 0.5;
            border.borderColor = [UIColor lightGrayColor].CGColor;
            border.frame = CGRectMake(0, txtfpop1.frame.size.height - borderWidth, txtfpop1.frame.size.width, txtfpop1.frame.size.height);
            border.borderWidth = borderWidth;
            [txtfpop1.layer addSublayer:border];
            txtfpop1.layer.masksToBounds = YES;
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            [txtfpop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-viewPop.frame.size.width/2+30,CGRectGetMaxY(imgvPop1.frame)+110,viewPop.frame.size.width-60,44)];
            
            CALayer *border = [CALayer layer];
            CGFloat borderWidth = 2.5;
            border.borderColor = [UIColor lightGrayColor].CGColor;
            border.frame = CGRectMake(0, txtfpop1.frame.size.height - borderWidth, txtfpop1.frame.size.width, txtfpop1.frame.size.height);
            border.borderWidth = borderWidth;
            [txtfpop1.layer addSublayer:border];
            txtfpop1.layer.masksToBounds = YES;
        }
        else if(screenSize.height == 812.0f){
            //X
            [txtfpop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-viewPop.frame.size.width/2+30,CGRectGetMaxY(imgvPop1.frame)+140,viewPop.frame.size.width-60,44)];
            
            CALayer *border = [CALayer layer];
            CGFloat borderWidth = 0.5;
            border.borderColor = [UIColor lightGrayColor].CGColor;
            border.frame = CGRectMake(0, txtfpop1.frame.size.height - borderWidth, txtfpop1.frame.size.width, txtfpop1.frame.size.height);
            border.borderWidth = borderWidth;
            [txtfpop1.layer addSublayer:border];
            txtfpop1.layer.masksToBounds = YES;
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            [txtfpop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-viewPop.frame.size.width/2+30,CGRectGetMaxY(imgvPop1.frame)+170,viewPop.frame.size.width-60,44)];
            
            CALayer *border = [CALayer layer];
            CGFloat borderWidth = 0.5;
            border.borderColor = [UIColor lightGrayColor].CGColor;
            border.frame = CGRectMake(0, txtfpop1.frame.size.height - borderWidth, txtfpop1.frame.size.width, txtfpop1.frame.size.height);
            border.borderWidth = borderWidth;
            [txtfpop1.layer addSublayer:border];
            txtfpop1.layer.masksToBounds = YES;
        }
        else
        {
            [txtfpop1 setFrame:CGRectMake(CGRectGetMidX(viewPop.frame)-viewPop.frame.size.width/2+30,CGRectGetMaxY(imgvPop1.frame)+60,viewPop.frame.size.width-60,44)];
            
            CALayer *border = [CALayer layer];
            CGFloat borderWidth = 0.5;
            border.borderColor = [UIColor lightGrayColor].CGColor;
            border.frame = CGRectMake(0, txtfpop1.frame.size.height - borderWidth, txtfpop1.frame.size.width, txtfpop1.frame.size.height);
            border.borderWidth = borderWidth;
            [txtfpop1.layer addSublayer:border];
            txtfpop1.layer.masksToBounds = YES;
        }
    }
    
    txtfpop1.textColor=[UIColor darkGrayColor];
    [txtfpop1 setBorderStyle:UITextBorderStyleNone];
    txtfpop1.textAlignment=NSTextAlignmentCenter;
    txtfpop1.backgroundColor=[UIColor clearColor];
    txtfpop1.delegate=self;
    txtfpop1.placeholder=@"Account Number";
    txtfpop1.keyboardType=UIKeyboardTypeNumberPad;
    txtfpop1.font=[UIFont fontWithName:@"GothamBook" size:14.0];
    [txtfpop1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [viewPop addSubview:txtfpop1];
    
    //----------------------------------
    viewPop1=[[UIView alloc] init];
    viewPop1.frame=CGRectMake(0,CGRectGetMaxY(viewPop.frame),ctrlPop.frame.size.width,ctrlPop.frame.size.height/2);
    viewPop1.backgroundColor =[UIColor whiteColor];
    [ctrlPop addSubview:viewPop1];
    
    UILabel *lbl1=[[UILabel alloc] init];
    [lbl1 setFrame:CGRectMake(0,20,ctrlPop.frame.size.width,20)];
    lbl1.font=[UIFont fontWithName:@"GothamBook" size:13.0];
    lbl1.textAlignment=NSTextAlignmentCenter;
    lbl1.textColor=[UIColor darkGrayColor];
    lbl1.backgroundColor=[UIColor clearColor];
    lbl1.text=@"OR";
    [viewPop1 addSubview:lbl1];
    
    btnGetAcc=[UIButton buttonWithType:UIButtonTypeCustom];
    btnGetAcc.frame=CGRectMake(CGRectGetMidX(viewPop1.frame)-viewPop1.frame.size.width/2+30,55,viewPop1.frame.size.width-60,50);
    btnGetAcc.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:16.0];
    [btnGetAcc addTarget:self action:@selector(pressGetAcc:) forControlEvents:UIControlEventTouchUpInside];
    [btnGetAcc setBackgroundColor:[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0]];
    btnGetAcc.tag=11;
    [btnGetAcc.layer setMasksToBounds:YES];
    [btnGetAcc.layer setCornerRadius: 4.0];
    [btnGetAcc.layer setBorderWidth:0.0];
    [btnGetAcc.layer setBorderColor:[[UIColor clearColor] CGColor]];
    [btnGetAcc setTitle:@"Get Your Account Number" forState:UIControlStateNormal];
    [btnGetAcc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewPop1 addSubview:btnGetAcc];
   
    [self.view addSubview:ctrlPop];
}
-(void)pressGetAcc:(id)sender
{
    [txtfpop1 resignFirstResponder];
    [self openEmailPopup];

}

#pragma mark - Get Account Number Email Popup Method
-(void)openEmailPopup
{
    mainBg = [[UIView alloc] initWithFrame:CGRectMake(0,0,screenWidth,screenHeight)];
    mainBg.backgroundColor =[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    
    UIView * bgView;
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            bgView = [[UIView alloc] initWithFrame:CGRectMake(0,screenHeight,screenWidth-40,180)];
            bgView.center=CGPointMake(CGRectGetWidth(self.view.frame)/2.0f, CGRectGetHeight(self.view.frame)/2.0f);
        }
        else if(screenSize.height == 667.0f){
            //6
            bgView = [[UIView alloc] initWithFrame:CGRectMake(0,screenHeight,screenWidth-40,180)];
            bgView.center=CGPointMake(CGRectGetWidth(self.view.frame)/2.0f, CGRectGetHeight(self.view.frame)/2.0f+20);
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            bgView = [[UIView alloc] initWithFrame:CGRectMake(0,screenHeight,screenWidth-40,180)];
            bgView.center=CGPointMake(CGRectGetWidth(self.view.frame)/2.0f, CGRectGetHeight(self.view.frame)/2.0f);
        }
        else if(screenSize.height == 812.0f){
            //X
            bgView = [[UIView alloc] initWithFrame:CGRectMake(0,screenHeight,screenWidth-40,180)];
            bgView.center=CGPointMake(CGRectGetWidth(self.view.frame)/2.0f, CGRectGetHeight(self.view.frame)/2.0f+20);
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            bgView = [[UIView alloc] initWithFrame:CGRectMake(0,screenHeight,screenWidth-40,180)];
            bgView.center=CGPointMake(CGRectGetWidth(self.view.frame)/2.0f, CGRectGetHeight(self.view.frame)/2.0f+20);
        }
        else
        {
            bgView = [[UIView alloc] initWithFrame:CGRectMake(0,screenHeight,screenWidth-40,180)];
            bgView.center=CGPointMake(CGRectGetWidth(self.view.frame)/2.0f, CGRectGetHeight(self.view.frame)/2.0f);
        }
    }
    [bgView.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [bgView.layer setBorderWidth: 0.5];
    [bgView.layer setCornerRadius:4.0f];
    [bgView.layer setMasksToBounds:YES];
    bgView.backgroundColor =[UIColor whiteColor];
    
    txtPOPEmail=[[UITextField alloc] initWithFrame:CGRectMake(20,50,bgView.frame.size.width-40,44)];
    [txtPOPEmail setBorderStyle:UITextBorderStyleNone];
    txtPOPEmail.textAlignment=NSTextAlignmentCenter;
    txtPOPEmail.textColor=[UIColor darkGrayColor];
    txtPOPEmail.delegate=self;
    txtPOPEmail.placeholder=@"Email address";
    txtPOPEmail.keyboardType=UIKeyboardTypeEmailAddress;
    txtPOPEmail.font=[UIFont fontWithName:@"GothamBook" size:14.0];
    txtPOPEmail.backgroundColor=[UIColor whiteColor];
    [bgView addSubview:txtPOPEmail];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, txtPOPEmail.frame.size.height - borderWidth, txtPOPEmail.frame.size.width, txtPOPEmail.frame.size.height);
    border.borderWidth = borderWidth;
    [txtPOPEmail.layer addSublayer:border];
    txtPOPEmail.layer.masksToBounds = YES;
    
    btnPOPSubmit=[UIButton buttonWithType:UIButtonTypeCustom];
    btnPOPSubmit.frame=CGRectMake(0,bgView.frame.size.height-50,bgView.frame.size.width,50);
    [btnPOPSubmit setTitle:@"Submit" forState:UIControlStateNormal];
    [btnPOPSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnPOPSubmit.titleLabel.font=[UIFont fontWithName:@"GothamBold" size:16.0];
    [btnPOPSubmit setBackgroundColor:[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0]];
    [btnPOPSubmit addTarget:self action:@selector(pressSubmitForm:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnPOPSubmit];
    
    UIButton *btnCross=[UIButton buttonWithType:UIButtonTypeCustom];
    btnCross.frame=CGRectMake(CGRectGetWidth(bgView.frame)-30,10,20,20);
    [btnCross setBackgroundColor:[UIColor clearColor]];
    [btnCross setBackgroundImage:[UIImage imageNamed:@"crossB"] forState:UIControlStateNormal];
    [btnCross addTarget:self action:@selector(cross:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnCross];
    
    [mainBg addSubview:bgView];
    [self.view addSubview:mainBg];
    
}
-(void)cross:(id)sender
{
    [txtPOPEmail resignFirstResponder];
    [mainBg removeFromSuperview];
}
-(void)pressSubmitForm:(UIButton *)sender
{
    if ([txtPOPEmail.text isEqualToString:@""])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter email address."
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
    else if ([self validateEmailWithString:txtPOPEmail.text]==NO)
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:nil
                                      message:@"Please enter a valid email address."
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
        [txtfpop1 resignFirstResponder];
        [txtPOPEmail resignFirstResponder];
        [mainBg removeFromSuperview];
        
        [self sendEmailtoserver];
       
        
    }
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void)sendEmailtoserver
{
    strIdentifier=@"5";
    
    NSURL *url = nil;
    NSMutableURLRequest *request = nil;
    NSString *parameter = [NSString stringWithFormat:@"EmailID=%@",txtPOPEmail.text];
    NSData *parameterData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];;
    url = [NSURL URLWithString: @"http://50.57.84.23/PayliteAccounts/Api/PayliteAccount/SendEmail"];
    request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:parameterData];
    [request setHTTPMethod:@"POST"];
    [request addValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection)
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


#pragma mark - Thanks Popup Method
-(void)openThanksPopup
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    
    ctrlThanksPop=[[UIView alloc] initWithFrame:CGRectMake(0,0,screenWidth,screenHeight)];
    ctrlThanksPop.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:ctrlThanksPop];
    
    viewThanksPopOverall=[[UIView alloc] init];
    viewThanksPopOverall.frame=CGRectMake(0,0,ctrlThanksPop.frame.size.width,ctrlThanksPop.frame.size.height);
    viewThanksPopOverall.backgroundColor =[UIColor whiteColor];
    [ctrlThanksPop addSubview:viewThanksPopOverall];
    
    viewThanksPopTop=[[UIView alloc] init];
    viewThanksPopTop.frame=CGRectMake(0,0,ctrlThanksPop.frame.size.width,ctrlThanksPop.frame.size.height/2+50);
    viewThanksPopTop.backgroundColor =[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
    [ctrlThanksPop addSubview:viewThanksPopTop];
    
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            btnThanksBackarrow=[UIButton buttonWithType:UIButtonTypeCustom];
            btnThanksBackarrow.frame=CGRectMake(8,28,24,24);
            [btnThanksBackarrow setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [btnThanksBackarrow addTarget:self action:@selector(btnThanksBackarrowPress:) forControlEvents:UIControlEventTouchUpInside];
            [viewThanksPopTop addSubview:btnThanksBackarrow];
        }
        else if(screenSize.height == 667.0f){
            //6
            btnThanksBackarrow=[UIButton buttonWithType:UIButtonTypeCustom];
            btnThanksBackarrow.frame=CGRectMake(8,28,24,24);
            [btnThanksBackarrow setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [btnThanksBackarrow addTarget:self action:@selector(btnThanksBackarrowPress:) forControlEvents:UIControlEventTouchUpInside];
            [viewThanksPopTop addSubview:btnThanksBackarrow];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            btnThanksBackarrow=[UIButton buttonWithType:UIButtonTypeCustom];
            btnThanksBackarrow.frame=CGRectMake(8,28,24,24);
            [btnThanksBackarrow setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [btnThanksBackarrow addTarget:self action:@selector(btnThanksBackarrowPress:) forControlEvents:UIControlEventTouchUpInside];
            [viewThanksPopTop addSubview:btnThanksBackarrow];
        }
        else if(screenSize.height == 812.0f){
            //X
            btnThanksBackarrow=[UIButton buttonWithType:UIButtonTypeCustom];
            btnThanksBackarrow.frame=CGRectMake(8,34,24,24);
            [btnThanksBackarrow setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [btnThanksBackarrow addTarget:self action:@selector(btnThanksBackarrowPress:) forControlEvents:UIControlEventTouchUpInside];
            [viewThanksPopTop addSubview:btnThanksBackarrow];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            btnThanksBackarrow=[UIButton buttonWithType:UIButtonTypeCustom];
            btnThanksBackarrow.frame=CGRectMake(8,34,24,24);
            [btnThanksBackarrow setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [btnThanksBackarrow addTarget:self action:@selector(btnThanksBackarrowPress:) forControlEvents:UIControlEventTouchUpInside];
            [viewThanksPopTop addSubview:btnThanksBackarrow];
        }
        else
        {
            btnThanksBackarrow=[UIButton buttonWithType:UIButtonTypeCustom];
            btnThanksBackarrow.frame=CGRectMake(8,28,24,24);
            [btnThanksBackarrow setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [btnThanksBackarrow addTarget:self action:@selector(btnThanksBackarrowPress:) forControlEvents:UIControlEventTouchUpInside];
            [viewThanksPopTop addSubview:btnThanksBackarrow];
        }
    }
    
    UILabel *lbl1=[[UILabel alloc] init];
    lbl1.textAlignment=NSTextAlignmentCenter;
    lbl1.textColor=[UIColor whiteColor];
    lbl1.backgroundColor=[UIColor clearColor];
    lbl1.text=@"Thank you for your enquiry.";
    [viewThanksPopTop addSubview:lbl1];
    
    UILabel *lbl2=[[UILabel alloc] init];
    lbl2.textAlignment=NSTextAlignmentCenter;
    lbl2.textColor=[UIColor whiteColor];
    lbl2.numberOfLines=1;
    lbl2.backgroundColor=[UIColor clearColor];
    lbl2.text=@"If you are already subscribed with Paylite HR mobile";
    [viewThanksPopTop addSubview:lbl2];
    
    UILabel *lbl5=[[UILabel alloc] init];
    lbl5.textAlignment=NSTextAlignmentCenter;
    lbl5.textColor=[UIColor whiteColor];
    lbl5.numberOfLines=1;
    lbl5.backgroundColor=[UIColor clearColor];
    lbl5.text=@"app, we will get back to you with your account number.";
    [viewThanksPopTop addSubview:lbl5];
    
    UILabel *lbl3=[[UILabel alloc] init];
    lbl3.textAlignment=NSTextAlignmentCenter;
    lbl3.textColor=[UIColor whiteColor];
    lbl3.numberOfLines=1;
    lbl3.backgroundColor=[UIColor clearColor];
    lbl3.text=@"Till then you can try with the demo login";
    [viewThanksPopTop addSubview:lbl3];
    
    UILabel *lbl4=[[UILabel alloc] init];
    lbl4.textAlignment=NSTextAlignmentCenter;
    lbl4.textColor=[UIColor whiteColor];
    lbl4.numberOfLines=1;
    lbl4.backgroundColor=[UIColor clearColor];
    lbl4.text=@"which has been sent to your email address.";
    [viewThanksPopTop addSubview:lbl4];
    
    //---------------
    btnWebsite=[UIButton buttonWithType:UIButtonTypeCustom];
    btnWebsite.frame=CGRectMake(0,CGRectGetMaxY(viewThanksPopTop.frame)+20,viewThanksPopTop.frame.size.width,30);
    [btnWebsite addTarget:self action:@selector(pressWebsitelink:) forControlEvents:UIControlEventTouchUpInside];
    [btnWebsite setBackgroundColor:[UIColor clearColor]];
    [btnWebsite setTitle:@"www.paylitehr.com" forState:UIControlStateNormal];
    [btnWebsite setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [viewThanksPopOverall addSubview:btnWebsite];
    
    //---------------
    btnFacebook=[UIButton buttonWithType:UIButtonTypeCustom];
    btnFacebook.frame=CGRectMake(CGRectGetMidX(btnWebsite.frame)-50,CGRectGetMaxY(btnWebsite.frame)+20,24,24);
    [btnFacebook setBackgroundImage:[UIImage imageNamed:@"facebook"] forState:UIControlStateNormal];
    [btnFacebook addTarget:self action:@selector(facebookPress:) forControlEvents:UIControlEventTouchUpInside];
    [viewThanksPopOverall addSubview:btnFacebook];
    
    btnTwitter=[UIButton buttonWithType:UIButtonTypeCustom];
    btnTwitter.frame=CGRectMake(CGRectGetMaxX(btnFacebook.frame)+12,CGRectGetMaxY(btnWebsite.frame)+20,24,24);
    [btnTwitter setBackgroundImage:[UIImage imageNamed:@"twitter"] forState:UIControlStateNormal];
    [btnTwitter addTarget:self action:@selector(twitterPress:) forControlEvents:UIControlEventTouchUpInside];
    [viewThanksPopOverall addSubview:btnTwitter];
    
    btnLinkedIn=[UIButton buttonWithType:UIButtonTypeCustom];
    btnLinkedIn.frame=CGRectMake(CGRectGetMaxX(btnTwitter.frame)+12,CGRectGetMaxY(btnWebsite.frame)+20,24,24);
    [btnLinkedIn setBackgroundImage:[UIImage imageNamed:@"linkdin"] forState:UIControlStateNormal];
    [btnLinkedIn addTarget:self action:@selector(linkedinPress:) forControlEvents:UIControlEventTouchUpInside];
    [viewThanksPopOverall addSubview:btnLinkedIn];
    
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            
            [lbl1 setFrame:CGRectMake(0,100,viewThanksPopTop.frame.size.width,30)];
            [lbl2 setFrame:CGRectMake(0,CGRectGetMaxY(lbl1.frame)+30,viewThanksPopTop.frame.size.width,30)];
            [lbl5 setFrame:CGRectMake(0,CGRectGetMaxY(lbl2.frame)-15,viewThanksPopTop.frame.size.width,40)];
            [lbl3 setFrame:CGRectMake(0,CGRectGetMaxY(lbl5.frame)+2,viewThanksPopTop.frame.size.width,40)];
            [lbl4 setFrame:CGRectMake(0,CGRectGetMaxY(lbl3.frame)-20,viewThanksPopTop.frame.size.width,40)];
            
            lbl1.font=[UIFont fontWithName:@"GothamBook" size:17.0];
            lbl2.font=[UIFont fontWithName:@"GothamBook" size:12.0];
            lbl5.font=[UIFont fontWithName:@"GothamBook" size:12.0];
            lbl3.font=[UIFont fontWithName:@"GothamBook" size:12.0];
            lbl4.font=[UIFont fontWithName:@"GothamBook" size:12.0];
            
            btnWebsite.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:15.0];
        }
        else if(screenSize.height == 667.0f){
            //6
            
            [lbl1 setFrame:CGRectMake(0,120,viewThanksPopTop.frame.size.width,30)];
            [lbl2 setFrame:CGRectMake(0,CGRectGetMaxY(lbl1.frame)+30,viewThanksPopTop.frame.size.width,30)];
            [lbl5 setFrame:CGRectMake(0,CGRectGetMaxY(lbl2.frame)-15,viewThanksPopTop.frame.size.width,40)];
            [lbl3 setFrame:CGRectMake(0,CGRectGetMaxY(lbl5.frame)+2,viewThanksPopTop.frame.size.width,40)];
            [lbl4 setFrame:CGRectMake(0,CGRectGetMaxY(lbl3.frame)-20,viewThanksPopTop.frame.size.width,40)];
            
            lbl1.font=[UIFont fontWithName:@"GothamBook" size:21.0];
            lbl2.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl5.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl3.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl4.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            
            btnWebsite.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:17.0];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            
            [lbl1 setFrame:CGRectMake(0,200,viewThanksPopTop.frame.size.width,30)];
            [lbl2 setFrame:CGRectMake(0,CGRectGetMaxY(lbl1.frame)+30,viewThanksPopTop.frame.size.width,30)];
            [lbl5 setFrame:CGRectMake(0,CGRectGetMaxY(lbl2.frame)-15,viewThanksPopTop.frame.size.width,40)];
            [lbl3 setFrame:CGRectMake(0,CGRectGetMaxY(lbl5.frame)+2,viewThanksPopTop.frame.size.width,40)];
            [lbl4 setFrame:CGRectMake(0,CGRectGetMaxY(lbl3.frame)-20,viewThanksPopTop.frame.size.width,40)];
            
            lbl1.font=[UIFont fontWithName:@"GothamBook" size:21.0];
            lbl2.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl5.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl3.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl4.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            
            btnWebsite.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:17.0];
        }
        else if(screenSize.height == 812.0f){
            //X
            [lbl1 setFrame:CGRectMake(0,240,viewThanksPopTop.frame.size.width,30)];
            [lbl2 setFrame:CGRectMake(0,CGRectGetMaxY(lbl1.frame)+30,viewThanksPopTop.frame.size.width,30)];
            [lbl5 setFrame:CGRectMake(0,CGRectGetMaxY(lbl2.frame)-15,viewThanksPopTop.frame.size.width,40)];
            [lbl3 setFrame:CGRectMake(0,CGRectGetMaxY(lbl5.frame)+2,viewThanksPopTop.frame.size.width,40)];
            [lbl4 setFrame:CGRectMake(0,CGRectGetMaxY(lbl3.frame)-20,viewThanksPopTop.frame.size.width,40)];
            
            lbl1.font=[UIFont fontWithName:@"GothamBook" size:21.0];
            lbl2.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl5.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl3.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl4.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            
            btnWebsite.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:17.0];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            [lbl1 setFrame:CGRectMake(0,240,viewThanksPopTop.frame.size.width,30)];
            [lbl2 setFrame:CGRectMake(0,CGRectGetMaxY(lbl1.frame)+30,viewThanksPopTop.frame.size.width,30)];
            [lbl5 setFrame:CGRectMake(0,CGRectGetMaxY(lbl2.frame)-15,viewThanksPopTop.frame.size.width,40)];
            [lbl3 setFrame:CGRectMake(0,CGRectGetMaxY(lbl5.frame)+2,viewThanksPopTop.frame.size.width,40)];
            [lbl4 setFrame:CGRectMake(0,CGRectGetMaxY(lbl3.frame)-20,viewThanksPopTop.frame.size.width,40)];
            
            lbl1.font=[UIFont fontWithName:@"GothamBook" size:21.0];
            lbl2.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl5.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl3.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            lbl4.font=[UIFont fontWithName:@"GothamBook" size:13.0];
            
            btnWebsite.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:17.0];
        }
        else
        {
            [lbl1 setFrame:CGRectMake(0,100,viewThanksPopTop.frame.size.width,20)];
            [lbl2 setFrame:CGRectMake(0,CGRectGetMaxY(lbl1.frame)+10,viewThanksPopTop.frame.size.width,20)];
            [lbl5 setFrame:CGRectMake(0,CGRectGetMaxY(lbl2.frame)-3.5,viewThanksPopTop.frame.size.width,20)];
            [lbl3 setFrame:CGRectMake(0,CGRectGetMaxY(lbl5.frame)+1,viewThanksPopTop.frame.size.width,20)];
            [lbl4 setFrame:CGRectMake(0,CGRectGetMaxY(lbl3.frame)-2,viewThanksPopTop.frame.size.width,20)];
            
            lbl1.font=[UIFont fontWithName:@"GothamBold" size:16.0];
            lbl2.font=[UIFont fontWithName:@"GothamBook" size:12.0];
            lbl5.font=[UIFont fontWithName:@"GothamBook" size:12.0];
            lbl3.font=[UIFont fontWithName:@"GothamBook" size:12.0];
            lbl4.font=[UIFont fontWithName:@"GothamBook" size:12.0];
            
            btnWebsite.titleLabel.font=[UIFont fontWithName:@"GothamBook" size:15.0];
        }
    }
}


-(void)btnThanksBackarrowPress:(id)sender{
    [ctrlThanksPop removeFromSuperview];
}
-(void)pressWebsitelink:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.paylitehr.com/"] options:@{} completionHandler:nil];
}
-(void)facebookPress:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/Paylite"] options:@{} completionHandler:nil];
}
-(void)linkedinPress:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.linkedin.com/company/855148"] options:@{} completionHandler:nil];
}
-(void)twitterPress:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/paylite"] options:@{} completionHandler:nil];
}

#pragma mark - Reset Account Number Method
- (IBAction)pressResetAccNumber:(id)sender
{
    
    if (isKeyBoardAnimated==YES)
    {
        isKeyBoardAnimated=NO;
        
        [_imgvBanner setFrame:CGRectMake(_imgvBanner.frame.origin.x,_imgvBanner.frame.origin.y,_imgvBanner.frame.size.width,_imgvBanner.frame.size.height*2)];
        [_imgvBanner setImage:[UIImage imageNamed:@"loginbanner11.png"]];
        
        [_viewbglog setFrame:CGRectMake(_viewbglog.frame.origin.x,_viewbglog.frame.origin.y+100,_viewbglog.frame.size.width,_viewbglog.frame.size.height)];
        
        [_txtUsername resignFirstResponder];
        [_txtPassword resignFirstResponder];
    }
    
    [self ResetPopMethod];
}
-(void)ResetPopMethod
{
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    
    ctrlPopReset=[[UIControl alloc] initWithFrame:CGRectMake(0,screenHeight,screenWidth,screenHeight)];
    ctrlPopReset.alpha=1.0;
    ctrlPopReset.backgroundColor=[UIColor whiteColor];
    
    viewPopReset=[[UIView alloc] init];
    viewPopReset.frame=CGRectMake(0,0,ctrlPopReset.frame.size.width,ctrlPopReset.frame.size.height);
    viewPopReset.backgroundColor =[UIColor whiteColor];
    [ctrlPopReset addSubview:viewPopReset];
    
    UIView *bgVwHeader;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,viewPopReset.frame.size.width,64)];
            bgVwHeader.backgroundColor =[UIColor whiteColor];
            bgVwHeader.layer.shadowRadius = 3.0f;
            bgVwHeader.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            bgVwHeader.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
            bgVwHeader.layer.shadowOpacity = 0.5f;
            bgVwHeader.layer.masksToBounds = NO;
            [viewPopReset addSubview:bgVwHeader];
            
            btnBackAccReset=[UIButton buttonWithType:UIButtonTypeCustom];
            btnBackAccReset.frame=CGRectMake(8,30,20,20);
            [btnBackAccReset setBackgroundImage:[UIImage imageNamed:@"crossB"] forState:UIControlStateNormal];
            [btnBackAccReset addTarget:self action:@selector(btnBackAccResetPress:) forControlEvents:UIControlEventTouchUpInside];
            [bgVwHeader addSubview:btnBackAccReset];
            
            UILabel *lblHeadline=[[UILabel alloc] initWithFrame:CGRectMake(0,0,bgVwHeader.frame.size.width,bgVwHeader.frame.size.height)];
            lblHeadline.text=@"Reset Account Number";
            lblHeadline.textAlignment=NSTextAlignmentCenter;
            lblHeadline.textColor=[UIColor darkGrayColor];
            lblHeadline.font=[UIFont fontWithName:@"GothamBook" size:17];
            lblHeadline.backgroundColor=[UIColor clearColor];
            [bgVwHeader addSubview:lblHeadline];
        }
        else if(screenSize.height == 667.0f){
            //6
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,viewPopReset.frame.size.width,64)];
            bgVwHeader.backgroundColor =[UIColor whiteColor];
            bgVwHeader.layer.shadowRadius = 3.0f;
            bgVwHeader.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            bgVwHeader.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
            bgVwHeader.layer.shadowOpacity = 0.5f;
            bgVwHeader.layer.masksToBounds = NO;
            [viewPopReset addSubview:bgVwHeader];
            
            btnBackAccReset=[UIButton buttonWithType:UIButtonTypeCustom];
            btnBackAccReset.frame=CGRectMake(8,30,20,20);
            [btnBackAccReset setBackgroundImage:[UIImage imageNamed:@"crossB"] forState:UIControlStateNormal];
            [btnBackAccReset addTarget:self action:@selector(btnBackAccResetPress:) forControlEvents:UIControlEventTouchUpInside];
            [bgVwHeader addSubview:btnBackAccReset];
            
            UILabel *lblHeadline=[[UILabel alloc] initWithFrame:CGRectMake(0,0,bgVwHeader.frame.size.width,bgVwHeader.frame.size.height)];
            lblHeadline.text=@"Reset Account Number";
            lblHeadline.textAlignment=NSTextAlignmentCenter;
            lblHeadline.textColor=[UIColor darkGrayColor];
            lblHeadline.font=[UIFont fontWithName:@"GothamBook" size:17];
            lblHeadline.backgroundColor=[UIColor clearColor];
            [bgVwHeader addSubview:lblHeadline];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,viewPopReset.frame.size.width,64)];
            bgVwHeader.backgroundColor =[UIColor whiteColor];
            bgVwHeader.layer.shadowRadius = 3.0f;
            bgVwHeader.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            bgVwHeader.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
            bgVwHeader.layer.shadowOpacity = 0.5f;
            bgVwHeader.layer.masksToBounds = NO;
            [viewPopReset addSubview:bgVwHeader];
            
            btnBackAccReset=[UIButton buttonWithType:UIButtonTypeCustom];
            btnBackAccReset.frame=CGRectMake(8,26,28,28);
            [btnBackAccReset setBackgroundImage:[UIImage imageNamed:@"crossB"] forState:UIControlStateNormal];
            [btnBackAccReset addTarget:self action:@selector(btnBackAccResetPress:) forControlEvents:UIControlEventTouchUpInside];
            [bgVwHeader addSubview:btnBackAccReset];
            
            UILabel *lblHeadline=[[UILabel alloc] initWithFrame:CGRectMake(0,26,bgVwHeader.frame.size.width,35)];
            lblHeadline.text=@"Reset Account Number";
            lblHeadline.textAlignment=NSTextAlignmentCenter;
            lblHeadline.textColor=[UIColor darkGrayColor];
            lblHeadline.font=[UIFont fontWithName:@"GothamBook" size:17];
            lblHeadline.backgroundColor=[UIColor clearColor];
            [bgVwHeader addSubview:lblHeadline];
        }
        else if(screenSize.height == 812.0f){
            //X
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,viewPopReset.frame.size.width,84)];
            bgVwHeader.backgroundColor =[UIColor whiteColor];
            bgVwHeader.layer.shadowRadius = 3.0f;
            bgVwHeader.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            bgVwHeader.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
            bgVwHeader.layer.shadowOpacity = 0.5f;
            bgVwHeader.layer.masksToBounds = NO;
            [viewPopReset addSubview:bgVwHeader];
            
            btnBackAccReset=[UIButton buttonWithType:UIButtonTypeCustom];
            btnBackAccReset.frame=CGRectMake(8,46,24,24);
            [btnBackAccReset setBackgroundImage:[UIImage imageNamed:@"crossB"] forState:UIControlStateNormal];
            [btnBackAccReset addTarget:self action:@selector(btnBackAccResetPress:) forControlEvents:UIControlEventTouchUpInside];
            [bgVwHeader addSubview:btnBackAccReset];
            
            UILabel *lblHeadline=[[UILabel alloc] initWithFrame:CGRectMake(0,50,bgVwHeader.frame.size.width,20)];
            lblHeadline.text=@"Reset Account Number";
            lblHeadline.textAlignment=NSTextAlignmentCenter;
            lblHeadline.textColor=[UIColor darkGrayColor];
            lblHeadline.font=[UIFont fontWithName:@"GothamBook" size:17];
            lblHeadline.backgroundColor=[UIColor clearColor];
            [bgVwHeader addSubview:lblHeadline];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,viewPopReset.frame.size.width,84)];
            bgVwHeader.backgroundColor =[UIColor whiteColor];
            bgVwHeader.layer.shadowRadius = 3.0f;
            bgVwHeader.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            bgVwHeader.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
            bgVwHeader.layer.shadowOpacity = 0.5f;
            bgVwHeader.layer.masksToBounds = NO;
            [viewPopReset addSubview:bgVwHeader];
            
            btnBackAccReset=[UIButton buttonWithType:UIButtonTypeCustom];
            btnBackAccReset.frame=CGRectMake(8,46,24,24);
            [btnBackAccReset setBackgroundImage:[UIImage imageNamed:@"crossB"] forState:UIControlStateNormal];
            [btnBackAccReset addTarget:self action:@selector(btnBackAccResetPress:) forControlEvents:UIControlEventTouchUpInside];
            [bgVwHeader addSubview:btnBackAccReset];
            
            UILabel *lblHeadline=[[UILabel alloc] initWithFrame:CGRectMake(0,50,bgVwHeader.frame.size.width,20)];
            lblHeadline.text=@"Reset Account Number";
            lblHeadline.textAlignment=NSTextAlignmentCenter;
            lblHeadline.textColor=[UIColor darkGrayColor];
            lblHeadline.font=[UIFont fontWithName:@"GothamBook" size:17];
            lblHeadline.backgroundColor=[UIColor clearColor];
            [bgVwHeader addSubview:lblHeadline];
        }
        else
        {
            bgVwHeader = [[UIView alloc] initWithFrame:CGRectMake(0,0,viewPopReset.frame.size.width,64)];
            bgVwHeader.backgroundColor =[UIColor whiteColor];
            bgVwHeader.layer.shadowRadius = 3.0f;
            bgVwHeader.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            bgVwHeader.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
            bgVwHeader.layer.shadowOpacity = 0.5f;
            bgVwHeader.layer.masksToBounds = NO;
            [viewPopReset addSubview:bgVwHeader];
            
            btnBackAccReset=[UIButton buttonWithType:UIButtonTypeCustom];
            btnBackAccReset.frame=CGRectMake(8,30,20,20);
            [btnBackAccReset setBackgroundImage:[UIImage imageNamed:@"crossB"] forState:UIControlStateNormal];
            [btnBackAccReset addTarget:self action:@selector(btnBackAccResetPress:) forControlEvents:UIControlEventTouchUpInside];
            [bgVwHeader addSubview:btnBackAccReset];
            
            UILabel *lblHeadline=[[UILabel alloc] initWithFrame:CGRectMake(0,0,bgVwHeader.frame.size.width,bgVwHeader.frame.size.height)];
            lblHeadline.text=@"Reset Account Number";
            lblHeadline.textAlignment=NSTextAlignmentCenter;
            lblHeadline.textColor=[UIColor darkGrayColor];
            lblHeadline.font=[UIFont fontWithName:@"GothamBook" size:17];
            lblHeadline.backgroundColor=[UIColor clearColor];
            [bgVwHeader addSubview:lblHeadline];
        }
    }
    
    
    
    txtfpop1Reset=[[UITextField alloc] init];
    [txtfpop1Reset setFrame:CGRectMake(30,CGRectGetMidY(viewPopReset.frame)-40,viewPopReset.frame.size.width-60,44)];
    txtfpop1Reset.textColor=[UIColor darkGrayColor];
    [txtfpop1Reset setBorderStyle:UITextBorderStyleNone];
    txtfpop1Reset.textAlignment=NSTextAlignmentCenter;
    txtfpop1Reset.backgroundColor=[UIColor whiteColor];
    txtfpop1Reset.delegate=self;
    txtfpop1Reset.placeholder=@"Account Number";
    txtfpop1Reset.keyboardType=UIKeyboardTypeNumberPad;
    txtfpop1Reset.font=[UIFont fontWithName:@"GothamBook" size:14.0];
    [txtfpop1Reset becomeFirstResponder];
    [txtfpop1Reset addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [viewPopReset addSubview:txtfpop1Reset];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 0.5;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, txtfpop1Reset.frame.size.height - borderWidth, txtfpop1Reset.frame.size.width, txtfpop1Reset.frame.size.height);
    border.borderWidth = borderWidth;
    [txtfpop1Reset.layer addSublayer:border];
    txtfpop1Reset.layer.masksToBounds = YES;
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [ctrlPopReset setFrame:CGRectMake(0,0,screenWidth,screenHeight)];
                     }
                     completion:nil];
    
    [self.view addSubview:ctrlPopReset];
}
-(void)btnBackAccResetPress:(id)sender
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [ctrlPopReset setFrame:CGRectMake(0,screenHeight,screenWidth,screenHeight)];
                     }
                     completion:^(BOOL completed){
                        [ctrlPopReset removeFromSuperview];
                     }];
    
    
    NSLog(@"%f",_imgvBanner.frame.origin.x);
    NSLog(@"%f",_imgvBanner.frame.origin.y);
    NSLog(@"%f",_imgvBanner.frame.size.width);
    NSLog(@"%f",_imgvBanner.frame.size.height);
    
    NSLog(@"%f",_viewbglog.frame.origin.x);
    NSLog(@"%f",_viewbglog.frame.origin.y);
    NSLog(@"%f",_viewbglog.frame.size.width);
    NSLog(@"%f",_viewbglog.frame.size.height);
}




#pragma mark - UITextField Delegate Method
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"isKeyBoardAnimated %d",isKeyBoardAnimated);
    
    if (textField == txtfpop1 || textField ==txtPOPEmail || textField==txtfpop1Reset) {
        
    }
    else
    {
        if (isKeyBoardAnimated==YES)
        {
            NSLog(@"username or pasword will not up again");
        }
        else
        {
            NSLog(@"username or pasword will up");
            
            isKeyBoardAnimated=YES;
            [_imgvBanner setFrame:CGRectMake(_imgvBanner.frame.origin.x,0,_imgvBanner.frame.size.width,_imgvBanner.frame.size.height/2)];
            [_imgvBanner setImage:[UIImage imageNamed:@"loginbanner22.png"]];
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.25];
            [_viewbglog setFrame:CGRectMake(_viewbglog.frame.origin.x,_viewbglog.frame.origin.y-100,_viewbglog.frame.size.width,_viewbglog.frame.size.height)];
            [UIView commitAnimations];
        }
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"isKeyBoardAnimated %d",isKeyBoardAnimated);
    
    if (textField==_txtUsername)
    {
        [_txtPassword becomeFirstResponder];
    }
    if (textField==_txtPassword)
    {
        isKeyBoardAnimated=NO;
        
        [_imgvBanner setFrame:CGRectMake(_imgvBanner.frame.origin.x,_imgvBanner.frame.origin.y,_imgvBanner.frame.size.width,_imgvBanner.frame.size.height*2)];
        [_imgvBanner setImage:[UIImage imageNamed:@"loginbanner11.png"]];
        
        [_viewbglog setFrame:CGRectMake(_viewbglog.frame.origin.x,_viewbglog.frame.origin.y+100,_viewbglog.frame.size.width,_viewbglog.frame.size.height)];
        
        [_txtPassword resignFirstResponder];
    }
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==txtfpop1)
    {
        NSString *textstring = [txtfpop1.text stringByReplacingCharactersInRange:range withString:string];
        NSInteger length = [textstring length];
        
        if (length > 5)
        {
            return NO;
        }
    }
    else if (textField==txtfpop1Reset)
    {
        NSString *textstring = [txtfpop1Reset.text stringByReplacingCharactersInRange:range withString:string];
        NSInteger length = [textstring length];
        
        if (length > 5)
        {
            return NO;
        }
    }
    else{
        return YES;
    }
    
    return YES;
}
-(void)textFieldDidChange :(UITextField *)theTextField
{
    if (theTextField==txtfpop1)
    {
        NSLog( @"text changed: %@", theTextField.text);
        NSUInteger characterCount = [theTextField.text length];
        NSLog(@"characterCount :%ld",(unsigned long)characterCount);
        
        if (characterCount > 5){
            NSLog(@"txtfpop1.text :%@",theTextField.text);
        }
        else if (characterCount < 5){
            NSLog(@"txtfpop1.text :%@",theTextField.text);
        }
        else if (characterCount ==5){
            NSLog(@"txtfpop1.text :%@",theTextField.text);
            [self fetchConnectionStringAccountNumber:txtfpop1.text iddntf:@"4"];
        }
    }
    else if (theTextField==txtfpop1Reset)
    {
        NSLog( @"text changed: %@", theTextField.text);
        NSUInteger characterCount = [theTextField.text length];
        NSLog(@"characterCount :%ld",(unsigned long)characterCount);
        
        if (characterCount > 5){
            NSLog(@"txtfpop1.text :%@",theTextField.text);
        }
        else if (characterCount < 5){
            NSLog(@"txtfpop1.text :%@",theTextField.text);
        }
        else if (characterCount ==5){
            NSLog(@"txtfpop1.text :%@",theTextField.text);
            [self fetchConnectionStringAccountNumber:txtfpop1Reset.text iddntf:@"6"];
        }
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([txtfpop1 becomeFirstResponder]==YES || [txtfpop1Reset becomeFirstResponder]==YES)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
        }];
        return [super canPerformAction:action withSender:sender];
    }
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - Keyboard Dismiss on Touch Screen Method
-(void)dismissKeyboard
{
    if (isKeyBoardAnimated==YES)
    {
        isKeyBoardAnimated=NO;
        
        [_imgvBanner setFrame:CGRectMake(_imgvBanner.frame.origin.x,_imgvBanner.frame.origin.y,_imgvBanner.frame.size.width,_imgvBanner.frame.size.height*2)];
        [_imgvBanner setImage:[UIImage imageNamed:@"loginbanner11.png"]];
        
        [_viewbglog setFrame:CGRectMake(_viewbglog.frame.origin.x,_viewbglog.frame.origin.y+100,_viewbglog.frame.size.width,_viewbglog.frame.size.height)];
        
        [_txtUsername resignFirstResponder];
        [_txtPassword resignFirstResponder];
    }
}


#pragma mark - Fetch Account Number Service URL Method After App Launch Method
-(void)fetchConnectionStringAccountNumber:(NSString *)strtextacc iddntf:(NSString *)striddnf
{
    strIdentifier=striddnf;
    NSString *post = @"";
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@",@"http://50.57.84.23/PayliteAccounts/Api/PayliteAccount/GetUrl/",strtextacc,@"I"];
    urlString=[urlString stringByRemovingPercentEncoding];
    NSLog(@"PostString=%@",urlString);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSLog(@"%@", [request allHTTPHeaderFields]);
    NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn)
    {
        NSLog(@"Connected");
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        self.view.userInteractionEnabled=NO;
        [self showLoadingMode];
    }
    else
    {
        ;
    }
}

#pragma mark - Press Login Method
- (IBAction)pressLogin:(id)sender
{
    if (isKeyBoardAnimated==YES)
    {
        isKeyBoardAnimated=NO;
        
        [_imgvBanner setFrame:CGRectMake(_imgvBanner.frame.origin.x,_imgvBanner.frame.origin.y,_imgvBanner.frame.size.width,_imgvBanner.frame.size.height*2)];
        [_imgvBanner setImage:[UIImage imageNamed:@"loginbanner11.png"]];
        
        [_viewbglog setFrame:CGRectMake(_viewbglog.frame.origin.x,_viewbglog.frame.origin.y+100,_viewbglog.frame.size.width,_viewbglog.frame.size.height)];
        
        [_txtUsername resignFirstResponder];
        [_txtPassword resignFirstResponder];
    }
    
    [self loginprocesMethod];
    
}

-(void)loginprocesMethod
{
    NSString *strtoken =  [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    NSLog(@"deviceToken :%@",strtoken);
    
    if ([_txtUsername.text isEqualToString:@""])
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
    else if ([_txtPassword.text isEqualToString:@""])
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
    else
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
                                 "<UserLogin xmlns=\"http://tempuri.org/\"><sUID>%@</sUID><sPwd>%@</sPwd>"
                                 "</UserLogin> \n"
                                 "</SOAP-ENV:Body> \n"
                                 "</SOAP-ENV:Envelope>",_txtUsername.text,_txtPassword.text];
        
        
        NSLog(@"soapMessage %@",soapMessage);
        NSURL *url = [NSURL URLWithString:strConUrl];
        //NSURL *url = [NSURL URLWithString:app.strURL];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"http://tempuri.org/ISelfService/UserLogin" forHTTPHeaderField:@"SOAPAction"];
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        //NSLog(@"contentlength=%@",msgLength);
        NSLog(@"theRequest=%@",theRequest);
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
}

#pragma mark - Fetch Company Details Method
-(void)fetchCompanyDetail:(NSString *)strUsernamelogin
{
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
                             "<GetUserCompany xmlns=\"http://tempuri.org/\"><sUID>%@</sUID>"
                             "</GetUserCompany> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",strUsernamelogin];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSLog(@"soapMessage %@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d",(int)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/GetUserCompany" forHTTPHeaderField:@"SOAPAction"];
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

#pragma mark - Fetch User Type Method
-(void)fetchuserinfo:(NSString *)strCompanyIDD empid:(NSString *)strEmployeeIDD
{
    NSString *strDeviceID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]];
    NSLog(@"Device Token %@",strDeviceID);
    
    strIdentifier=@"3";
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
                             "</SOAP-ENV:Envelope>",strCompanyIDD,strEmployeeIDD,strDeviceID,@"I"];
    
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
    NSLog(@"Response::::::>>> %@",data_Response);
    
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
        //NSLog(@"element value---%@",elementName);
        if ([elementName isEqualToString:@"mytable"])
        {
            NSLog(@"root is called..");
        }
        if ([elementName isEqualToString:@"UserType"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"EmployeeID"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"EmployeeName"])
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
        if ([elementName isEqualToString:@"Department"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Designation"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"DateOfJoin"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"EmployeeCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"UserImage"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if([strIdentifier isEqualToString:@"2"])
    {
        if ([elementName isEqualToString:@"GetUserCompanyResult"])
        {
            arrMcompdtls=[[NSMutableArray alloc] init];
        }
        if ([elementName isEqualToString:@"mytable"])
        {
            NSLog(@"root is called..");
            objcompdtls=[[objCompanydetails alloc]init];
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"CompanyID"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"CompanyName"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"CurrencySymbol"])
        {
            currentElementValue=[NSMutableString string];
        }
        
       
    }
    else if ([strIdentifier isEqualToString:@"3"])
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
    else if([strIdentifier isEqualToString:@"4"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Url"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Logo"])
        {
            currentElementValue=[NSMutableString string];
        }
    }
    else if([strIdentifier isEqualToString:@"5"])
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
    else if([strIdentifier isEqualToString:@"6"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Url"])
        {
            currentElementValue=[NSMutableString string];
        }
        if ([elementName isEqualToString:@"Logo"])
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
        if ([elementName isEqualToString:@"UserType"])
        {
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"EmployeeID"])
        {
            strEmployeeID=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"EmployeeName"])
        {
            strEmployeeName=currentElementValue ;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strMessageCode=currentElementValue;
            if([strMessageCode integerValue]==0)
            {
                NSLog(@"valid user");
                strPassword=_txtPassword.text;
                strUsername=_txtUsername.text ;
            }
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strMessageText=currentElementValue ;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Department"])
        {
            strDepartment=currentElementValue ;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Designation"])
        {
            strDesignation=currentElementValue ;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"DateOfJoin"])
        {
            strDateOfJoin=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"EmployeeCode"])
        {
            strEmployeeCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"UserImage"])
        {
            strImage=currentElementValue;
            currentElementValue=nil;
        }
    }
    else if([strIdentifier isEqualToString:@"2"])
    {
        
        if ([elementName isEqualToString:@"mytable"])
        {
            NSLog(@"mytable is called..");
            [arrMcompdtls addObject:objcompdtls];
        }
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strMessageCodeComapny=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strMessageTextComapny=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"CompanyID"])
        {
            objcompdtls.strCompanyID=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"CompanyName"])
        {
            objcompdtls.strCompanyName=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"CurrencySymbol"])
        {
            objcompdtls.strCurrencySymbol=currentElementValue;
            currentElementValue=nil;
        }
        
    }
    else if ([strIdentifier isEqualToString:@"3"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            struserinfoMessagecode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            struserinfoMessagetext=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"IsManager"])
        {
            struserinfoisManager=currentElementValue ;
            currentElementValue=nil;
        }//
        if ([elementName isEqualToString:@"IsHr"])
        {
            struserinfoisHR=currentElementValue ;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"GeoLocation"])
        {
            struserinfoisGeoLocation=currentElementValue ;
            currentElementValue=nil;
        }
    }
    else if([strIdentifier isEqualToString:@"4"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strFetchAccMessacode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strFetchAccMessatext=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Url"])
        {
            strFetchAccUrl=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Logo"])
        {
            strFetchAccPName=currentElementValue;
            currentElementValue=nil;
        }
    }
    else if([strIdentifier isEqualToString:@"5"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strFetchEmailPOPMessageCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strFetchEmailPOPMessageText=currentElementValue;
            currentElementValue=nil;
        }
    }
    else if([strIdentifier isEqualToString:@"6"])
    {
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strFetchAccMessacodeRR=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strFetchAccMessatextRR=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Url"])
        {
            strFetchAccUrlRR=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"Logo"])
        {
            strFetchAccPNameRR=currentElementValue;
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
            
            [[NSUserDefaults standardUserDefaults]setValue:_txtUsername.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults]setValue:_txtPassword.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"rememberme"];
            
            [app1.dicUserDetails setObject:strEmployeeID forKey:@"EmployeeID"];
            [app1.dicUserDetails setObject:strEmployeeName forKey:@"EmployeeName"];
            [app1.dicUserDetails setObject:strDepartment forKey:@"Department"];
            [app1.dicUserDetails setObject:strDesignation forKey:@"Designation"];
            [app1.dicUserDetails setObject:strDateOfJoin forKey:@"DateOfJoin"];
            [app1.dicUserDetails setObject:strEmployeeCode forKey:@"EmployeeCode"];
            [app1.dicUserDetails setObject:strUsername forKey:@"Username"];
            [app1.dicUserDetails setObject:strPassword forKey:@"Password"];
            
            NSLog(@"UserImage url--%@",strImage);
            [app1.dicUserDetails setObject:strImage forKey:@"Userimage"];
            
            [[NSUserDefaults standardUserDefaults] setObject:app1.dicUserDetails forKey:@"dicUserDetails"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self fetchCompanyDetail:strUsername];
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Please enter valid login details."
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
        NSLog(@"strMessageCodeComapny:%@",strMessageCodeComapny);
        int code=[strMessageCodeComapny intValue];
        if (code==0)
        {
            if ([arrMcompdtls count]==1)
            {
                //Set company details directly
                NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
                objCompanydetails *objhgh=[arrMcompdtls objectAtIndex:0];
                NSLog(@"strCompanyID :%@",objhgh.strCompanyID);
                NSLog(@"strCompanyName :%@",objhgh.strCompanyName);
                NSLog(@"strCurrencySymbol :%@",objhgh.strCurrencySymbol);
                
                [self fetchuserinfo:objhgh.strCompanyID empid:[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]]];
            }
            else{
                //Redirect to Company selection screen
                [self gotoCompanySelectionPage];
            }
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"User does not exit in selected company."
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
    else if([strIdentifier isEqualToString:@"3"])
    {
        NSLog(@"struserinfoMessagecode:%@",struserinfoMessagecode);
        int code=[struserinfoMessagecode intValue];
        if (code==0)
        {
            NSLog(@"struserinfoisManager :%@",struserinfoisManager);
            NSLog(@"struserinfoisHR :%@",struserinfoisHR);
            NSLog(@"struserinfoisGeoLocation :%@",struserinfoisGeoLocation);
            
            [app1.dicCompanyDetails setObject:objcompdtls.strCompanyID forKey:@"CompanyID"];
            [app1.dicCompanyDetails setObject:objcompdtls.strCompanyName forKey:@"CompanyName"];
            [app1.dicCompanyDetails setObject:objcompdtls.strCurrencySymbol forKey:@"CurrencySymbol"];
            [[NSUserDefaults standardUserDefaults] setObject:app1.dicCompanyDetails forKey:@"dicCompanyDetails"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [app1.dicUserDetails setObject:struserinfoisManager forKey:@"isManager"];
            [app1.dicUserDetails setObject:struserinfoisHR forKey:@"isHR"];
            [app1.dicUserDetails setObject:struserinfoisGeoLocation forKey:@"isGeoLocation"];
            
            if ([struserinfoisGeoLocation isEqualToString:@""]) {
                
            }
            else{
                NSArray *items = [struserinfoisGeoLocation componentsSeparatedByString:@","];
                NSString *str1=[items objectAtIndex:0];
                NSString *str2=[items objectAtIndex:1];
                [app1.dicUserDetails setObject:str1 forKey:@"CompanyLatitude"];
                [app1.dicUserDetails setObject:str2 forKey:@"CompanyLongitude"];
            }
            
            //Dafarpur 22.646599 ,88.246674
            //Jumeriah Lake Tower 25.0693,55.1417
            //pasrkstreet 22.552172,88.349734
            
            [app1.dicUserDetails setObject:objcompdtls.strCompanyID forKey:@"CompanyID"];
            [app1.dicUserDetails setObject:objcompdtls.strCompanyName forKey:@"CompanyName"];
            [app1.dicUserDetails setObject:objcompdtls.strCurrencySymbol forKey:@"CurrencySymbol"];
            
            [[NSUserDefaults standardUserDefaults] setObject:app1.dicUserDetails forKey:@"dicUserDetails"];
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
        NSLog(@"dicCompanyDetails :%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"dicCompanyDetails"]);
        //NSLog(@"dicUserDetails :%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"dicUserDetails"]);
    }
    else if([strIdentifier isEqualToString:@"4"])
    {
        NSLog(@"strFetchAccMessacode:%@",strFetchAccMessacode);
        NSLog(@"strFetchAccMessatext:%@",strFetchAccMessatext);
        
        int code=[strFetchAccMessacode intValue];
        if (code==0)
        {
            NSLog(@"strFetchAccUrl:%@",strFetchAccUrl);
            NSLog(@"strFetchAccPName:%@",strFetchAccPName);
            
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"strFlagforDBFetching"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",txtfpop1.text] forKey:@"strAccountnumber"];
            [[NSUserDefaults standardUserDefaults] setObject:strFetchAccUrl forKey:@"strConnectionurl"];
            [[NSUserDefaults standardUserDefaults] setObject:strFetchAccPName forKey:@"strFetchAccPName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            self.view.frame=CGRectMake(0,0,  UIScreen.mainScreen.bounds.size.width,  self.view.frame.size.height);
            [ctrlPop removeFromSuperview];
            //------ Footer Design in Login Screen ------------
            
            NSString *strImageLink=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strFetchAccPName"]];
            NSURL *Imageurl = [NSURL URLWithString:strImageLink];
            NSLog(@"Imageurl :%@",Imageurl);
             [self downloadImageWithURL:Imageurl completionBlock:^(BOOL succeeded, NSData *data) {
                if (succeeded){
                    _imgvSupported.image= [[UIImage alloc] initWithData:data];
                    [_lblsupported setText:@"Supported by "];
                }
                else{
                    _lblsupported.hidden=YES;
                    _imgvSupported.hidden=YES;
                }
            }];
            //------------------------------------------------
            
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:strFetchAccMessatext
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
    else if([strIdentifier isEqualToString:@"5"])
    {
        NSLog(@"strFetchEmailPOPMessageCode:%@",strFetchEmailPOPMessageCode);
        NSLog(@"strFetchEmailPOPMessageText:%@",strFetchEmailPOPMessageText);
        int code=[strFetchEmailPOPMessageCode intValue];
        if (code==0)
        {
            [mainBg removeFromSuperview];
            [txtPOPEmail resignFirstResponder];
            [txtfpop1 resignFirstResponder];
            [self openThanksPopup];
        }
        else
        {
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:strFetchEmailPOPMessageText
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
    else if([strIdentifier isEqualToString:@"6"])
    {
        NSLog(@"strFetchAccMessacodeRR:%@",strFetchAccMessacodeRR);
        NSLog(@"strFetchAccMessatextRR:%@",strFetchAccMessatextRR);
        
        int code=[strFetchAccMessacodeRR intValue];
        if (code==0)
        {
            NSLog(@"strFetchAccUrlRR:%@",strFetchAccUrlRR);
            NSLog(@"strFetchAccPNameRR:%@",strFetchAccPNameRR);
            
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"strFlagforDBFetching"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",txtfpop1Reset.text] forKey:@"strAccountnumber"];
            [[NSUserDefaults standardUserDefaults] setObject:strFetchAccUrlRR forKey:@"strConnectionurl"];
            [[NSUserDefaults standardUserDefaults] setObject:strFetchAccPNameRR forKey:@"strFetchAccPName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            self.view.frame=CGRectMake(0,0,  UIScreen.mainScreen.bounds.size.width,  self.view.frame.size.height);
            [ctrlPopReset removeFromSuperview];
            
            //------ Footer Design in Login Screen ------------
            NSString *strImageLink=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strFetchAccPName"]];
            NSURL *Imageurl = [NSURL URLWithString:[strImageLink stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
            NSLog(@"Imageurl :%@",Imageurl);
            [self downloadImageWithURL:Imageurl completionBlock:^(BOOL succeeded, NSData *data) {
                if (succeeded){
                    _imgvSupported.image= [[UIImage alloc] initWithData:data];
                    [_lblsupported setText:@"Supported by "];
                }
                else{
                    _lblsupported.hidden=YES;
                    _imgvSupported.hidden=YES;
                }
            }];
            //------------------------------------------------
            
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:strFetchAccMessatextRR
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

#pragma mark - Redirect To Dashboard Method
-(void)gotoDashboardPage
{
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
        [self.navigationController pushViewController:objDemo animated:NO];
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
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                objDemo = [[DashboardMH alloc] initWithNibName:@"DashboardMHXSMAX" bundle:nil];
            }
            else{
                objDemo = [[DashboardMH alloc] initWithNibName:@"DashboardMH" bundle:nil];
            }
        }
        else
        {
        }
        [self.navigationController pushViewController:objDemo animated:NO];
    }
}


#pragma mark - Redirect To Company Selection Method
-(void)gotoCompanySelectionPage
{
    CompanySelection *objDemo;
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            objDemo = [[CompanySelection alloc] initWithNibName:@"CompanySelection5S" bundle:nil];
        }
        else if(screenSize.height == 667.0f){
            //6
            objDemo = [[CompanySelection alloc] initWithNibName:@"CompanySelection6" bundle:nil];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            objDemo = [[CompanySelection alloc] initWithNibName:@"CompanySelection6Plus" bundle:nil];
        }
        else if(screenSize.height == 812.0f){
            //X
            objDemo = [[CompanySelection alloc] initWithNibName:@"CompanySelectionX" bundle:nil];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            objDemo = [[CompanySelection alloc] initWithNibName:@"CompanySelectionXSMAX" bundle:nil];
        }
        else{
            objDemo = [[CompanySelection alloc] initWithNibName:@"CompanySelection" bundle:nil];
        }
    }
    else
    {
    }
    objDemo.arrMCompanylist=arrMcompdtls;
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
