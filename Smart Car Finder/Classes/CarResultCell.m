//
//  CarResultCell.m
//  Smart Car Finder
//
//  Created by Vlad on 8/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CarResultCell.h"
#import "CarDetailController.h"
#import "Smart_Car_FinderAppDelegate.h"

#import <QuartzCore/QuartzCore.h>
#import "ImageEffects.h"


@implementation CarResultCell


@synthesize carTitle;
@synthesize carPrice;
@synthesize carPic;
@synthesize carRefl;

@synthesize crit1;
@synthesize crit2;
@synthesize crit3;
//@synthesize crit4;
@synthesize cellResult;
@synthesize hud;
@synthesize carDetailLine,carTopOfListNotice;
@synthesize downArrow;
@synthesize picLoadingIndicator;
@synthesize infoCellText;
const float iconReflHeight = 0.20;
const float iconReflAlpha = 0.50;
const float iconImgCornerRadius = 12;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	
	return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
}


//Called each time a user flips through the list and sets next cell content on-fly
- (void)fillCellWithCarResult:(CarResult *)res{
    
    //Set cell result
    cellResult = res;
    
    //Set cell title
    carTitle.text = [NSString stringWithFormat:@"%d %@ %@",res.year,res.make,res.model];
    carDetailLine.text = [NSString stringWithFormat:@"%d door %@", res.doorCount, res.bodyStyle];
    //carTopOfListNotice.text = [NSString stringWithFormat:@"%@",res.bestAtTag];
    carTopOfListNotice.text = [NSString stringWithFormat:@"%@ %d cylinder",[res getFriendlyTranName],[res cylCount]];
    
    //Set car price
    NSMutableString *formattedPrice = [NSMutableString stringWithFormat:@"$%d", res.price];
    [formattedPrice insertString:@"," atIndex:([formattedPrice length]-3)];
    carPrice.text = formattedPrice;
    
    
    //Populate tradeoff button labels
    Tradeoff *tradeoff = nil;
    
    //Cascading check for how many tradeoffs present to display
    
    if([res.tradeoffs count]>0){
        tradeoff = (Tradeoff*)[res.tradeoffs objectAtIndex:0];
        crit1.titleLabel.textAlignment = UITextAlignmentCenter;
        [crit1 setTitle:[tradeoff getButtonLabel] forState:UIControlStateNormal];

        if([res.tradeoffs count]>1){
            tradeoff = (Tradeoff*)[res.tradeoffs objectAtIndex:1];
            crit2.titleLabel.textAlignment = UITextAlignmentCenter;
            [crit2 setTitle:[tradeoff getButtonLabel] forState:UIControlStateNormal];    
            

            if([res.tradeoffs count]>2){
                tradeoff = (Tradeoff*)[res.tradeoffs objectAtIndex:2];
                crit3.titleLabel.textAlignment = UITextAlignmentCenter;    
                [crit3 setTitle:[tradeoff getButtonLabel] forState:UIControlStateNormal];
            } else {
                crit3.hidden = YES;
            }
        } else {
            crit2.hidden = YES;
        }
    } else {
        crit1.hidden = YES;
    }
    

    
    //tradeoff = (Tradeoff*)[res.tradeoffs objectAtIndex:3];
    //crit4.titleLabel.textAlignment = UITextAlignmentCenter;
    //[crit4 setTitle:[tradeoff getButtonLabel] forState:UIControlStateNormal];
    
    //Default state is blank
    self.carPic.contentMode = UIViewContentModeScaleAspectFit;
    [self.carRefl setHidden:YES]; 
    self.carPic.image = [UIImage imageNamed: @"blank_car.png"];  

    
    //Allows for the cell to finish its animation before loading picture
    [self performSelector:@selector(fillCellCarPicture:) withObject:res afterDelay:0.1];
    
}


//Separated for performance and used to set the cell car picture dynamically
- (void) fillCellCarPicture:(CarResult*)res {
    
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
            //if(picUrlData == nil){
        [self.carRefl setHidden:NO];
        self.carPic.contentMode = UIViewContentModeScaleToFill;
        self.carPic.image = [UIImage imageWithData:picUrlData];
        //            self.carPic.image = [UIImage imageNamed: @"VOLK3908.png"];
        
        //Transperancy recalculation
        int reflectionHeight = self.carPic.bounds.size.height * iconReflHeight;
        self.carRefl.image = [ImageEffects reflectedImage:self.carPic withHeight:reflectionHeight];
        self.carRefl.alpha = iconReflAlpha;
        self.carRefl.layer.masksToBounds = YES;
        self.carRefl.layer.cornerRadius = iconImgCornerRadius;	

        [self.picLoadingIndicator setHidden:YES];
    } else {
        //Display placeholder image 
        self.carPic.contentMode = UIViewContentModeScaleAspectFit;
        [self.carRefl setHidden:YES];
        self.carPic.image = [UIImage imageNamed: @"blank_car.png"];    
        
        //Hide loading indicator
        [self.picLoadingIndicator setHidden:YES]; 
    }       

}


// HELPER INIT METHOD //
//Sets up cell attributes only called once and used for all cells
- (void)setupCell
{
    //Set car picture formating
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.carPic.layer.masksToBounds = YES;
	self.carPic.layer.cornerRadius = iconImgCornerRadius;
	//self.carPic.layer.borderColor = [[UIColor grayColor] CGColor];
	self.carPic.layer.borderWidth = 0;
	
	
	//Fancy Reflection
	int reflectionHeight = self.carPic.bounds.size.height * iconReflHeight;
	self.carRefl.image = [ImageEffects reflectedImage:self.carPic withHeight:reflectionHeight];
	self.carRefl.alpha = iconReflAlpha;
	self.carRefl.layer.masksToBounds = YES;
	self.carRefl.layer.cornerRadius = iconImgCornerRadius;	
	
    
    // Make down arrow hidden by default
    [self.downArrow setHidden:YES];
	
	//Improves drawing performance on IOS 4 or higher using image rasterization 
	if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.0) {
	
		//RESTERIZATION FOR PERFORMANCE
		self.carPic.layer.shouldRasterize = YES;
		self.carPic.layer.rasterizationScale = [UIScreen mainScreen].scale;
	
		self.carRefl.layer.shouldRasterize = YES;
		self.carRefl.layer.rasterizationScale = [UIScreen mainScreen].scale;

		self.crit1.layer.shouldRasterize = YES;
		self.crit1.layer.rasterizationScale = [UIScreen mainScreen].scale;
		self.crit2.layer.shouldRasterize = YES;
		self.crit2.layer.rasterizationScale = [UIScreen mainScreen].scale;
		self.crit3.layer.shouldRasterize = YES;
		self.crit3.layer.rasterizationScale = [UIScreen mainScreen].scale;
		//self.crit4.layer.shouldRasterize = YES;
		//self.crit4.layer.rasterizationScale = [UIScreen mainScreen].scale;
	
		self.carTitle.layer.shouldRasterize = YES;
		self.carTitle.layer.rasterizationScale = [UIScreen mainScreen].scale;
		
		self.layer.shouldRasterize = YES;
		self.layer.rasterizationScale = [UIScreen mainScreen].scale;
		
	}
	
	
}









#pragma mark -
#pragma mark IBAction Methods

// ACTION EVENT METHODS //


- (IBAction)eventTradeoff1Pressed{
    
    //Find tradeoff and initiate tradeoff new search
    CarResult *res = [self cellResult];
    Tradeoff *tradeoff = [[res tradeoffs] objectAtIndex:0];
    [self displayTradeoffLoadingScreen:tradeoff];   //Show loading splays screen
    //Execute tradeoff search    
    [self performSelector:@selector(newSearchFromTradeoff:) withObject:tradeoff afterDelay:0.1];
}
- (IBAction)eventTradeoff2Pressed{
    //Find tradeoff and initiate tradeoff new search
    CarResult *res = [self cellResult];
    Tradeoff *tradeoff = [[res tradeoffs] objectAtIndex:1];
    [self displayTradeoffLoadingScreen:tradeoff];   //Show loading splays screen
    //Execute tradeoff search
    [self performSelector:@selector(newSearchFromTradeoff:) withObject:tradeoff afterDelay:0.1];
}
- (IBAction)eventTradeoff3Pressed{
    //Find tradeoff and initiate tradeoff new search
    CarResult *res = [self cellResult];
    Tradeoff *tradeoff = [[res tradeoffs] objectAtIndex:2];
    [self displayTradeoffLoadingScreen:tradeoff];   //Show loading splays screen
    //Execute tradeoff search
    [self performSelector:@selector(newSearchFromTradeoff:) withObject:tradeoff afterDelay:0.1];
}
/*
- (IBAction)eventTradeoff4Pressed{
    //Find tradeoff and initiate tradeoff new search
    CarResult *res = [self cellResult];
    Tradeoff *tradeoff = [[res tradeoffs] objectAtIndex:3];
    [self displayTradeoffLoadingScreen:tradeoff];   //Show loading splays screen
    //Execute tradeoff search
    [self performSelector:@selector(newSearchFromTradeoff:) withObject:tradeoff afterDelay:0.1];
}
*/


- (IBAction)eventSimilarCarsPressed{
    //Find tradeoff and initiate tradeoff new search
    CarResult *res = [self cellResult];
    [self displayTradeoffLoadingScreen:nil];   //Show generic loading screen
    
    //Search for similar cars
    [self performSelector:@selector(newSearchForSimilarToID:) withObject:res afterDelay:0.1];
}


- (IBAction)eventCarDetailsPressed
{	
	CarDetailController *detailView = [[CarDetailController alloc] initWithNibName:@"DetailView" bundle:nil];
	detailView.title = @"Details";
    [detailView setCarResult:cellResult];
		
	Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
	[appDelegate.searchNavigation pushViewController:detailView animated:YES];
	
	[detailView release];
}




// CLASS METHODS //


- (void) displayTradeoffLoadingScreen:(Tradeoff*) tradeoff{
    //Show loading HUD, autorelease at end of IbAction
    hud = [LGViewHUD tradeoffLoadHUD];
    hud.activityIndicatorOn=YES;
    hud.topText=@"";
    hud.bottomText=@"Loading cars...";
    [hud showInView:self withAnimation:HUDAnimationShowZoom];   
}

- (void) showDownArrow {
    [self.downArrow setHidden:NO];
}

- (void) hideDownArrow {
    [self.downArrow setHidden:YES];
}


- (void)newSearchFromTradeoff:(Tradeoff*)tradeoff{
    Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
    SearchParameters *searchParams = [appDelegate searchParams];
    

    NSString *queryString = [NSString stringWithFormat:@"%@controller?operation=findcarsbyid&carFormFactor=%@&maxPrice=%f&tow=%f&prf=%f&lux=%f&eco=%f&siz=%f&env=%f&saf=%f&ids=%@",
                            [Smart_Car_FinderAppDelegate serverAddress],
                            [searchParams getCarStyleInString],
                            [searchParams maxPrice],
                            [searchParams tow],
                            [searchParams prf],
                            [searchParams lux],
                            [searchParams eco],
                            [searchParams siz],
                            [searchParams env],
                            [searchParams saf],
                            [tradeoff resultsString]];
    
    
    NSLog(@"TRADEOFF QUERY: %@",queryString);
    
    
    //Parse URL XML Reply
    CarXMLParser *parser = [[CarXMLParser alloc] init]; 
    NSMutableArray *newcarResults = [parser convertXMLToResultArray:queryString];
    
    if(newcarResults){     //Checks Valid Server Reply
        
        //Get Root Navigation View Controller:
        Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
        ResultsDisplayController *resultView = [[ResultsDisplayController alloc] initWithNibName:@"ResultsDisplay" bundle:nil];
        [resultView setTitle:@"Results"];
        [resultView setCarResults:newcarResults];
        [resultView setIsSimilarCars:NO];
        
        //Hub Hides automatically from autorelease
        [hud hideWithAnimation:HUDAnimationHideZoom];
        
        // locally store the navigation controller since
        // self.navigationController will be nil once we are popped
        UINavigationController *navController = appDelegate.searchNavigation;
        
        // retain ourselves so that the controller will still exist once it's popped off
        [[self retain] autorelease];
        
        // Pop this controller and replace with another
        [navController popViewControllerAnimated:NO];
        [navController pushViewController:resultView animated:YES];
        
        [resultView release];        
    } else {                
        
        //Show Error HUD
        [hud hideWithAnimation:HUDAnimationHideZoom];
        hud.image=[UIImage imageNamed:@"rounded-fail.png"];
        hud.topText=@"";
        hud.bottomText=@"Connection Error";  
        [hud showInView:self withAnimation:HUDAnimationShowZoom];
    }
    
}




//Searches for similar cars given the clicked car result
- (void)newSearchForSimilarToID:(CarResult*)carResult{
    
    Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
    SearchParameters *searchParams = [appDelegate searchParams];
    
    
    NSString *queryString = [NSString stringWithFormat:@"%@controller?operation=findcarsbyid&carFormFactor=%@&maxPrice=%f&tow=%f&prf=%f&lux=%f&eco=%f&siz=%f&env=%f&saf=%f&carId=%@",
                             [Smart_Car_FinderAppDelegate serverAddress],
                             [searchParams getCarStyleInString],
                             [searchParams maxPrice],
                             [searchParams tow],
                             [searchParams prf],
                             [searchParams lux],
                             [searchParams eco],
                             [searchParams siz],
                             [searchParams env],
                             [searchParams saf],
                             [carResult carId]];
    
    
    NSLog(@"SIMILAR CAR QUERY: %@",queryString);
    
    
    
    //Parse URL XML Reply
    CarXMLParser *parser = [[CarXMLParser alloc] init]; 
    NSMutableArray *newcarResults = [parser convertXMLToResultArray:queryString];
    
    if(newcarResults){     //Checks Valid Server Reply
        
        //Get Root Navigation View Controller:
        Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
        ResultsDisplayController *resultView = [[ResultsDisplayController alloc] initWithNibName:@"ResultsDisplay" bundle:nil];
        [resultView setTitle:@"Similar Cars"];
        [resultView setCarResults:newcarResults];            //Set next Views Car ResultSet 
        [resultView setIsSimilarCars:YES];          //used to specify it is similar car formatting
        
        //Hub Hides automatically from autorelease
        [hud hideWithAnimation:HUDAnimationHideZoom];
        
        // locally store the navigation controller since
        // self.navigationController will be nil once we are popped
        UINavigationController *navController = appDelegate.searchNavigation;
        
        // retain ourselves so that the controller will still exist once it's popped off
        [[self retain] autorelease];
        
        //Will not pop view so user may return to previous page
        //[navController popViewControllerAnimated:NO];  
        [navController pushViewController:resultView animated:YES];
        
        [resultView release];        
    } else {                
        
        //Show Error HUD
        [hud hideWithAnimation:HUDAnimationHideZoom];
        hud.image=[UIImage imageNamed:@"rounded-fail.png"];
        hud.topText=@"";
        hud.bottomText=@"Connection Error";  
        [hud showInView:self withAnimation:HUDAnimationShowZoom];
    }
    
}



- (void)dealloc {
    //[cellResult release];
    //[hud release];
    [super dealloc];
}


@end
