//
//  CustomCollectionCell.h
//  Paylite HR
//
//  Created by Sandipan on 30/01/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface CustomCollectionCell : UICollectionViewCell

@property(nonatomic,retain)UILabel *lblTitle;
@property(nonatomic,retain)UIImageView *imgvLogo;

@property(nonatomic,retain)UILabel *lblDocno;
@property(nonatomic,retain)UILabel *lblDateofExpiry;

@end
