//
//  ExternalWebView.h
//  Smart Car Finder
//
//  Created by Vlad on 10/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExternalWebView : UIViewController {
    UIWebView *webContainer;
    
    NSString *urlToLoad;
    
}

@property (nonatomic,retain) IBOutlet UIWebView *webContainer;
@property (nonatomic,retain) NSString *urlToLoad;

@end
