//
//  CarResultCell.h
//  Smart Car Finder
//
//  Created by Vlad on 8/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarResult.h"
#import "Tradeoff.h"
#import "LGViewHUD.h"
#import "CarXMLParser.h"
#import "ResultsDisplayController.h"
#import "Smart_Car_FinderAppDelegate.h"

@interface CarResultCell : UITableViewCell {
    
	UILabel *carTitle;
    UILabel *carDetailLine;
	UILabel *carPrice;
	UILabel *carTopOfListNotice;
    UILabel *infoCellText;
    
	UIImageView *carPic;
	UIImageView *carRefl;
	UIImageView *downArrow;
    
	UIButton *crit1;
	UIButton *crit2;
	UIButton *crit3;
    
    UIActivityIndicatorView *picLoadingIndicator;
	//UIButton *crit4; 
    //NOTE:Cut out because became too cluttered may be enabled and reintroduced for 4   crtiques in the future if necceserry
    // The CarResult still is stored with 4 critiques.
		
    CarResult *cellResult;
    
    LGViewHUD *hud;
    
}

@property (nonatomic, retain) IBOutlet UILabel *carTitle;
@property (nonatomic, retain) IBOutlet UILabel *carPrice;
@property (nonatomic, retain) IBOutlet UILabel *carDetailLine;
@property (nonatomic, retain) IBOutlet UILabel *carTopOfListNotice;
@property (nonatomic, retain) IBOutlet UILabel *infoCellText;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *picLoadingIndicator;

@property (nonatomic, retain) IBOutlet UIImageView *carPic;
@property (nonatomic, retain) IBOutlet UIImageView *carRefl;
@property (nonatomic, retain) IBOutlet UIImageView *downArrow;

@property (nonatomic, retain) IBOutlet UIButton *crit1;
@property (nonatomic, retain) IBOutlet UIButton *crit2;
@property (nonatomic, retain) IBOutlet UIButton *crit3;
//@property (nonatomic, retain) IBOutlet UIButton *crit4;
@property (nonatomic, retain) CarResult *cellResult;
@property (nonatomic, retain) LGViewHUD *hud;


- (IBAction)eventTradeoff1Pressed;
- (IBAction)eventTradeoff2Pressed;
- (IBAction)eventTradeoff3Pressed;
//- (IBAction)eventTradeoff4Pressed;
- (IBAction)eventCarDetailsPressed;
- (IBAction)eventSimilarCarsPressed;




//SEARCH METHODS
//Used to initiate new searches
- (void)newSearchFromTradeoff:(Tradeoff*)tradeoff;
- (void)newSearchForSimilarToID:(CarResult*)carResult;


//CONSTRUCTION
//Sets up all cell effects and rendering properties
- (void)setupCell;
//Fills up cell car information with CarResult content
- (void)fillCellWithCarResult:(CarResult *)res;

//LIVE INFORMATION
//Shows the loading splash when a tradeoff is clicked
- (void) displayTradeoffLoadingScreen:(Tradeoff*) tradeoff;
- (void) showDownArrow;
- (void) hideDownArrow;

@end
