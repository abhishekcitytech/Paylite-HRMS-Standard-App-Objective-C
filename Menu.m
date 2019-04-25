//
//  Menu.m
//  MoonShine
//
//  Created by SANDIPAN on 12/08/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import "Menu.h"
AppDelegate *app;
@interface Menu ()

@end

@implementation Menu

#pragma mark- ViewWillDisAppear Method
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

#pragma mark- ViewWillAppear Method
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark- ViewDisAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

#pragma mark - viewDidLoad Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    _tabmenu.backgroundView=nil;
    _tabmenu.backgroundColor=[UIColor whiteColor];
    _tabmenu.separatorColor=[UIColor clearColor];
    
   
    [_btnLogout.layer setMasksToBounds:YES];
    [_btnLogout.layer setCornerRadius: 4.0];
    [_btnLogout.layer setBorderWidth:1.0];
    [_btnLogout.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    //----------- Single Tap and Swipe Gesture ---------------//
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSlide:)];
    [_bggOverALL addGestureRecognizer:gestureRecognizer];
    _bggOverALL.userInteractionEnabled = YES;
    gestureRecognizer.cancelsTouchesInView = NO;
    
    UISwipeGestureRecognizer *gestureRecognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideSlide:)];
    gestureRecognizer1.direction=UISwipeGestureRecognizerDirectionLeft;
    [_bggOverALL addGestureRecognizer:gestureRecognizer1];
    _bggOverALL.userInteractionEnabled = YES;
    gestureRecognizer1.cancelsTouchesInView = NO;
    //-------------------------------------------------------//
    
    NSMutableDictionary *dicTemp1=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    if ([[dicTemp1 valueForKey:@"isManager"] isEqualToString:@"0"]&&[[dicTemp1 valueForKey:@"isHR"] isEqualToString:@"0"])
    {
        //Self Service Employee//
        arrMAll=[[NSMutableArray alloc] initWithObjects:@"Dashboard",@"Make Request",@"Time & Attendance",@"Payroll History",@"My Documents",@"Public Holidays",@"More", nil];
        
        arrMAllImage=[[NSMutableArray alloc] initWithObjects:@"SM1",@"SM2",@"SM4",@"SM5",@"SM6",@"SM7",@"SM8", nil];
        
    }
    else
    {
        //Self Service Manager HR//
        arrMAll=[[NSMutableArray alloc] initWithObjects:@"Dashboard",@"Make Request",@"Approve Applications",@"Time & Attendance",@"Payroll History",@"My Documents",@"Public Holidays",@"More", nil];
        
        arrMAllImage=[[NSMutableArray alloc] initWithObjects:@"SM1",@"SM2",@"SM3",@"SM4",@"SM5",@"SM6",@"SM7",@"SM8", nil];
    }
    
    //------ Profile picture  and employee name ------
    [_imageProfile.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [_imageProfile.layer setBorderWidth: 0.0];
    [_imageProfile.layer setCornerRadius:self.imageProfile.frame.size.width/2];
    [_imageProfile.layer setMasksToBounds:YES];
    
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    _lblName.text=[NSString stringWithFormat:@"%@ (%@) \n\n%@",[dicTemp valueForKey:@"EmployeeName"],[dicTemp valueForKey:@"EmployeeCode"],[dicTemp valueForKey:@"Designation"]];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    self.view.userInteractionEnabled=NO;
    [self showLoadingMode];
    NSMutableDictionary *dicTempp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    NSString *strProfileImageLink=[NSString stringWithFormat:@"%@",[dicTempp valueForKey:@"Userimage"]];
    NSURL *Imageurlprofile = [NSURL URLWithString:[strProfileImageLink stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    NSLog(@"Imageurl :%@",Imageurlprofile);
    
    NSLog(@"strProfileImageLink :%@",strProfileImageLink);
    
    if ([strProfileImageLink isEqualToString:@""])
    {
        _imageProfile.contentMode=UIViewContentModeScaleAspectFill;
        [_imageProfile setImage:[UIImage imageNamed:@"userimage"]];
    }
    else
    {
        [self downloadImageWithURL:Imageurlprofile completionBlock:^(BOOL succeeded, NSData *data) {
            if (succeeded)
            {
                NSLog(@"success");
                _imageProfile.contentMode=UIViewContentModeScaleAspectFill;
                _imageProfile.image= [[UIImage alloc] initWithData:data];
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                self.view.userInteractionEnabled=YES;
                [self hideLoadingMode];
            }
            else
            {
                NSLog(@"failure");
                _imageProfile.contentMode=UIViewContentModeScaleAspectFill;
                [_imageProfile setImage:[UIImage imageNamed:@"userimage"]];
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
                self.view.userInteractionEnabled=YES;
                [self hideLoadingMode];
            }
        }];    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Press Swipe Method
- (IBAction)pressSideMenu:(id)sender
{
}
-(void)hideSlide: (UITapGestureRecognizer *) recognizer
{
    _bggOverALL.backgroundColor=[UIColor clearColor];
    
    CGRect temp = self.view.frame;
    temp.origin.x = -[[UIScreen mainScreen] bounds].size.width ;
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.view.frame = temp;
                     }completion:^(BOOL finished){
                         
                         [self.view removeFromSuperview];
                         [self didMoveToParentViewController:nil];
                     }];
}


#pragma mark - Press Logout Method
- (IBAction)pressLogoutFunction:(id)sender
{
    [self logoutMethod];
}



#pragma mark - UITableView Delegate & DataSource Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 60.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrMAll count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier=@"cellidentifier";
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellidentifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.backgroundColor=[UIColor whiteColor];
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height==568.0f){
            //5S
            UIImage *myImage=[UIImage imageNamed:[arrMAllImage objectAtIndex:indexPath.row]];
            UIImageView *imgvIcon=[[UIImageView alloc]init];
            [imgvIcon setFrame:CGRectMake(20,16,28,28)];
            [imgvIcon setImage:myImage];
            [cell.contentView addSubview:imgvIcon];
            
            UILabel *lblCellTitle=[[UILabel alloc] init];
            lblCellTitle.frame=CGRectMake(CGRectGetMaxX(imgvIcon.frame)+5,0,cell.frame.size.width-64,60);
            lblCellTitle.textColor=[UIColor darkGrayColor];
            lblCellTitle.backgroundColor=[UIColor whiteColor];
            lblCellTitle.numberOfLines=1;
            lblCellTitle.text=[NSString stringWithFormat:@"  %@",[arrMAll objectAtIndex:indexPath.row]];
            lblCellTitle.font=[UIFont fontWithName:@"GothamBook" size:15.0];
            lblCellTitle.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:lblCellTitle];
        }
        else if(screenSize.height == 667.0f){
            //6
            UIImage *myImage=[UIImage imageNamed:[arrMAllImage objectAtIndex:indexPath.row]];
            UIImageView *imgvIcon=[[UIImageView alloc]init];
            [imgvIcon setFrame:CGRectMake(20,16,28,28)];
            [imgvIcon setImage:myImage];
            [cell.contentView addSubview:imgvIcon];
            
            UILabel *lblCellTitle=[[UILabel alloc] init];
            lblCellTitle.frame=CGRectMake(CGRectGetMaxX(imgvIcon.frame)+5,0,cell.frame.size.width-64,60);
            lblCellTitle.textColor=[UIColor darkGrayColor];
            lblCellTitle.backgroundColor=[UIColor whiteColor];
            lblCellTitle.numberOfLines=1;
            lblCellTitle.text=[NSString stringWithFormat:@"  %@",[arrMAll objectAtIndex:indexPath.row]];
            lblCellTitle.font=[UIFont fontWithName:@"GothamBook" size:15.0];
            lblCellTitle.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:lblCellTitle];
        }
        else if(screenSize.height == 736.0f){
            //6Plus
            UIImage *myImage=[UIImage imageNamed:[arrMAllImage objectAtIndex:indexPath.row]];
            UIImageView *imgvIcon=[[UIImageView alloc]init];
            [imgvIcon setFrame:CGRectMake(20,16,28,28)];
            [imgvIcon setImage:myImage];
            [cell.contentView addSubview:imgvIcon];
            
            UILabel *lblCellTitle=[[UILabel alloc] init];
            lblCellTitle.frame=CGRectMake(CGRectGetMaxX(imgvIcon.frame)+5,0,cell.frame.size.width-64,60);
            lblCellTitle.textColor=[UIColor darkGrayColor];
            lblCellTitle.backgroundColor=[UIColor whiteColor];
            lblCellTitle.numberOfLines=1;
            lblCellTitle.text=[NSString stringWithFormat:@"  %@",[arrMAll objectAtIndex:indexPath.row]];
            lblCellTitle.font=[UIFont fontWithName:@"GothamBook" size:15.0];
            lblCellTitle.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:lblCellTitle];
        }
        else if(screenSize.height == 812.0f){
            //X
            UIImage *myImage=[UIImage imageNamed:[arrMAllImage objectAtIndex:indexPath.row]];
            UIImageView *imgvIcon=[[UIImageView alloc]init];
            [imgvIcon setFrame:CGRectMake(20,16,28,28)];
            [imgvIcon setImage:myImage];
            [cell.contentView addSubview:imgvIcon];
            
            UILabel *lblCellTitle=[[UILabel alloc] init];
            lblCellTitle.frame=CGRectMake(CGRectGetMaxX(imgvIcon.frame)+5,0,cell.frame.size.width-64,60);
            lblCellTitle.textColor=[UIColor darkGrayColor];
            lblCellTitle.backgroundColor=[UIColor whiteColor];
            lblCellTitle.numberOfLines=1;
            lblCellTitle.text=[NSString stringWithFormat:@"  %@",[arrMAll objectAtIndex:indexPath.row]];
            lblCellTitle.font=[UIFont fontWithName:@"GothamBook" size:15.0];
            lblCellTitle.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:lblCellTitle];
        }
        else if(screenSize.height == 896.0f){
            //XSMAX XR
            UIImage *myImage=[UIImage imageNamed:[arrMAllImage objectAtIndex:indexPath.row]];
            UIImageView *imgvIcon=[[UIImageView alloc]init];
            [imgvIcon setFrame:CGRectMake(20,16,28,28)];
            [imgvIcon setImage:myImage];
            [cell.contentView addSubview:imgvIcon];
            
            UILabel *lblCellTitle=[[UILabel alloc] init];
            lblCellTitle.frame=CGRectMake(CGRectGetMaxX(imgvIcon.frame)+5,0,cell.frame.size.width-64,60);
            lblCellTitle.textColor=[UIColor darkGrayColor];
            lblCellTitle.backgroundColor=[UIColor whiteColor];
            lblCellTitle.numberOfLines=1;
            lblCellTitle.text=[NSString stringWithFormat:@"  %@",[arrMAll objectAtIndex:indexPath.row]];
            lblCellTitle.font=[UIFont fontWithName:@"GothamBook" size:15.0];
            lblCellTitle.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:lblCellTitle];
        }
        else
        {
            UIImage *myImage=[UIImage imageNamed:[arrMAllImage objectAtIndex:indexPath.row]];
            UIImageView *imgvIcon=[[UIImageView alloc]init];
            [imgvIcon setFrame:CGRectMake(20,16,28,28)];
            [imgvIcon setImage:myImage];
            [cell.contentView addSubview:imgvIcon];
            
            UILabel *lblCellTitle=[[UILabel alloc] init];
            lblCellTitle.frame=CGRectMake(CGRectGetMaxX(imgvIcon.frame)+5,0,cell.frame.size.width-64,60);
            lblCellTitle.textColor=[UIColor darkGrayColor];
            lblCellTitle.backgroundColor=[UIColor whiteColor];
            lblCellTitle.numberOfLines=1;
            lblCellTitle.text=[NSString stringWithFormat:@"  %@",[arrMAll objectAtIndex:indexPath.row]];
            lblCellTitle.font=[UIFont fontWithName:@"GothamBook" size:15.0];
            lblCellTitle.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:lblCellTitle];
        }
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self didMoveToParentViewController:nil];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(-UIScreen.mainScreen.bounds.size.width, 0, UIScreen.mainScreen.bounds.size.width, self.view.frame.size.height)];
        [self.view removeFromSuperview];
    }];
    
    NSMutableDictionary *dicTemp1=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    if ([[dicTemp1 valueForKey:@"isManager"] isEqualToString:@"0"]&&[[dicTemp1 valueForKey:@"isHR"] isEqualToString:@"0"])
    {
        if (indexPath.row==0)
        {
            //Dashboard
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
        else if (indexPath.row==1)
        {
            //Application Request
            AppRequestStatus *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatus5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatus6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatus6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatusX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatusXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatus" bundle:nil];
                }
            }
            else{
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
        else if (indexPath.row==2)
        {
            //Time & Attendance
            TodaysAttendance *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendanceX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendanceXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance" bundle:nil];
                }
            }
            else
            {
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
        else if (indexPath.row==3)
        {
            //Payroll History
            PayrollHistory *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistory5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistory6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistory6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistoryX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistoryXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistory" bundle:nil];
                }
            }
            else
            {
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
        else if (indexPath.row==4)
        {
            //My Documents
            DownloadDcouments *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcouments5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcouments6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcouments6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcoumentsX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcoumentsXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcouments" bundle:nil];
                }
            }
            else
            {
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
        else if (indexPath.row==5)
        {
            //Public Holidays
            PublicHoliday *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHoliday5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHoliday6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHoliday6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHolidayX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHolidayXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHoliday" bundle:nil];
                }
            }
            else
            {
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
        else if (indexPath.row==6)
        {
            //More
            ReportCategory *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategory5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategory6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategory6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategoryX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategoryXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategory" bundle:nil];
                }
            }
            else
            {
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
    }
    else
    {
        if (indexPath.row==0)
        {
            //Dashboard
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
        else if (indexPath.row==1)
        {
            //Application Request
            AppRequestStatus *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatus5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatus6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatus6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatusX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatusXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[AppRequestStatus alloc] initWithNibName:@"AppRequestStatus" bundle:nil];
                }
            }
            else{
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
        else if (indexPath.row==2)
        {
            //Application Approval
            AppApprovalCategory *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[AppApprovalCategory alloc] initWithNibName:@"AppApprovalCategory5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[AppApprovalCategory alloc] initWithNibName:@"AppApprovalCategory6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[AppApprovalCategory alloc] initWithNibName:@"AppApprovalCategory6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[AppApprovalCategory alloc] initWithNibName:@"AppApprovalCategoryX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[AppApprovalCategory alloc] initWithNibName:@"AppApprovalCategoryXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[AppApprovalCategory alloc] initWithNibName:@"AppApprovalCategory" bundle:nil];
                }
            }
            else{
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
        else if (indexPath.row==3)
        {
            //Time & Attendance
            TodaysAttendance *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendanceX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendanceXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[TodaysAttendance alloc] initWithNibName:@"TodaysAttendance" bundle:nil];
                }
            }
            else
            {
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
        else if (indexPath.row==4)
        {
            //Payroll History
            PayrollHistory *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistory5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistory6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistory6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistoryX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistoryXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[PayrollHistory alloc] initWithNibName:@"PayrollHistory" bundle:nil];
                }
            }
            else
            {
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
        else if (indexPath.row==5)
        {
            //My Documents
            DownloadDcouments *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcouments5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcouments6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcouments6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcoumentsX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcoumentsXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[DownloadDcouments alloc] initWithNibName:@"DownloadDcouments" bundle:nil];
                }
            }
            else
            {
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
        else if (indexPath.row==6)
        {
            //Public Holidays
            PublicHoliday *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHoliday5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHoliday6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHoliday6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHolidayX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHolidayXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[PublicHoliday alloc] initWithNibName:@"PublicHoliday" bundle:nil];
                }
            }
            else
            {
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
        else if (indexPath.row==7)
        {
            //More
            ReportCategory *objDemo;
            CGSize screenSize=[[UIScreen mainScreen]bounds].size;
            if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
            {
                if (screenSize.height==568.0f){
                    //5S
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategory5S" bundle:nil];
                }
                else if(screenSize.height == 667.0f){
                    //6
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategory6" bundle:nil];
                }
                else if(screenSize.height == 736.0f){
                    //6Plus
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategory6Plus" bundle:nil];
                }
                else if(screenSize.height == 812.0f){
                    //X
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategoryX" bundle:nil];
                }
                else if(screenSize.height == 896.0f){
                    //XSMAX XR
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategoryXSMAX" bundle:nil];
                }
                else{
                    objDemo = [[ReportCategory alloc] initWithNibName:@"ReportCategory" bundle:nil];
                }
            }
            else
            {
            }
            [self.navigationController pushViewController:objDemo animated:NO];
        }
    }
}




#pragma mark - Logout  Method
-(void)logoutMethod
{
    NSString *strDeviceID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]];
    NSLog(@"Device Token %@",strDeviceID);
    
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
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
                             "<DeleteDeviceId xmlns=\"http://tempuri.org/\"><sEmployeeId>%@</sEmployeeId>,<sDeviceId>%@</sDeviceId>,<sDeviceType>%@</sDeviceType>"
                             "</DeleteDeviceId> \n"
                             "</SOAP-ENV:Body> \n"
                             "</SOAP-ENV:Envelope>",[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"EmployeeID"]],strDeviceID,@"I"];
    
    NSString *strConUrl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"strConnectionurl"]];
    NSLog(@"strConUrl :%@",strConUrl);
    
    NSLog(@"soapMessage %@",soapMessage);
    NSURL *url = [NSURL URLWithString:strConUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d",(int)[soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/ISelfService/DeleteDeviceId" forHTTPHeaderField:@"SOAPAction"];
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
        if ([elementName isEqualToString:@"DeleteDeviceIdResult"])
        {
            NSLog(@"rootis called..");
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
        if ([elementName isEqualToString:@"MessageCode"])
        {
            strLogoutMessageCode=currentElementValue;
            currentElementValue=nil;
        }
        if ([elementName isEqualToString:@"MessageText"])
        {
            strLogoutMessegeText=currentElementValue;
            currentElementValue=nil;
            
        }
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if ([strIdentifier isEqualToString:@"1"])
    {
        int code=[strLogoutMessageCode intValue];
        if (code==0)
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"rememberme"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"dicUserDetails"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"dicCompanyDetails"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:@"Error in logout, please try after sometime."
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
