//
//  DownloadDcouments.h
//  Paylite HR
//
//  Created by Sandipan on 30/01/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class AppDelegate;

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "CustomCollectionCell.h"
@class CustomCollectionCell;

#import "Menu.h"

@interface DownloadDcouments : UIViewController<NSXMLParserDelegate,UIScrollViewDelegate,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIActivityIndicatorView *activityView;
    UIActivityIndicatorView *activityView1;
    
    AppDelegate *app334333;
    
    UIView *viewAddcartPopup;
    UIView *loadingCircle;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    NSString *strMessagecode,*strMessagetext;
    
    NSMutableArray *arrMData;
    NSMutableDictionary *dicData;
    
    UICollectionView *col;
    
    
    UIView *mainBg,*bgVwHeader,*bgTopBarVw;
    UIButton *btnDonepdf,*btnPrintpdf,*btnEmailpdf;
    UIScrollView *scrollDoc;
    NSArray *arrUrlList;
    UIWebView *webViewPdfReader;
}

@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;


@end
