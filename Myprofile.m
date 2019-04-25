//
//  Myprofile.m
//  Paylite HRMS
//
//  Created by Sandipan on 15/06/17.
//  Copyright © 2017 SANDIPAN. All rights reserved.
//

#import "Myprofile.h"

@interface Myprofile ()

@end

@implementation Myprofile

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
    
    _tabvProfile.backgroundView=nil;
    _tabvProfile.backgroundColor=[UIColor clearColor];
    _tabvProfile.separatorColor=[UIColor clearColor];
    _tabvProfile.showsVerticalScrollIndicator=NO;
    [_tabvProfile.layer setMasksToBounds:YES];
    [_tabvProfile.layer setCornerRadius: 4.0];
    [_tabvProfile.layer setBorderWidth:0.0];
    [_tabvProfile.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    [_tabvProfile reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Press Back Method
- (IBAction)pressBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Delegate & DataSource Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            return 100;
        }
        return 44.0;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 6;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            UIImageView *imgvLogo=[[UIImageView alloc] init];
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    [imgvLogo setFrame:CGRectMake(CGRectGetMidX(_tabvProfile.frame)-50,20,60,60)];
                    [imgvLogo.layer setBorderColor: [[UIColor clearColor] CGColor]];
                    [imgvLogo.layer setBorderWidth: 0.0];
                    [imgvLogo.layer setCornerRadius:30.0f];
                    [imgvLogo.layer setMasksToBounds:YES];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    [imgvLogo setFrame:CGRectMake(CGRectGetMidX(_tabvProfile.frame)-50,10,80,80)];
                    [imgvLogo.layer setBorderColor: [[UIColor clearColor] CGColor]];
                    [imgvLogo.layer setBorderWidth: 0.0];
                    [imgvLogo.layer setCornerRadius:40.0f];
                    [imgvLogo.layer setMasksToBounds:YES];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    [imgvLogo setFrame:CGRectMake(CGRectGetMidX(_tabvProfile.frame)-50,10,80,80)];
                    [imgvLogo.layer setBorderColor: [[UIColor clearColor] CGColor]];
                    [imgvLogo.layer setBorderWidth: 0.0];
                    [imgvLogo.layer setCornerRadius:40.0f];
                    [imgvLogo.layer setMasksToBounds:YES];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    [imgvLogo setFrame:CGRectMake(CGRectGetMidX(_tabvProfile.frame)-50,10,80,80)];
                    [imgvLogo.layer setBorderColor: [[UIColor clearColor] CGColor]];
                    [imgvLogo.layer setBorderWidth: 0.0];
                    [imgvLogo.layer setCornerRadius:40.0f];
                    [imgvLogo.layer setMasksToBounds:YES];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    [imgvLogo setFrame:CGRectMake(CGRectGetMidX(_tabvProfile.frame)-50,10,80,80)];
                    [imgvLogo.layer setBorderColor: [[UIColor clearColor] CGColor]];
                    [imgvLogo.layer setBorderWidth: 0.0];
                    [imgvLogo.layer setCornerRadius:40.0f];
                    [imgvLogo.layer setMasksToBounds:YES];
                }
                else{
                    [imgvLogo setFrame:CGRectMake(CGRectGetMidX(_tabvProfile.frame)-50,20,60,60)];
                    [imgvLogo.layer setBorderColor: [[UIColor clearColor] CGColor]];
                    [imgvLogo.layer setBorderWidth: 0.0];
                    [imgvLogo.layer setCornerRadius:30.0f];
                    [imgvLogo.layer setMasksToBounds:YES];
                }
            }
            imgvLogo.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:imgvLogo];
            
            //-------------------------- Asynchronous Image Loading Method ---------------------------------
            [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
            self.view.userInteractionEnabled=NO;
            [self showLoadingMode];
            NSString *strImageLink=[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"Userimage"]];
            NSURL *Imageurl = [NSURL URLWithString:[strImageLink stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
            NSLog(@"Imageurl :%@",Imageurl);
            
            if ([strImageLink isEqualToString:@""])
            {
                imgvLogo.contentMode=UIViewContentModeScaleAspectFill;
                [imgvLogo setImage:[UIImage imageNamed:@"userimage"]];
            }
            else
            {
                [self downloadImageWithURL:Imageurl completionBlock:^(BOOL succeeded, NSData *data) {
                    if (succeeded)
                    {
                        NSLog(@"success");
                        imgvLogo.contentMode=UIViewContentModeScaleAspectFill;
                        imgvLogo.image= [[UIImage alloc] initWithData:data];
                        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                        self.view.userInteractionEnabled=YES;
                        [self hideLoadingMode];
                    }
                    else
                    {
                        NSLog(@"failure");
                        imgvLogo.contentMode=UIViewContentModeScaleAspectFill;
                        [imgvLogo setImage:[UIImage imageNamed:@"userimage"]];
                        
                        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                        self.view.userInteractionEnabled=YES;
                        [self hideLoadingMode];
                    }
                }];
            }
            
        }
        else if (indexPath.row==1)
        {
            UILabel *lblEmployeeName=[[UILabel alloc] initWithFrame:CGRectMake(0,0,_tabvProfile.frame.size.width,44)];
            lblEmployeeName.text=[NSString stringWithFormat:@"%@ (%@)",[dicTemp valueForKey:@"EmployeeName"],[dicTemp valueForKey:@"EmployeeCode"]];
            lblEmployeeName.numberOfLines=4;
            lblEmployeeName.textAlignment=NSTextAlignmentCenter;
            lblEmployeeName.textColor=[UIColor darkGrayColor];
            lblEmployeeName.font=[UIFont fontWithName:@"GothamBold" size:15];
            lblEmployeeName.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:lblEmployeeName];
            
            UILabel *lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(0,43.5,_tabvProfile.frame.size.width,0.5)];
            lblSeparator.backgroundColor=[UIColor lightGrayColor];
            [cell.contentView addSubview:lblSeparator];
        }
        else if (indexPath.row==2)
        {
            cell.textLabel.font=[UIFont fontWithName:@"GothamBook" size:13];
            cell.textLabel.text=[NSString stringWithFormat:@"Company: %@",[dicTemp valueForKey:@"CompanyName"]];
            cell.textLabel.textColor=[UIColor darkGrayColor];
            
            UILabel *lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(0,43.5,_tabvProfile.frame.size.width,0.5)];
            lblSeparator.backgroundColor=[UIColor lightGrayColor];
            [cell.contentView addSubview:lblSeparator];
        }
        else if (indexPath.row==3)
        {
            cell.textLabel.font=[UIFont fontWithName:@"GothamBook" size:13];
            cell.textLabel.text=[NSString stringWithFormat:@"Date of Joining: %@",[dicTemp valueForKey:@"DateOfJoin"]];
            cell.textLabel.textColor=[UIColor darkGrayColor];
            
            UILabel *lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(0,43.5,_tabvProfile.frame.size.width,0.5)];
            lblSeparator.backgroundColor=[UIColor lightGrayColor];
            [cell.contentView addSubview:lblSeparator];
        }
        else if (indexPath.row==4)
        {
            cell.textLabel.font=[UIFont fontWithName:@"GothamBook" size:13];
            cell.textLabel.text=[NSString stringWithFormat:@"Department: %@",[dicTemp valueForKey:@"Department"]];
            cell.textLabel.textColor=[UIColor darkGrayColor];
            
            UILabel *lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(0,43.5,_tabvProfile.frame.size.width,0.5)];
            lblSeparator.backgroundColor=[UIColor lightGrayColor];
            [cell.contentView addSubview:lblSeparator];
        }
        else if (indexPath.row==5)
        {
            cell.textLabel.font=[UIFont fontWithName:@"GothamBook" size:13];
            cell.textLabel.text=[NSString stringWithFormat:@"Designation: %@",[dicTemp valueForKey:@"Designation"]];
            cell.textLabel.textColor=[UIColor darkGrayColor];
        }
        
        cell.textLabel.textAlignment=NSTextAlignmentLeft;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(IBAction)pressLogout:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"rememberme"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"dicUserDetails"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"dicCompanyDetails"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
