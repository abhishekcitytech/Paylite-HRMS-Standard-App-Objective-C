//
//  MyDependents.h
//  Paylite HR
//
//  Created by Sabnam Nasrin on 10/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DependentCell.h"

#import "AppDelegate.h"
@class AppDelegate;

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "objDependency.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MyDependents : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,NSXMLParserDelegate>
{
    UIView *viewAddcartPopup;
    UIView *loadingCircle;
    
    UICollectionView *collectionDependent;
    
    NSMutableData *d2;
    NSMutableString *currentElementValue;
    NSString *strIdentifier;
    NSMutableArray *arrMAllList;
    objDependency *objDL;
}
@property (strong, nonatomic) IBOutlet UIView *vwH;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)pressBack:(id)sender;

@end
