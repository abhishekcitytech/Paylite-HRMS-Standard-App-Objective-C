//
//  MyTextField.m
//  DPX
//
//  Created by Chayan on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    
    CGRect inset;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"applicationlanguage"] isEqualToString:@"ar"])
        {
            inset = CGRectMake(bounds.origin.x +5, bounds.origin.y-1, bounds.size.width -10, bounds.size.height);
        }
        else {
            inset = CGRectMake(bounds.origin.x + 10, bounds.origin.y-1, bounds.size.width - 5, bounds.size.height);
            
        }
        return inset;
    }
    else
    {
        CGRect inset = CGRectMake(bounds.origin.x + 20, bounds.origin.y-4, bounds.size.width - 15, bounds.size.height);
        return inset;
    }
    
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    CGRect inset;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"applicationlanguage"] isEqualToString:@"ar"])
        {
            inset = CGRectMake(bounds.origin.x + 5, bounds.origin.y-1, bounds.size.width - 10, bounds.size.height);
            
        }
        else {
            inset = CGRectMake(bounds.origin.x + 10, bounds.origin.y-1, bounds.size.width - 5, bounds.size.height);
            
        }
        return inset;
    }
    else
    {
        CGRect inset = CGRectMake(bounds.origin.x + 20, bounds.origin.y-4, bounds.size.width - 15, bounds.size.height);
        return inset;
    }
}


@end
