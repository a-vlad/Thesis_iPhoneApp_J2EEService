//
//  Smart_Car_FinderAppDelegate.h
//  Smart Car Finder
//
//  Created by Vlad on 25/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "LifestyleParameterController.h"
#include "PriceFormController.h"
#include "SearchParameters.h"

@interface Smart_Car_FinderAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	
	UINavigationController *searchNavigation;
    
    SearchParameters *searchParams;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *searchNavigation;

@property (nonatomic, retain) SearchParameters *searchParams;


+(NSString*)serverAddress;

+(NSString*)photoServerAddress;

@end
