//
//  CustomCollectionCell.m
//  Paylite HR
//
//  Created by Sandipan on 30/01/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "CustomCollectionCell.h"

@implementation CustomCollectionCell
@synthesize lblTitle,lblDocno,lblDateofExpiry,imgvLogo;



-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        imgvLogo=[[UIImageView alloc] initWithFrame:CGRectMake(20,14,32,32)];
        imgvLogo.backgroundColor=[UIColor clearColor];
        [self addSubview:imgvLogo];
        
        lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgvLogo.frame)+20,0,self.frame.size.width-72,60)];
        lblTitle.textAlignment=NSTextAlignmentLeft;
        lblTitle.textColor=[UIColor darkGrayColor];
        
        lblDocno = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgvLogo.frame)+20,0,self.frame.size.width-72,60)];
        lblDocno.textAlignment=NSTextAlignmentLeft;
        lblDocno.textColor=[UIColor darkGrayColor];
        
        lblDateofExpiry = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgvLogo.frame)+20,0,self.frame.size.width-72,60)];
        lblDateofExpiry.textAlignment=NSTextAlignmentLeft;
        lblDateofExpiry.textColor=[UIColor darkGrayColor];
        
        CGSize screenSize=[[UIScreen mainScreen]bounds].size;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
        {
            if (screenSize.height==568.0f){
                //5S
                lblTitle.font=[UIFont fontWithName:@"GothamBook" size:13];
                lblDocno.font=[UIFont fontWithName:@"GothamBook" size:13];
                lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:13];
            }
            else if(screenSize.height == 667.0f){
                //6
                lblTitle.font=[UIFont fontWithName:@"GothamBook" size:14];
                lblDocno.font=[UIFont fontWithName:@"GothamBook" size:14];
                lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:14];
            }
            else if(screenSize.height == 736.0f){
                //6Plus
                lblTitle.font=[UIFont fontWithName:@"GothamBook" size:14];
                lblDocno.font=[UIFont fontWithName:@"GothamBook" size:14];
                lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:14];
            }
            else if(screenSize.height == 812.0f){
                //X
                lblTitle.font=[UIFont fontWithName:@"GothamBook" size:14];
                lblDocno.font=[UIFont fontWithName:@"GothamBook" size:14];
                lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:14];
            }
            else if(screenSize.height == 896.0f){
                //XSMAX XR
                lblTitle.font=[UIFont fontWithName:@"GothamBook" size:14];
                lblDocno.font=[UIFont fontWithName:@"GothamBook" size:14];
                lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:14];
            }
            else{
                lblTitle.font=[UIFont fontWithName:@"GothamBook" size:13];
                lblDocno.font=[UIFont fontWithName:@"GothamBook" size:13];
                lblDateofExpiry.font=[UIFont fontWithName:@"GothamBook" size:13];
            }
        }
        lblTitle.backgroundColor=[UIColor whiteColor];
        [self addSubview:lblTitle];
        
        lblDocno.backgroundColor=[UIColor whiteColor];
        [self addSubview:lblDocno];
        
        lblDateofExpiry.backgroundColor=[UIColor whiteColor];
        [self addSubview:lblDateofExpiry];
    }
    return self;
}
@end
