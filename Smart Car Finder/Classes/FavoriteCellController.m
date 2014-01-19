//
//  FavoriteCellController.m
//  Smart Car Finder
//
//  Created by Vlad on 8/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteCellController.h"
#import "Smart_Car_FinderAppDelegate.h"

#import <QuartzCore/QuartzCore.h>
#import "ImageEffects.h"


@implementation FavoriteCellController

@synthesize carTitle;
@synthesize carPic;


const float favIconReflHeight = 0.15;
const float favIconReflAlpha = 0.65;
const float favIconImgCornerRadius = 20;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	
	return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
	
    // Configure the view for the selected state
}



//Sets up cell attributes
- (void)setupCell
{
	if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.0) {	
		//Create the car using the  picture
		UIImageView *carView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VOLK3908.png"]];
		carView.layer.masksToBounds = YES;
		carView.layer.cornerRadius = favIconImgCornerRadius;
		//Set the image size to match the shadow size
		CGRect newFrame = carView.frame;
		newFrame.size = CGSizeMake(carPic.frame.size.width, carPic.frame.size.height);
		carView.frame = newFrame;
		
		
		//Set the car picture container to hold the shadow
		carPic.layer.cornerRadius = favIconImgCornerRadius;
		carPic.layer.shadowColor = [[UIColor blackColor] CGColor];
		carPic.layer.shadowOpacity = 0.3;
		carPic.layer.shadowRadius = 3.0;
		carPic.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
		carPic.layer.shadowPath = 
				[UIBezierPath bezierPathWithRoundedRect:carPic.bounds 
							cornerRadius:favIconImgCornerRadius].CGPath;	
		//Add picture on top of shadow
		[carPic addSubview:carView];

		[carView release];
		
		//Should improve drawing performance by caching view
		carPic.layer.shouldRasterize = YES;
		carPic.layer.rasterizationScale = [UIScreen mainScreen].scale;
		self.layer.shouldRasterize = YES;
		self.layer.rasterizationScale = [UIScreen mainScreen].scale;
	} else {
		//Load car picture directly with no shadows
		carPic.image = [UIImage imageNamed:@"VOLK3908.png"];
		carPic.layer.masksToBounds = YES;
		carPic.layer.cornerRadius = favIconImgCornerRadius;
	}
	
	//Make table un-selectable
	self.selectionStyle = UITableViewCellSelectionStyleNone;
}





#pragma mark -
#pragma mark IBAction Methods


- (IBAction)eventCarDetailsPressed
{	
	//CarDetailController *detailView = [[CarDetailController alloc] initWithNibName:@"DetailView" bundle:nil];
	//detailView.title = @"Car Details";
	
	
	//Smart_Car_FinderAppDelegate *appDelegate = (Smart_Car_FinderAppDelegate*)[[UIApplication sharedApplication] delegate];
	//[appDelegate.searchNavigation pushViewController:detailView animated:YES];
	
	//[detailView release];
}






- (void)dealloc {
    [super dealloc];
}


@end
