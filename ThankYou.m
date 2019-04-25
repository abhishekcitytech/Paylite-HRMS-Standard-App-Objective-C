//
//  ThankYou.m
//  Paylite HR
//
//  Created by Sandipan on 27/12/17.
//  Copyright © 2017 SANDIPAN. All rights reserved.
//

#import "ThankYou.h"

@interface ThankYou ()

@end

@implementation ThankYou
@synthesize strMessage;


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
    
    _lblMessage.text=[NSString stringWithFormat:@"%@",strMessage];
    
    [_btnHome.layer setMasksToBounds:YES];
    [_btnHome.layer setCornerRadius: 2.0];
    [_btnHome.layer setBorderWidth:0.0];
    [_btnHome.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    _imgvThumbs.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    _imgvThumbs.layer.shadowOffset = CGSizeMake(0, 2.0f);
    _imgvThumbs.layer.shadowOpacity = 1.0f;
    [_imgvThumbs.layer setMasksToBounds:NO];
    [_imgvThumbs.layer setCornerRadius: 0.0];
    [_imgvThumbs.layer setBorderWidth:0.0];
    [_imgvThumbs.layer setBorderColor:[[UIColor clearColor] CGColor]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pressHome:(id)sender
{
    /*NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];*/
    
    [self turnBackToAnOldViewController];
}

- (void)turnBackToAnOldViewController
{
    NSMutableDictionary *dicTemp=[[NSUserDefaults standardUserDefaults] valueForKey:@"dicUserDetails"];
    
    if ([[dicTemp valueForKey:@"isManager"] isEqualToString:@"0"]&&[[dicTemp valueForKey:@"isHR"] isEqualToString:@"0"])
    {
        //employee
        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            //Do not forget to import AnOldViewController.h
            if ([controller isKindOfClass:[DashboardE class]]) {
                
                [self.navigationController popToViewController:controller animated:YES];
                break;
            }
        }
    }
    else
    {
        //hr manager
        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            //Do not forget to import AnOldViewController.h
            if ([controller isKindOfClass:[DashboardMH class]]) {
                
                [self.navigationController popToViewController:controller animated:YES];
                break;
            }
        }
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
