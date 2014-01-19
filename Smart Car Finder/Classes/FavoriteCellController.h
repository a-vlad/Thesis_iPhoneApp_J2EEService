//
//  FavoriteCellControllerl.h
//  Smart Car Finder
//
//  Created by Vlad on 8/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FavoriteCellController : UITableViewCell {
	UILabel *carTitle;
	
	UIImageView *carPic;
}

@property (nonatomic, retain) IBOutlet UILabel *carTitle;

@property (nonatomic, retain) IBOutlet UIImageView *carPic;


- (IBAction)eventCarDetailsPressed;
- (void)setupCell;

@end
