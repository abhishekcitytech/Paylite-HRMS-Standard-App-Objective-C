//
//  ExpiringDocuments.h
//  Paylite HR
//
//  Created by Sabnam Nasrin on 06/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
@class AppDelegate;
#import "Menu.h"

@interface ExpiringDocuments : UIViewController<NSXMLParserDelegate>
{
    UIView *viewAddcartPopup;
    UIView *loadingCircle;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    
    NSMutableArray *arrMDocList;
    NSMutableDictionary *dicMDoc;
}

@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableDocument;



@end
