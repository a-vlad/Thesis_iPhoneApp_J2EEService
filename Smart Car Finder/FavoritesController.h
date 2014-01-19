//
//  FavoritesController.h
//  Smart Car Finder
//
//  Created by Vlad on 23/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FavoritesController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

	UITableView *favTable;
	
}

@property (nonatomic, retain) IBOutlet UITableView *favTable;

@end
