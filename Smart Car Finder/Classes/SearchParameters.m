//
//  SearchParameters.m
//  Smart Car Finder
//
//  Created by Vlad on 1/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchParameters.h"
#import "CarResult.h"

@implementation SearchParameters
@synthesize eco;
@synthesize prf;
@synthesize tow;
@synthesize env;
@synthesize lux;
@synthesize siz;
@synthesize saf;
@synthesize carFormFactor;
@synthesize maxPrice;

- (void) printToString{
    NSLog(@"eco:%f prf:%f tow:%f env:%f lux:%f siz:%f saf:%f carBodyStyle:%d maxPrice:%f",eco,prf,tow,env,lux,siz,saf,carFormFactor,maxPrice);
    
}

//Returns car form type as a string
- (NSString*) getCarStyleInString{
    if (carFormFactor == FAMILYVALUE){
        return @"FamilyValue";
    } else if (carFormFactor == CITYVALUE){
        return @"CityValue";
    } else if (carFormFactor == OFFROADVALUE){
        return @"OffroadValue";
    } else if (carFormFactor == SPORTSVALUE) {
        return @"SportValue";
    }

    NSLog(@"CAR TYPE ERROR! Mismatch car form type.");
    return nil;
}

@end
