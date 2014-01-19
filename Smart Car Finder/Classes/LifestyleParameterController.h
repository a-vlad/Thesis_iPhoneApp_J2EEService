//
//  LifestyleParameterController.h
//  Smart Car Finder
//
//  Created by Vlad on 5/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchParameters.h"
#import "LGViewHUD.h"

@interface LifestyleParameterController : UIViewController {
	
    UIScrollView *paramScrollView;
    UISegmentedControl *eco;
	UISegmentedControl *prf;
	UISegmentedControl *tow;
	UISegmentedControl *env;
	UISegmentedControl *lux;
	UISegmentedControl *siz;
	UISegmentedControl *saf;
    
    SearchParameters *searchParams;
	
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *eco;
@property (nonatomic, retain) IBOutlet UISegmentedControl *prf;
@property (nonatomic, retain) IBOutlet UISegmentedControl *tow;
@property (nonatomic, retain) IBOutlet UISegmentedControl *env;
@property (nonatomic, retain) IBOutlet UISegmentedControl *lux;
@property (nonatomic, retain) IBOutlet UISegmentedControl *siz;
@property (nonatomic, retain) IBOutlet UISegmentedControl *saf;

@property (nonatomic, retain) IBOutlet UIScrollView *paramScrollView;

@property (nonatomic, retain) SearchParameters *searchParams;


//Action for when user initiates search
- (IBAction)eventSearchPressed;

//Used to pass parameters inputed on screen 1 : price and body style
- (void)passParams:(SearchParameters*)params;

@end
