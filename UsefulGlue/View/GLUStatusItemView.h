//
//  GLUStatusItemView.h
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 1/20/13.
//  Copyright (c) 2013 Juwe Takeheshi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GLUStatusItemView : NSView

@property (nonatomic, strong, readonly) NSStatusItem *statusItem;
@property (nonatomic, assign, readonly, getter = screenBasedFrame) NSRect screenBasedFrame;

- (id)initWithStatusItem:(NSStatusItem *)aStatusItem;
- (void)setTarget:(id)aTarget action:(SEL)anAction;
- (void)toggleIconSelection;

@end
