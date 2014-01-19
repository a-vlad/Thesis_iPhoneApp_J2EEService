//
//  ImageEffects.h
//  Smart Car Finder
//
//  Created by Vlad on 9/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageEffects : NSObject {

}

+ (UIImage *)reflectedImage:(UIImageView *)fromImage withHeight:(NSUInteger)height;
CGContextRef MyCreateBitmapContext(int pixelsWide, int pixelsHigh);
CGImageRef CreateGradientImage(int pixelsWide, int pixelsHigh);

@end
