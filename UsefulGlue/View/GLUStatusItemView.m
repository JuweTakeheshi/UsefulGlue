//
//  GLUStatusItemView.m
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 1/20/13.
//  Copyright (c) 2013 Juwe Takeheshi. All rights reserved.
//

#import "GLUStatusItemView.h"
#import <objc/message.h>

@interface GLUStatusItemView ()

@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSImage *icon;
@property (nonatomic, strong) NSImage *highlightedIcon;
@property (nonatomic, assign) BOOL isHighlighted;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;

@end

@implementation GLUStatusItemView

@synthesize statusItem;
@synthesize icon;
@synthesize highlightedIcon;
@synthesize screenBasedFrame;
@synthesize isHighlighted;
@synthesize target;
@synthesize action;

- (id)initWithStatusItem:(NSStatusItem *)aStatusItem {

  CGFloat statusItemWidth = aStatusItem.length;
  CGFloat statusItemHeight = [[NSStatusBar systemStatusBar] thickness];
  
  NSRect statusItemFrame = NSMakeRect(0.0, 0.0, statusItemWidth, statusItemHeight);

  self = [super initWithFrame:statusItemFrame];

  if (self) {

    self.statusItem = aStatusItem;
    self.statusItem.view = self;
    [self initIcons];
  }

  return self;
}

- (void)initIcons {

  self.icon = [NSImage imageNamed:@"icnUsefulGlue.png"];
  self.highlightedIcon = [NSImage imageNamed:@"icnUsefulGlue22.png"];
}

- (void)drawRect:(NSRect)dirtyRect {

  [self.statusItem drawStatusBarBackgroundInRect:dirtyRect
                                   withHighlight:NO];
  
  NSImage *statusItemIcon = self.icon;
  
  NSSize statusItemIconSize = NSMakeSize(20, 20);
  NSRect statusItemIconBounds = self.bounds;
  CGFloat statusItemIconCenterX = roundf((NSWidth(statusItemIconBounds) - statusItemIconSize.width) / 2);
  CGFloat statusItemIconCenterY = roundf((NSHeight(statusItemIconBounds) - statusItemIconSize.height) / 2);
  
  [statusItemIcon drawInRect:NSMakeRect(statusItemIconCenterX,
                                        statusItemIconCenterY,
                                        statusItemIconSize.width,
                                        statusItemIconSize.height)
                    fromRect:NSZeroRect
                   operation:NSCompositeSourceOver
                    fraction:1.0];
}

- (NSRect)screenBasedFrame {

  NSRect actualFrame = self.frame;
  actualFrame.origin = [self.window convertBaseToScreen:actualFrame.origin];
  
  return actualFrame;
}

- (void)toggleIconSelection {

  self.isHighlighted = !self.isHighlighted;
  
  [self setNeedsDisplay:YES];
}

- (void)setTarget:(id)aTarget action:(SEL)anAction {

  self.target = aTarget;
  self.action = anAction;
}

#pragma mark -
#pragma mark Mouse tracking

- (void)mouseDown:(NSEvent *)theEvent
{
  [self toggleIconSelection];
  
  objc_msgSend(self.target, self.action);
}

@end
