//
//  CarResult.m
//  Smart Car Finder
//
//  Created by Vlad on 28/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CarResult.h"


@implementation CarResult
@synthesize make,model,version,year,price,carId,photoURL;
@synthesize tradeoffs;
@synthesize doorCount,bestAtTag,transmission,bodyStyle;
@synthesize seatCount,cylCount,enginePower,engineSizeLit,saftyRating,weight;
@synthesize vid_url,review_url,specs_url;

-(NSString*)getFriendlyTranName{
    if ([self.transmission isEqualToString:@"M"]){
        return @"Manual";
    } else if ([self.transmission isEqualToString:@"A"]) {
        return @"Automatic";        
    } else {
        //If special label such as "Tiptronic" or "Semiauto" will return label
        return transmission;
    }
    
}

-(void)printAsString{
    NSLog(@"%@ %d %@ %@ %@ %@",[carId stringValue], year, make, model,version,photoURL);
    
}

-(bool)isValid{
    //TODO: Better check
    return true;
}

@end
