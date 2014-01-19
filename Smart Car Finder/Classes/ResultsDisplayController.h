//
//  ResultsDisplayController.h
//  Smart Car Finder
//
//  Created by Vlad on 8/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchParameters.h"
#import "CarXMLParser.h"
#import "Smart_Car_FinderAppDelegate.h"


@interface ResultsDisplayController : UITableViewController {
	
	UITableView *resultsTable;
    NSMutableArray *carResults;    
    
    bool isSimilarCars;
    
    LGViewHUD *hud;
}

@property (nonatomic, retain) IBOutlet UITableView *resultsTable;
@property (nonatomic, retain) IBOutlet NSMutableArray *carResults;
@property (nonatomic) bool isSimilarCars;

- (void) getFromServerBySearchParameters:(id)sender;

@end
