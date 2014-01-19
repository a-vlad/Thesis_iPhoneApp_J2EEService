//
//  PriceFormController.h
//  Smart Car Finder
//
//  Created by Vlad on 26/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <math.h>
#import "SearchParameters.h"



@interface PriceFormController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

	UILabel *priceLabel;
	UISlider *priceSlider;
	
	UITableView *carFormTable;
	NSMutableArray *allOptions;
    FormFactor carFormFactor;
}

@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UISlider *priceSlider;
@property (nonatomic, retain) IBOutlet UITableView *carFormTable;

- (IBAction)eventSliderChange:(id)sender;
- (IBAction)eventNextPressed;
- (float) getExponentialPriceFloatFromSliderInt:(float)sliderValue;

@end
