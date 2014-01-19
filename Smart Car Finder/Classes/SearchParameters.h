//
//  SearchParameters.h
//  Smart Car Finder
//
//  Created by Vlad on 1/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

// Singleton object owened by the App Delegate used to hold the user's search parameters at any one time
#import <Foundation/Foundation.h>

typedef enum Factor { FAMILYVALUE = 3000, CITYVALUE = 3001, SPORTSVALUE = 3002, OFFROADVALUE = 3003} FormFactor;

@interface SearchParameters : NSObject {
    float eco;
    float prf;
    float tow;
    float env;
    float lux;
    float siz;
    float saf;
    
    FormFactor carFormFactor;
    float maxPrice;
}

@property (nonatomic) float eco;
@property (nonatomic) float prf;
@property (nonatomic) float tow;
@property (nonatomic) float env;
@property (nonatomic) float lux;
@property (nonatomic) float siz;
@property (nonatomic) float saf;

@property (nonatomic) FormFactor carFormFactor;
@property (nonatomic) float maxPrice;

- (void) printToString;
- (NSString*) getCarStyleInString;

@end
