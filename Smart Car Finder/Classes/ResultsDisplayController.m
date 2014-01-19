    //
//  ResultsDisplayController.m
//  Smart Car Finder
//
//  Created by Vlad on 8/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultsDisplayController.h"
#import "CarResultCell.h"

#import <QuartzCore/QuartzCore.h>
#import "ImageEffects.h"
#import "CarResult.h"
#import "CarXMLParser.h"


@implementation ResultsDisplayController

@synthesize resultsTable,carResults,isSimilarCars;

const int cellHeight = 367;
const int lastCellHeight = 125;


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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/





// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Setup table background
	//resultsTable.backgroundColor = [UIColor clearColor];
	//self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg4.png"]];		

	
	//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];		
	
	//- [[UIApplication sharedApplication] 
	//   setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];		
	//- [[UIApplication sharedApplication] 
	//   setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

}




-(void) viewWillAppear:(BOOL)animated
{
    if (!carResults){
        //Show loading HUD
        hud = [LGViewHUD defaultHUD];
        hud.activityIndicatorOn=YES;
        hud.topText=@"";
        hud.bottomText=@"Finding cars...";
        [hud showInView:self.view withAnimation:HUDAnimationShowZoom];
    }
    
    //Background hack for fluent transition between views
	resultsTable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg4.png"]];
}




- (void) viewDidAppear:(BOOL)animated
{
    //Background hack for fluent transition between views
	self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg4.png"]];	
	resultsTable.backgroundColor = [UIColor clearColor];		
    
    //If the results table has not been initialized
    if (!carResults){ //[self getFromServerBySearchParameters];
        [self performSelector:@selector(getFromServerBySearchParameters:) withObject:self afterDelay:0.0];
    } else {
        //If populated reload data to apply
        [resultsTable reloadData];  
    }
    
    
    //Flash scroll indicator
    [resultsTable flashScrollIndicators];
}

    
- (void)getFromServerBySearchParameters:(id)sender{
    //Setup result data array with content fed through the XML parser 
    
    Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
    SearchParameters *searchParams = [appDelegate searchParams];
    [self setIsSimilarCars:NO]; //default from parameter search no
    
    NSString *queryString = [NSString stringWithFormat:@"%@controller?operation=findcars&carFormFactor=%@&maxPrice=%f&tow=%f&prf=%f&lux=%f&eco=%f&siz=%f&env=%f&saf=%f",
                             [Smart_Car_FinderAppDelegate serverAddress],
                             [searchParams getCarStyleInString],
                             [searchParams maxPrice],
                             [searchParams tow],
                             [searchParams prf],
                             [searchParams lux],
                             [searchParams eco],
                             [searchParams siz],
                             [searchParams env],
                             [searchParams saf]];
    
    NSLog(@"PARAMETER QUERY: %@",queryString);
    
    CarXMLParser *parser = [[CarXMLParser alloc] init]; 
    carResults = [parser convertXMLToResultArray:queryString];
    
    if(carResults){     //Checks SERVER ERROR Display error
        [resultsTable reloadData];        
        
        //Hide HUD
        [hud hideWithAnimation:HUDAnimationHideZoom];
    } else {        
        
        //Show Error HUD
        hud.image=[UIImage imageNamed:@"rounded-fail.png"];
        hud.topText=@"";
        hud.bottomText=@"Connection Error";  
        [hud showInView:self.view];
        
        //If no server reply or bad reply
        if(carResults==nil){

            //Pop Results display controller after 1.5 seconds
            [NSTimer scheduledTimerWithTimeInterval:2.5
                                             target:self
                                           selector:@selector(pushBack)
                                           userInfo:nil
                                            repeats:NO];
        }
    }        
}

-(void)pushBack{
    [self.navigationController popViewControllerAnimated:YES];
}
    



#pragma mark -
#pragma mark TableView methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(carResults == nil) return 0;
    
    return [carResults count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.row == [carResults count]) {
		return lastCellHeight;
	} else {
		return cellHeight;
	}
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
	
	CarResultCell *cell = (CarResultCell *) [tableView dequeueReusableCellWithIdentifier:@"CarResultCell"];
	
	//Special case for last cell in table
	if (indexPath.row == [carResults count]) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ResultCell" owner:self options:nil];
		cell = [topLevelObjects objectAtIndex:1];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //No cars found
        if([carResults count] == 0){
            [cell.infoCellText setText:@"There are no cars matching your search. Try changing your maximum price."];
        }
        
		return cell;
	}
		
	//Case for car result cell
    if (cell == nil) {		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ResultCell" owner:self options:nil];
		cell = [topLevelObjects objectAtIndex:0];
        
		[cell setupCell];

	}
    
    //If first cell show arrow
    if (indexPath.row == 0){
        [cell showDownArrow];
    } else {
        [cell hideDownArrow];
    }
    
    [cell fillCellWithCarResult:[carResults objectAtIndex:indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	//NSLog(@"cell pressed");
}


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
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    //[carResults release];
    //[queryString release];
    //[searchParams release];
    //[hud release];
    [super dealloc];
}


@end
