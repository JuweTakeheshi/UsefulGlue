//
//  CAAnimation+Animations.h
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 2/4/13.
//  Copyright (c) 2013 Juwe Takeheshi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (Animations)

+ (CAAnimation *)flipAnimationWithDuration:(NSTimeInterval)aDuration forLayerBeginningOnTop:(BOOL)beginsOnTop scaleFactor:(CGFloat)scaleFactor;

@end
