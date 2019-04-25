//
//  Decode64.h
//  VaporStream
//
//  Created by vaporstream on 12/2/09.
//  Copyright 2009 VaporStream, Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Base64 : NSObject {

}


+ (NSString*) encode:(const uint8_t*) input length:(NSInteger) length;
+ (NSString*) encode:(NSData*) rawBytes;
+ (NSData*) decode:(const char*) string length:(NSInteger) inputLength;
+ (NSData*) decode:(NSString*) string;



@end
