//
//  CarXMLParser.h
//  Smart Car Finder
//
//  Created by Vlad on 28/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarResult.h"
#import "Tradeoff.h"

@interface CarXMLParser : NSObject <NSXMLParserDelegate> {
    
    NSMutableArray *results;
    
    CarResult *tmpResult;
    NSMutableString *currentStringValue;
        
    Tradeoff *tmpTradeoff;
    
}

//Will fetch an XML list of cars and format them to Array
-(NSMutableArray *)convertXMLToResultArray:(NSString *)xmlString;


-(void) dealloc;
@end
