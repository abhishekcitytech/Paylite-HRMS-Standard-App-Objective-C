//
//  AppRequestStatus.m
//  Paylite HR
//
//  Created by Sandipan on 13/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "AppRequestStatus.h"

@interface AppRequestStatus ()

@end

@implementation AppRequestStatus

#pragma mark - viewDidAppear Method
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
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
    
    _tabvSubcat.backgroundView=nil;
    _tabvSubcat.backgroundColor=[UIColor whiteColor];
    _tabvSubcat.separatorColor=[UIColor clearColor];
    _tabvSubcat.showsVerticalScrollIndicator=NO;
    
    arrMAll=[[NSMutableArray alloc] initWithObjects:@"Apply for Leave",@"Request for Advance",@"Claim Expense",@"Request Profile Update", nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SlideMenu Press Method
- (IBAction)pressSlideMenu:(id)sender
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
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor=[UIColor whiteColor];
    
    UILabel *lblCellTitle=[[UILabel alloc] init];
    lblCellTitle.frame=CGRectMake(15,0,cell.frame.size.width-15,60);
    lblCellTitle.textColor=[UIColor darkGrayColor];
    lblCellTitle.backgroundColor=[UIColor whiteColor];
    lblCellTitle.numberOfLines=1;
    lblCellTitle.text=[NSString stringWithFormat:@"  %@",[arrMAll objectAtIndex:indexPath.row]];
    lblCellTitle.font=[UIFont fontWithName:@"GothamBook" size:15.0];
    lblCellTitle.textAlignment=NSTextAlignmentLeft;
    [cell.contentView addSubview:lblCellTitle];
    
    UILabel *lblSeparator=[[UILabel alloc] initWithFrame:CGRectMake(0,59.7,_tabvSubcat.frame.size.width,0.3)];
    lblSeparator.backgroundColor=[UIColor lightGrayColor];
    [cell.contentView addSubview:lblSeparator];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        MyLeave *objDemo;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeave5S" bundle:nil];
            }
            else if(screenSize.height == 667.0f){
                //6
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeave6" bundle:nil];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeave6Plus" bundle:nil];
            }
            else if(screenSize.height == 812.0f){
                //X
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeaveX" bundle:nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeaveXSMAX" bundle:nil];
            }
            else{
                objDemo = [[MyLeave alloc] initWithNibName:@"MyLeave" bundle:nil];
            }
        }
        else
        {
        }
        [self.navigationController pushViewController:objDemo animated:YES];
    }
    else if (indexPath.row==1)
    {
        MyAdvance *objDemo;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvance5S" bundle:nil];
            }
            else if(screenSize.height == 667.0f){
                //6
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvance6" bundle:nil];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvance6Plus" bundle:nil];
            }
            else if(screenSize.height == 812.0f){
                //X
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvanceX" bundle:nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvanceXSMAX" bundle:nil];
            }
            else{
                objDemo = [[MyAdvance alloc] initWithNibName:@"MyAdvance" bundle:nil];
            }
        }
        else
        {
        }
        [self.navigationController pushViewController:objDemo animated:YES];
    }
    else if (indexPath.row==2)
    {
        MyExpenseClaim *objDemo;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim5S" bundle:nil];
            }
            else if(screenSize.height == 667.0f){
                //6
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim6" bundle:nil];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim6Plus" bundle:nil];
            }
            else if(screenSize.height == 812.0f){
                //X
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaimX" bundle:nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaimXSMAX" bundle:nil];
            }
            else{
                objDemo = [[MyExpenseClaim alloc] initWithNibName:@"MyExpenseClaim" bundle:nil];
            }
        }
        else
        {
        }
        [self.navigationController pushViewController:objDemo animated:YES];
    }
    else if (indexPath.row==3)
    {
        ChangeProfile *objDemo;
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfile5S" bundle:nil];
            }
            else if(screenSize.height == 667.0f){
                //6
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfile6" bundle:nil];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfile6Plus" bundle:nil];
            }
            else if(screenSize.height == 812.0f){
                //X
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfileX" bundle:nil];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfileXSMAX" bundle:nil];
            }
            else{
                objDemo = [[ChangeProfile alloc] initWithNibName:@"ChangeProfile" bundle:nil];
            }
        }
        else
        {
        }
        [self.navigationController pushViewController:objDemo animated:YES];
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
