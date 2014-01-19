    //
//  LifestyleParameterController.m
//  Smart Car Finder
//
//  Created by Vlad on 5/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LifestyleParameterController.h"
#import "ResultsDisplayController.h"
#import "Smart_Car_FinderAppDelegate.h"
#import "CarXMLParser.h"
#import "CarResult.h"


@implementation LifestyleParameterController

@synthesize paramScrollView,searchParams;
@synthesize prf,eco,tow,lux,siz,saf,env;

const float NUMBER_OF_SEGMENTS = 5.0;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
/*
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
    //DEPRECATED: Due to usability issues the search button right of the Navigation Bar has been removed
	//Set up top button to initiate search
	//UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]
	//							initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
	//							target:self
	//							action:@selector(eventSearchPressed)];
	//self.navigationItem.rightBarButtonItem = searchButton;
	//[searchButton release];
	
	//Set scroll view size
	[paramScrollView setContentSize:CGSizeMake(paramScrollView.bounds.size.width, paramScrollView.bounds.size.height)];
	

    
	//Performance improvements
	//carPic.layer.shouldRasterize = YES;
	//carPic.layer.rasterizationScale = [UIScreen mainScreen].scale;
	
	//view.layer.shouldRasterize = YES;
	//self.layer.rasterizationScale = [UIScreen mainScreen].scale;
	
}

//Sets the collected search parameters from previous input views
- (void)passParams:(SearchParameters*)params{
    self.searchParams = params;
}


-(void) viewWillAppear:(BOOL)animated{
    [paramScrollView flashScrollIndicators];  //flash scroll indicator
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg9.png"]];
}


- (void) viewDidAppear:(BOOL)animated{
    [paramScrollView flashScrollIndicators];   //flash scroll indicator
	self.view.backgroundColor = [UIColor clearColor];		
	self.parentViewController.view.backgroundColor = 
                                [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg9.png"]];	
}


- (IBAction)eventSearchPressed
{
    //Save search parameters to parameter object
    [searchParams setEco:(float)eco.selectedSegmentIndex/NUMBER_OF_SEGMENTS];
    [searchParams setPrf:(float)prf.selectedSegmentIndex/NUMBER_OF_SEGMENTS];
    [searchParams setLux:(float)lux.selectedSegmentIndex/NUMBER_OF_SEGMENTS];
    [searchParams setEnv:(float)env.selectedSegmentIndex/NUMBER_OF_SEGMENTS];
    [searchParams setTow:(float)tow.selectedSegmentIndex/NUMBER_OF_SEGMENTS];
    [searchParams setSaf:(float)saf.selectedSegmentIndex/NUMBER_OF_SEGMENTS];
    if(siz.selectedSegmentIndex == 0){
        [searchParams setSiz:-1]; //-1 represents any   
    }else{
        [searchParams setSiz:siz.selectedSegmentIndex];  
    }
    
    [searchParams printToString];

    // Navigation logic may go here. Create and push another view controller.
    Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
    ResultsDisplayController *resultView = [[ResultsDisplayController alloc] initWithNibName:@"ResultsDisplay" bundle:nil];
    [resultView setTitle:@"Results"];
    //SET parameters as GLOBAL SINGLETON inside app delegate
    [appDelegate setSearchParams:searchParams]; 

    [appDelegate.searchNavigation pushViewController:resultView animated:YES];
    [resultView release];
    
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[paramScrollView release];
    [super dealloc];
}


@end
