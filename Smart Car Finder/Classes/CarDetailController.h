//
//  CarDetailController.h
//  Smart Car Finder
//
//  Created by Vlad on 9/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarResult.h"
#import "ExternalWebView.h"


@interface CarDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

	UIImageView *carPicture;
	UIImageView *carReflection;
	
	UITableView *detailTable;
	
	//Main views used to show related car info
	UIView *containerView;
	UIView *infoView;
	UIView *toolsView;
	
	UIButton *specButton;
	UIButton *toolsButton;
	
    CarResult *carResult;
	
    UILabel *bodyTag;
    UILabel *numSeatTag;    
    UILabel *tranTag;
    UILabel *driveTag;
    UILabel *engsizTag;
    UILabel *powerTag;
    
    
	UIScrollView *infoScrollView;
	

}
@property (nonatomic, retain) IBOutlet UILabel *bodyTag;
@property (nonatomic, retain) IBOutlet UILabel *numSeatTag;    
@property (nonatomic, retain) IBOutlet UILabel *tranTag;
@property (nonatomic, retain) IBOutlet UILabel *driveTag;
@property (nonatomic, retain) IBOutlet UILabel *engsizTag;
@property (nonatomic, retain) IBOutlet UILabel *powerTag;

@property (nonatomic, retain) CarResult *carResult;
@property (nonatomic, retain) IBOutlet UIButton	*specButton;
@property (nonatomic, retain) IBOutlet UIButton	*toolsButton;

@property (nonatomic, retain) IBOutlet UIScrollView *infoScrollView;

@property (nonatomic, retain) IBOutlet UIImageView *carPicture;
@property (nonatomic, retain) IBOutlet UIImageView *carReflection;

@property (nonatomic, retain) IBOutlet UITableView *detailTable;


@property (nonatomic, retain) IBOutlet UIView *infoView;
@property (nonatomic, retain) IBOutlet UIView *toolsView;

@property (nonatomic, retain) IBOutlet UIView *containerView;

- (IBAction)eventShowTools;
- (IBAction)eventShowBasicInfo;

- (IBAction)eventWatchVideoPressed;

- (void)eventNavigateToLink:(NSString*)url;


- (void) fillCellCarPic:(CarResult*)res;

@end
