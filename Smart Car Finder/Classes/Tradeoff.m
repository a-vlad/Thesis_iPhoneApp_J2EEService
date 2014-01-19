//
//  Tradeoff.m
//  Smart Car Finder
//
//  Created by Vlad on 6/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Tradeoff.h"


@implementation Tradeoff
@synthesize value1Name,value2Name,resultsString,value1Direction,value2Direction;

-(NSString*) getButtonLabel{
    
    /**"Similar cars with XXX XXX and XXX XXX"*/    
    NSString *final = [NSString stringWithFormat:@"%@ %@ \n %@ %@",
                       [self convertDirection:value1Direction],
                       [self convertProperty:value1Name],
                       [self convertDirection:value2Direction],
                       [self convertProperty:value2Name]];    
    return final;
    
}




//HELPER FUNCTIONS

-(NSString*)convertProperty:(NSString*)dbStringValue{
    if ([dbStringValue isEqualToString:@"LuxuryValue"]){
        return @"Luxury Features";
    } else if ([dbStringValue isEqualToString:@"PerformanceValue"]){
        return @"Performance Features";
    } else if ([dbStringValue isEqualToString:@"CityValue"]){
        return @"City-Driving Features";
    } else if ([dbStringValue isEqualToString:@"TowValue"]){
        return @"Towing Capacity";
    } else if ([dbStringValue isEqualToString:@"Price"]){
        return @"Expensive";
    } else if ([dbStringValue isEqualToString:@"GreenValue"]){
        return @"Eco-Friendly";
    } else if ([dbStringValue isEqualToString:@"FamilyValue"]){
        return @"Family-Car Features";
    } else if ([dbStringValue isEqualToString:@"OffroadValue"]){
        return @"Offroad Features";
    } else if ([dbStringValue isEqualToString:@"EconomyValue"]){
        return @"Fuel Efficient";
    } else if ([dbStringValue isEqualToString:@"SafetyValue"]){
        return @"Safety Features";
    } else if ([dbStringValue isEqualToString:@"SportValue"]){
        return @"Sporty";
    } else if ([dbStringValue isEqualToString:@"Size"]){
        return @"Spacious";
    } 
    
    //if could not indexed spit out dbValue for easy debugging
    return [NSString stringWithFormat:@"XX %@ XX",dbStringValue];
}


-(NSString*)convertDirection:(NSString*)dbDirection{
    if ([dbDirection isEqualToString:@"UP"]){
        return @"More";
    } else if ([dbDirection isEqualToString:@"DOWN"]){
        return @"Less";
    }
    
    //if could not indexed spit out dbValue for easy debugging
    return [NSString stringWithFormat:@"!! %@ !!",dbDirection];

}

@end
