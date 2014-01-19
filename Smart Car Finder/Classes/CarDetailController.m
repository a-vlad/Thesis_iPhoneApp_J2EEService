//
//  CarDetailController.m
//  Smart Car Finder
//
//  Created by Vlad on 9/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CarDetailController.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageEffects.h"
#import "MapController.h"
#import "Smart_Car_FinderAppDelegate.h"


@implementation CarDetailController

@synthesize bodyTag,numSeatTag,tranTag,driveTag,engsizTag,powerTag;
@synthesize detailTable;
@synthesize carPicture;
@synthesize carReflection;
@synthesize infoScrollView;
@synthesize carResult;
@synthesize containerView;
@synthesize infoView;
@synthesize toolsView;

@synthesize	toolsButton;
@synthesize specButton;



#pragma mark Constants
const float reflHeight = 0.35;
const float reflAlpha = 0.65;
const float imgCornerRadius = 10;
const float containerAnimationTime = 0.4;


#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	//Set up corner favorites button
	UIBarButtonItem *favButton = [[UIBarButtonItem alloc]
									 initWithTitle:@"Favorite" style: UIBarButtonItemStylePlain target:self action:nil];
	self.navigationItem.rightBarButtonItem = favButton;
	[favButton release];
	
    
    //Set Detail view content
    [bodyTag setText:[NSString stringWithFormat:@"%d doors %@",[carResult doorCount],[carResult bodyStyle]]];
    [numSeatTag setText:[NSString stringWithFormat:@"%d",[carResult seatCount]]];
    [tranTag setText:[carResult transmission]];
    [driveTag setText:[carResult getFriendlyTranName]];
    [engsizTag setText:[NSString stringWithFormat:@"%d litres",[carResult engineSizeLit]]];
    [powerTag setText:[NSString stringWithFormat:@"%d kW",[carResult enginePower]]];
	
	//Set table cell heights to fit within view
	detailTable.rowHeight = 35;
	
	//Set transparant colours
	infoView.backgroundColor = [UIColor clearColor];
	infoScrollView.backgroundColor = [UIColor clearColor];
	toolsView.backgroundColor = [UIColor clearColor];
	
	//Set car spec info scroll view size
	[infoScrollView setContentSize:CGSizeMake(320,320)];
	//[infoView setContentSize:CGSizeMake(containerView.bounds.size.width, containerView.bounds.size.height)];
	
    
	
	// Animate the tool list view
    // set up an animation for the transition between the views
	CATransition *transition = [CATransition animation];
	[transition setDuration:containerAnimationTime+0.1];
	[transition setType:kCATransitionPush];
	[transition setSubtype:kCATransitionFromRight];
	[transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	[[containerView layer] addAnimation:transition forKey:@"SwitchToBasicInfoView"];
	[containerView addSubview:toolsView];

	
	//Round Corners
	carPicture.layer.masksToBounds = YES;
	carPicture.layer.cornerRadius = imgCornerRadius;
	//carPicture.layer.borderColor = [[UIColor grayColor] CGColor];
	//carPicture.layer.borderWidth = 0.5;	
    /**
	//Fancy Reflection
	NSUInteger reflectionHeight = carPicture.bounds.size.height * reflHeight;
	carReflection.image = [ImageEffects reflectedImage:carPicture withHeight:reflectionHeight];
	carReflection.alpha = reflAlpha;
	carReflection.layer.masksToBounds = YES;
	carReflection.layer.cornerRadius = imgCornerRadius;	
	**/
    [self fillCellCarPic:carResult];

	
	//Set up the background
	detailTable.backgroundColor = [UIColor clearColor];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg8.png"]];
}


//Separated for performance and used to set the cell car picture dynamically
- (void) fillCellCarPic:(CarResult*)res {
    
    //Set picture up 
    //Format: SERVER-URL/<MAKE>/<MODEL>/<YEAR>/<IMAGE-NAME>
    //Image name URL Format: <NO-OF-SEATS><BODY-STYLE-2CHAR><Optional: 1... INT>.JPG
    //Example: http://hesam.cse.unsw.edu.au:8080/drive-v225/car_images/Images/CHRYSLER/GRAND%20VOYAGER/2010/5FW.JPG
    NSString *carPicURL = [NSString stringWithFormat:@"%@%@/%@/%d/%@.JPG",
                           [Smart_Car_FinderAppDelegate photoServerAddress],
                           res.make,res.model,res.year,res.photoURL];
    

    NSLog(@"Loading car pic: %@",carPicURL);
    //Append space %20
    NSString *myUrlString = [carPicURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSData *picUrlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:myUrlString]];
    
    //Rough check valid picture data returned
    if(picUrlData != nil){
        [self.carReflection setHidden:NO];
        self.carPicture.contentMode = UIViewContentModeScaleToFill;
        self.carPicture.image = [UIImage imageWithData:picUrlData];
        //    self.carPicture.image = [UIImage imageNamed: @"VOLK3908.png"];
        
        
        //Transperancy recalculation
        int reflectionHeight = self.carPicture.bounds.size.height * reflHeight;
        self.carReflection.image = [ImageEffects reflectedImage:self.carPicture withHeight:reflectionHeight];
        self.carReflection.alpha = reflAlpha;
        self.carReflection.layer.masksToBounds = YES;
        self.carReflection.layer.cornerRadius = imgCornerRadius;	
        
        //[self.picLoadingIndicator setHidden:YES];
    } else {
        //Display placeholder image 
        self.carPicture.contentMode = UIViewContentModeScaleAspectFit;
        [self.carReflection setHidden:YES];
        self.carPicture.image = [UIImage imageNamed: @"blank_car.png"];    
        
        //Hide loading indicator
        //[self.picLoadingIndicator setHidden:YES]; 
    }       
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
	//Set top bar to black
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];		
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}
*/

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	
	//Set top bar to black
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];		
	
}

/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];	
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/







#pragma mark -
#pragma mark Event Handle Code

/* //OLD TRANSITION CODE FOR FLIP EFFECT
	[UIView transitionWithView:containerView
	duration:containerAnimationTime
	options:UIViewAnimationOptionTransitionFlipFromLeft
	animations:^{[[containerView.subviews lastObject] removeFromSuperview];
	[containerView addSubview:toolsView]; }
	completion:NULL];
*/
/*	-- OLD BUTTON HIGHLIGHT CODE
	//Change button selection images
	[toolsButton setBackgroundImage:[UIImage imageNamed:@"but2.png"] forState:UIControlStateNormal];
	[specButton setBackgroundImage:[UIImage imageNamed:@"but1.png"] forState:UIControlStateNormal];
	[critButton setBackgroundImage:[UIImage imageNamed:@"but1.png"] forState:UIControlStateNormal];
*/


//Change view to tools view
- (IBAction)eventShowTools{
	// set up an animation for the transition between the views
	CATransition *transition = [CATransition animation];
	[transition setDuration:containerAnimationTime];
	[transition setType:kCATransitionPush];
	[transition setSubtype:kCATransitionFromRight];
	[transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		
	[[containerView layer] addAnimation:transition forKey:@"SwitchToToolView"];

	// remove the current view and replace with new view
	[[containerView.subviews lastObject] removeFromSuperview];
	[containerView addSubview:toolsView];
}


- (IBAction)eventShowBasicInfo{
	// set up an animation for the transition between the views
	CATransition *transition = [CATransition animation];
	[transition setDuration:containerAnimationTime];
	[transition setType:kCATransitionPush];
	[transition setSubtype:kCATransitionFromRight];
	[transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[containerView layer] addAnimation:transition forKey:@"SwitchToBasicInfoView"];
	
	// remove the current view and replace with new view	
	[[containerView.subviews lastObject] removeFromSuperview];
	[containerView addSubview:infoView];
    
    //Flash scroll indicator
    [infoScrollView flashScrollIndicators];
}

- (IBAction)eventWatchVideoPressed{
    //Get Root Navigation View Controller:
    Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
    ExternalWebView *webView = [[ExternalWebView alloc] initWithNibName:@"ExternalWebView" bundle:nil];
    [webView setTitle:[NSString stringWithFormat:@"%@ %@",[carResult make],[carResult model]]];
    
    // self.navigationController will be nil once we are popped
    UINavigationController *navController = appDelegate.searchNavigation;

    // retain ourselves so that the controller will still exist once it's popped off
    [[self retain] autorelease];


    //Prepare video link
    NSString *videoUrl = [carResult vid_url];    
    NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 212\"/></head><body style=\"background:#F00;margin-top:0px;margin-left:0px\"><div><object width=\"320\" height=\"440\"><param name=\"movie\" value=\"%@\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"%@\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"320\" height=\"480\"></embed></object></div></body></html>",videoUrl,videoUrl]    ;

    //Sets the html content of the web view 
    [webView setUrlToLoad:htmlString];
    [navController pushViewController:webView animated:YES];

    [webView release];   
}


- (void)eventNavigateToLink:(NSString*)url{
    //Get Root Navigation View Controller:
    Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
    ExternalWebView *webView = [[ExternalWebView alloc] initWithNibName:@"ExternalWebView" bundle:nil];
    [webView setTitle:[NSString stringWithFormat:@"%@ %@",[carResult make],[carResult model]]];
    
    // self.navigationController will be nil once we are popped
    UINavigationController *navController = appDelegate.searchNavigation;
    
    // retain ourselves so that the controller will still exist once it's popped off
    [[self retain] autorelease];

    //URL Requst Object    

    
    
    [navController pushViewController:webView animated:YES];
    
    NSURL *formed_url = [NSURL URLWithString:url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:formed_url];
    [[webView webContainer] loadRequest:requestObj];
    
    [webView release];   
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Deselects selection for better focus on the checkbox
	[tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] animated:YES];
	
	
	//If map nearby dealerships selected -> load map view
	if (indexPath.row == 2){
		MapController *mapView = [[MapController alloc] initWithNibName:@"MapView" bundle:nil];
		mapView.title = @"Nearby Dealerships";
		
		Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
		[appDelegate.searchNavigation pushViewController:mapView animated:YES];
		
		[mapView release];
	} else if (indexPath.row == 0){
        [self eventNavigateToLink:[carResult review_url]];
    } else if (indexPath.row == 1){
        [self eventNavigateToLink:[carResult specs_url]];
    } 
}









#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Number of rows in online info tab 
    return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if(indexPath.row == 1) {
        cell.textLabel.text = @"Technical Data";
        cell.imageView.image = [UIImage imageNamed:@"graph3.png"];
    } else if(indexPath.row == 0) {
        cell.textLabel.text = @"Review Article";
        cell.imageView.image = [UIImage imageNamed:@"article.png"];
    } else if(indexPath.row == 2) {
        cell.textLabel.text = @"Dealerships";
        cell.imageView.image = [UIImage imageNamed:@"map6.png"];
    }
    
    
    return cell;
}







#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil
}


- (void)dealloc {
    [super dealloc];
}


@end

