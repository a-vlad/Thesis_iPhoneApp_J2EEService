//
//  ExternalWebView.m
//  Smart Car Finder
//
//  Created by Vlad on 10/07/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ExternalWebView.h"


@implementation ExternalWebView
@synthesize webContainer, urlToLoad;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Check that the html of the web view has been set by the previous view
    if(urlToLoad != nil){
        //Create a URL object.
        //NSURL *url = [NSURL URLWithString:urlToLoad];
        
        //URL Requst Object
       // NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        
            NSLog(@"%@",urlToLoad);
        
        //Load the request in the UIWebView.
        //[webContainer loadRequest:requestObj];
        
        [webContainer loadHTMLString:urlToLoad baseURL:nil];
//        [webContainer loadHTMLString:urlToLoad baseURL:nil];
        
        //MPMoviePlayerController *player =[[MPMoviePlayerController alloc] initWithContentURL: url];
        //[[player view] setFrame: [myView bounds]];  // frame must match parent view
        //[myView addSubview: [player view]];
        //[player play];


    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
