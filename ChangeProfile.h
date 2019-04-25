//
//  ChangeProfile.h
//  Paylite HR
//
//  Created by Sandipan on 10/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "AppDelegate.h"
@class AppDelegate;

@interface ChangeProfile : UIViewController<NSXMLParserDelegate>
{
    UIView *viewAddcartPopup;
    UIView *loadingCircle;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    NSString *strMesgCode,*strMesgText;
}

@property (strong, nonatomic) IBOutlet UIView *vwH;
@property (strong, nonatomic) IBOutlet UITextView *txtVMessage;

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
- (IBAction)pressSubmit:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@end
