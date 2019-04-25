//
//  DependentCell.m
//  Paylite HR
//
//  Created by Sabnam Nasrin on 10/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import "DependentCell.h"

@implementation DependentCell
@synthesize lblTitle,lblName,lblDOJ,imgvLogo;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        imgvLogo=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,60,60)];
        [imgvLogo setCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2-25)];
        imgvLogo.backgroundColor=[UIColor clearColor];
        [self addSubview:imgvLogo];
        
        lblName = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imgvLogo.frame)+10,self.frame.size.width,20)];
        lblName.textAlignment=NSTextAlignmentCenter;
        lblName.textColor=[UIColor darkGrayColor];
        
        lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(lblName.frame),self.frame.size.width,20)];
        lblTitle.textAlignment=NSTextAlignmentCenter;
        lblTitle.textColor=[UIColor colorWithRed:30/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
        
        lblDOJ = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(lblTitle.frame)+10,self.frame.size.width,20)];
        lblDOJ.textAlignment=NSTextAlignmentCenter;
        lblDOJ.textColor=[UIColor darkGrayColor];
        
    
        lblTitle.backgroundColor=[UIColor clearColor];
        lblName.backgroundColor=[UIColor clearColor];
        lblDOJ.backgroundColor=[UIColor clearColor];
        
        [self addSubview:lblTitle];
        [self addSubview:lblName];
        [self addSubview:lblDOJ];
    }
    return self;
}
@end
