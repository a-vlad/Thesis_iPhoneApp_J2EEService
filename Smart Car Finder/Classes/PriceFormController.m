//
//  PriceFormController.m
//  Smart Car Finder
//
//  Created by Vlad on 26/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PriceFormController.h"
#import <QuartzCore/QuartzCore.h>
#import "LifestyleParameterController.h"
#import "Smart_Car_FinderAppDelegate.h"

@implementation PriceFormController

@synthesize priceLabel;
@synthesize priceSlider;
@synthesize carFormTable; 




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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	//Initialise car form lists
	allOptions = [[NSMutableArray alloc] initWithObjects:@"Family Cars", @"City Cars", @"Sports Cars", @"Off-Road Cars", nil];
	
	carFormTable.backgroundColor = [UIColor clearColor];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg9.png"]];
    carFormFactor = FAMILYVALUE;
}






#pragma mark -
#pragma mark Car Form TableView Methods


// Return the number of rows in a section
-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return 4;
}


// Returns cell to render for each row
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"CellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	
    // Configure the cell...
	cell.textLabel.text = [allOptions objectAtIndex:indexPath.row];	
	//Configure Icon image
	cell.imageView.layer.masksToBounds = YES;
	cell.imageView.layer.cornerRadius = 10.0;
	cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"car%d.png", indexPath.row]];

	
	//Set default selection to family car
	if(indexPath.row == 0) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		cell.textLabel.textColor = [UIColor colorWithRed:0 green:0.25 blue:0.55 alpha:1];
	};

	
	return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Deselects selection for better focus on the checkbox
	[tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] animated:YES];
	
	//Set all cells to un-checked
	for (int i = 0; i < 4; i++) {
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		cell.accessoryType = UITableViewCellAccessoryNone;		
		cell.textLabel.textColor = [UIColor blackColor];
	}
	
	//Check selected cell
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	cell.textLabel.textColor = [UIColor colorWithRed:0 green:0.25 blue:0.55 alpha:1];
	
    //Save selecion to car form value
    carFormFactor = 3000 + indexPath.row;

}









#pragma mark -
#pragma mark IBAction Methods



- (IBAction)eventSliderChange:(id)sender
{

	int finalPrice = [self getExponentialPriceFloatFromSliderInt:priceSlider.value];
	NSString *priceString = [[NSString alloc] init];
	
	if(finalPrice < 150){
		priceString = [NSString stringWithFormat:@"Maximum $%d,000", finalPrice];
	}else if (finalPrice > 150){
		priceString = @"At lease $150,000";
	}
	
	priceLabel.text = priceString;
	
}




- (IBAction)eventNextPressed
{
	LifestyleParameterController *lifestyleView = [[LifestyleParameterController alloc] initWithNibName:@"FinderLifestyleSelection" bundle:nil];
	lifestyleView.title = @"Your Factors";
    
    //Create initial search parameter object and populate with form and price
    SearchParameters *parameters = [[SearchParameters alloc] init];    
    [parameters setMaxPrice: [self getExponentialPriceFloatFromSliderInt:priceSlider.value]*1000];
    [parameters setCarFormFactor: carFormFactor ];
    
    //Pass parameter pointer to lifestyleFactor controller
    [lifestyleView passParams:parameters];

	Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
	[appDelegate.searchNavigation pushViewController:lifestyleView animated:YES];
    
	[lifestyleView release];
    
}

//As name suggests, 
//TODO: Can be improved for better usability
- (float) getExponentialPriceFloatFromSliderInt:(float)sliderValue{
    int roundedPriceSelected = (int)(sliderValue);
	float exponentialFactor = (int)roundedPriceSelected * (int)roundedPriceSelected;
	return 15+(int)((long)exponentialFactor/100);
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
	[allOptions release];
	
    [super dealloc];
}


@end
