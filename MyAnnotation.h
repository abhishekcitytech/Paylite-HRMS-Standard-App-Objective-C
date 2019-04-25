//
//  MyAnnotation.h
//  SimpleMapView
//
//  Created by Sandipan.

//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>
{
	CLLocationCoordinate2D	coordinate;
	NSString *title;
	NSString *subtitle;
    NSString *brnchID;
    NSString *indexselected;
    int annType;
}

@property (nonatomic, assign)CLLocationCoordinate2D	coordinate;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subtitle;
@property (nonatomic, copy)NSString *brnchID;
@property(nonatomic,retain)NSString *indexselected;
@property(nonatomic,assign)int annType;

@end
