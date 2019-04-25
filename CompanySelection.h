//
//  CompanySelection.h
//  Paylite HRMS
//
//  Created by Sandipan on 06/07/17.
//  Copyright © 2017 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AppDelegate.h"
@class AppDelegate;

#import "MyTextField.h"

#import "DashboardE.h"
#import "DashboardMH.h"

#import "objCompanydetails.h"

@interface CompanySelection : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,NSXMLParserDelegate>
{
    UIView *viewAddcartPopup;
    
    AppDelegate *appSelectCompany;
    
    NSString *strIdentifier;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    
    UITextField *Activetxtfld;
    id actvtextbox;
    UITableView *tblView;
    NSArray *arrFeedTblPopup;
    
    NSMutableArray *arrMCompanylist;
    
    UIView *loadingCircle;
    
    NSString *strIDDD,*strIDDD1;
    
    NSString *strMessageCode,*strMessageText;
    
    NSString *strisManager,*strisHR,*strisGeoLocation;
}

@property(nonatomic,retain)NSMutableArray *arrMCompanylist;

@property (strong, nonatomic) IBOutlet UITextField *txtselectCompany;
@property (strong, nonatomic) IBOutlet UIButton *btnContinue;
- (IBAction)pressContinue:(id)sender;

@end
