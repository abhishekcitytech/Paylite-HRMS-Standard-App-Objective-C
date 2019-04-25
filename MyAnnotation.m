//
//  MyAnnotation.m
//  SimpleMapView
//
//  Created by Sandipan .

//

#import "MyAnnotation.h"


@implementation MyAnnotation

@synthesize title;
@synthesize subtitle;
@synthesize coordinate;
@synthesize brnchID;
@synthesize indexselected;
@synthesize annType;

- (id)init
{
    self = [super init];
    if (self)
    {
        /* custom initialization here ... */
    }
    return self;
}

@end