//
//  Tradeoff.h
//  Smart Car Finder
//
//  Created by Vlad on 6/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tradeoff : NSObject {
    //Holds the first tradeoff value
    NSString *value1Name;
    NSString *value2Name;
    
    NSString *value1Direction;
    NSString *value2Direction;

    NSString *resultsString;
}

@property (nonatomic,retain) NSString *value1Name;
@property (nonatomic,retain) NSString *value2Name;
@property (nonatomic,retain) NSString *resultsString;
@property (nonatomic,retain) NSString *value1Direction;
@property (nonatomic,retain) NSString *value2Direction;

-(NSString*) getButtonLabel; 
-(NSString*)convertProperty:(NSString*)dbStringValue;
-(NSString*)convertDirection:(NSString*)dbDirection;

@end
