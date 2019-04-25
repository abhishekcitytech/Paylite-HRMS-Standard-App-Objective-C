//
//  DependentCell.h
//  Paylite HR
//
//  Created by Sabnam Nasrin on 10/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface DependentCell : UICollectionViewCell
@property(nonatomic,retain)UILabel *lblTitle;
@property(nonatomic,retain)UILabel *lblName;
@property(nonatomic,retain)UIImageView *imgvLogo;

@property(nonatomic,retain)UILabel *lblDOJ;

@end
