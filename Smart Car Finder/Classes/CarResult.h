//
//  CarResult.h
//  Smart Car Finder
//
//  Created by Vlad on 28/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tradeoff.h"

@interface CarResult : NSObject {

    NSNumber *carId;    
    
    NSInteger year;
    NSInteger price;

    NSString *make;
    NSString *model;
    NSString *version;
    
    NSInteger doorCount;
    NSString *bestAtTag;
    NSString *transmission;
    NSString *bodyStyle;
    
    NSString *photoURL;  
    
    NSMutableArray *tradeoffs;
 
    
    NSString *vid_url;
    NSString *review_url;
    NSString *specs_url;
    
    //Detail view info
    //<seats>5</seats><cyl>4</cyl><engsiz>1.8</engsiz><engpow>93.0</engpow><safrat>0.375</safrat><weight>1136</weight>
    NSInteger seatCount;
    NSInteger cylCount;
    float engineSizeLit;
    NSInteger enginePower;
    float saftyRating;
    NSInteger weight;
}

@property (nonatomic, retain) NSNumber *carId;
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger doorCount;


@property (nonatomic) NSInteger seatCount;
@property (nonatomic) NSInteger cylCount;
@property (nonatomic) float engineSizeLit;
@property (nonatomic) NSInteger enginePower;
@property (nonatomic) float saftyRating;
@property (nonatomic) NSInteger weight;




@property (nonatomic, retain) NSString *make;
@property (nonatomic, retain) NSString *model;
@property (nonatomic, retain) NSString *version;
@property (nonatomic, retain) NSString *photoURL;
@property (nonatomic, retain) NSMutableArray *tradeoffs;


@property (nonatomic, retain) NSString *bestAtTag;
@property (nonatomic, retain) NSString *transmission;
@property (nonatomic, retain) NSString *bodyStyle;

@property (nonatomic, retain) NSString *vid_url;
@property (nonatomic, retain) NSString *review_url;
@property (nonatomic, retain) NSString *specs_url;


-(void)printAsString;
-(NSString*)getFriendlyTranName;
-(bool)isValid;

@end
