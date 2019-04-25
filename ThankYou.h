//
//  ThankYou.h
//  Paylite HR
//
//  Created by Sandipan on 27/12/17.
//  Copyright © 2017 SANDIPAN. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "DashboardE.h"
#import "DashboardMH.h"


@interface ThankYou : ViewController
{
    NSString *strMessage;
}
@property(nonatomic,retain)NSString *strMessage;

@property (strong, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)pressHome:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblThankyou;
@property (strong, nonatomic) IBOutlet UILabel *lblMessage;

@property (strong, nonatomic) IBOutlet UIImageView *imgvThumbs;


@end
