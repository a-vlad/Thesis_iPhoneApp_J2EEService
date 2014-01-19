//
//  MapController.h
//  Smart Car Finder
//
//  Created by Vlad on 16/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapController : UIViewController {
	MKMapView *map;
}
@property (nonatomic, retain) IBOutlet MKMapView *map;

@end
