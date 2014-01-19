//
//  CarXMLParser.m
//  Smart Car Finder
//
//  Created by Vlad on 28/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CarXMLParser.h"


@implementation CarXMLParser


-(NSMutableArray *)convertXMLToResultArray:(NSString *)xmlString{
    
    BOOL success;
    
    //NSString *xmlString = [NSString stringWithFormat:@"results.xml"];
    NSString *myUrlString = [xmlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURL *xmlURL = [NSURL URLWithString:myUrlString];

    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities:YES];
    
    success = [xmlParser parse];    // return value not used    
    // if not successful, delegate is informed of error    return nil;
   /* 
    //Check if results are valid if not then return nil
    for(int i=0;i<[results count];i++){
        CarResult *result = [results objectAtIndex:i];
        if(result == nil){
            return nil;
        }
    }
    */
    
    //Car results all valid
    return results;
    
}


// XML Parser Delegate Methods //

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ( [elementName isEqualToString:@"matches"]) {
        // When reading the root node opening tag the results array is initialized
        if (!results)
            results = [[NSMutableArray alloc] init];
        return;
    }
    if ( [elementName isEqualToString:@"car"] ) {
        // Initialize tmp CarResult when reading opening car tag
        tmpResult = [[CarResult alloc] init];
        
        //Initializes tradeoffs array list
        [tmpResult setTradeoffs:[[NSMutableArray alloc] init]];
        
        return;
    }
    if ( [elementName isEqualToString:@"tradeoff"] ) {
        // Initialize tmp Tradeoff when reading opening car tag
        tmpTradeoff = [[Tradeoff alloc] init];
        return;
    }

}




- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentStringValue) {
        // currentStringValue is an NSMutableString instance variable
        currentStringValue = [[NSMutableString alloc] initWithCapacity:50];
    }
    [currentStringValue appendString:string];
}




- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // ignore root and empty elements
    if ( [elementName isEqualToString:@"matches"]) return;
    
    
    if ( [elementName isEqualToString:@"car"] ) {
        //Add temp car object to array list then release temp car
        [results addObject:tmpResult];
        [tmpResult release];    
        return;
    }

    if ( [elementName isEqualToString:@"tradeoff"] ) {
        //Add temp car object to array list then release temp car
        [tmpResult.tradeoffs addObject:tmpTradeoff];
        [tmpTradeoff release];    
        return;
    }
    
    
    
    //Set tmp result parameters
    if ( [elementName isEqualToString:@"id"] ) {
        [tmpResult setCarId:[NSNumber numberWithLongLong:[currentStringValue longLongValue]]];
    } else if ( [elementName isEqualToString:@"make"] ) {
        tmpResult.make = currentStringValue;
    } else if ( [elementName isEqualToString:@"model"] ) {
        tmpResult.model = currentStringValue;
    } else if ( [elementName isEqualToString:@"version"] ) {
        tmpResult.version = currentStringValue;
    } else if ( [elementName isEqualToString:@"photoURL"] ) {
        tmpResult.photoURL = currentStringValue;
    } else if ( [elementName isEqualToString:@"transmission"] ) {
        tmpResult.transmission = currentStringValue;
    } else if ( [elementName isEqualToString:@"doors"] ) {
        tmpResult.doorCount = [currentStringValue integerValue];
    } else if ( [elementName isEqualToString:@"bodystyle"] ) {
        tmpResult.bodyStyle = currentStringValue;        
    } else if ( [elementName isEqualToString:@"bestat"] ) {
        tmpResult.bestAtTag = currentStringValue;
    } else if ( [elementName isEqualToString:@"price"] ) {
        [tmpResult setPrice:[currentStringValue integerValue]];
    }  else if ( [elementName isEqualToString:@"year"] ) {
        [tmpResult setYear:[currentStringValue integerValue]];
    }    
    
    
    //tmp tradeoff elements
    else if ( [elementName isEqualToString:@"spec1"] ) {
        [tmpTradeoff setValue1Name:currentStringValue];
    } else if ( [elementName isEqualToString:@"spec2"] ) {
        [tmpTradeoff setValue2Name:currentStringValue];
    } else if ( [elementName isEqualToString:@"spec1dir"] ) {
        [tmpTradeoff setValue1Direction:currentStringValue];
    } else if ( [elementName isEqualToString:@"spec2dir"] ) {
        [tmpTradeoff setValue2Direction:currentStringValue];
    } else if ( [elementName isEqualToString:@"vids"] ) {
        [tmpTradeoff setResultsString:currentStringValue];
    }     
    
    
    else if ( [elementName isEqualToString:@"seats"] ) {
        [tmpResult setSeatCount:[currentStringValue integerValue]];
    } else if ( [elementName isEqualToString:@"cyl"] ) {
        [tmpResult setCylCount:[currentStringValue integerValue]];
    } else if ( [elementName isEqualToString:@"engsiz"] ) {
        [tmpResult setEngineSizeLit:[currentStringValue doubleValue]];
    } else if ( [elementName isEqualToString:@"engpow"] ) {
        [tmpResult setEnginePower:[currentStringValue integerValue]];
    } else if ( [elementName isEqualToString:@"safrat"] ) {
        [tmpResult setSaftyRating:[currentStringValue floatValue]];
    } else if ( [elementName isEqualToString:@"weight"] ) {
        [tmpResult setWeight:[currentStringValue integerValue]];
    } 
    
    //URLs
    else if ( [elementName isEqualToString:@"vid_url"] ) {
        [tmpResult setVid_url:currentStringValue];
    } else if ( [elementName isEqualToString:@"review_url"] ) {
        [tmpResult setReview_url:currentStringValue];
    } else if ( [elementName isEqualToString:@"specs_url"] ) {
        [tmpResult setSpecs_url:currentStringValue];
    }  
    
    
    
    // Reset string value to nil
    [currentStringValue release];
    currentStringValue = nil;
}



-(void) dealloc{
    [currentStringValue release];
    [tmpTradeoff release];
    [currentStringValue release];
    [tmpResult release];
    [super dealloc];
}

@end
