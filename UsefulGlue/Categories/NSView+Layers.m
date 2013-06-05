//
//  NSView+Layers.m
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 2/4/13.
//  Copyright (c) 2013 Juwe Takeheshi. All rights reserved.
//

#import "NSView+Layers.h"

@implementation NSView (Layers)

-(CALayer *)layerFromContents {

  CALayer *newLayer = [CALayer layer];
  newLayer.bounds = self.bounds;
  NSBitmapImageRep *bitmapRep = [self bitmapImageRepForCachingDisplayInRect:self.bounds];
  [self cacheDisplayInRect:self.bounds toBitmapImageRep:bitmapRep];
  newLayer.contents = (id)bitmapRep.CGImage;
  return newLayer;
}

@end
