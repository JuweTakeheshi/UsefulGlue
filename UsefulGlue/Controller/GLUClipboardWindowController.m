//
//  GLUClipboardWindowController.m
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 10/30/12.
//  Copyright (c) 2012 Juwe Takeheshi. All rights reserved.
//

#import "GLUClipboardWindowController.h"
#import "GLUStatusItemView.h"
#import "GLUEntriesViewController.h"
#import "GLUSettingsViewController.h"
#import "CAAnimation+Animations.h"
#import "NSView+Layers.h"

@interface GLUClipboardWindowController ()

@property (nonatomic, assign) BOOL isPanelVisible;
@property (nonatomic, strong) GLUEntriesViewController *entriesViewController;
@property (nonatomic, strong) GLUSettingsViewController *settingsViewController;
@property (nonatomic, assign) BOOL isFlipped;
@property (nonatomic, strong) NSView *hostView;
@property (nonatomic, strong) NSView *frontView;
@property (nonatomic, strong) NSView *backView;
@property (nonatomic, strong) NSView *topView;
@property (nonatomic, strong) NSView *bottomView;
@property (nonatomic, strong) CALayer *topLayer;
@property (nonatomic, strong) CALayer *bottomLayer;

- (void)closeWindow;

@end

@implementation GLUClipboardWindowController

@synthesize delegate = _delegate;
@synthesize isPanelVisible;
@synthesize entriesViewController = _entriesViewController;
@synthesize settingsViewController = _settingsViewController;
@synthesize isFlipped = _isFlipped;
@synthesize frontView = _frontView;
@synthesize backView = _backView;
@synthesize topView = _topView;
@synthesize bottomView = _bottomView;
@synthesize topLayer = _topLayer;
@synthesize bottomLayer = _bottomLayer;
@synthesize hostView = _hostView;

- (id)initWithWindow:(NSWindow *)window {

  self = [super initWithWindow:window];
  if (self) {
    
    
  }
  
  return self;
}

- (void)windowDidLoad
{
  [super windowDidLoad];

  [self.entriesViewController bindWithModel];
}

- (void)awakeFromNib {

  [super awakeFromNib];

  self.entriesViewController = [[GLUEntriesViewController alloc] initWithNibName:@"GLUEntriesView" bundle:nil];
  [self.entriesViewController setDelegate:self];

  self.settingsViewController = [[GLUSettingsViewController alloc] initWithNibName:@"GLUSettingsView" bundle:nil];
  [self.settingsViewController setDelegate:self];

//  [self.window.contentView addSubview:self.settingsViewController.view];
  [self.window.contentView addSubview:self.entriesViewController.view];

  [self layoutWindow];
}

- (void)layoutWindow {

  NSPanel *panel = (NSPanel *)self.window;
  panel.acceptsMouseMovedEvents = YES;

  panel.level = NSPopUpMenuWindowLevel;
  [panel setOpaque:NO];
  panel.backgroundColor = [NSColor colorWithDeviceWhite:0.25 alpha:1.0];

  NSRect frame = self.window.frame;
  frame.size.height = self.window.frame.size.height;
  [self.window setFrame:frame display:NO];

  self.hostView = self.window.contentView;
  self.frontView = self.entriesViewController.view;
  self.backView = self.settingsViewController.view;
}

#pragma mark -
#pragma mark Panel Visibility

- (void)windowWillClose:(NSNotification *)notification {

  self.isPanelVisible = NO;
}

- (void)windowDidResignKey:(NSNotification *)notification {

  if(self.isPanelVisible) {

    self.isPanelVisible = NO;

    [self.delegate mainPanelWillDissapear];
    [self closePanelFromStatusBar];
  }
}

- (void)togglePanelVisibility {

  if (self.isPanelVisible) {

    [self closePanelFromStatusBar];
  }
  else {

    [self showPanelFromStatusBar];
  }
}

- (void)closePanelFromStatusBar {

  NSLog(@"Closing");

  [self.window orderOut:nil];

  self.isPanelVisible = NO;
}

- (void)showPanelFromStatusBar {

  NSLog(@"Opening");
  NSWindow *panel = self.window;

  NSRect statusBarFrame = [self statusBarRectForWindow:panel];

  NSRect panelFrame = [panel frame];
  panelFrame.origin.x = roundf(NSMidX(statusBarFrame) - NSWidth(panelFrame) / 2);
  panelFrame.origin.y = NSMaxY(statusBarFrame) - NSHeight(panelFrame);

  [NSApp activateIgnoringOtherApps:NO];
  [panel setFrame:panelFrame display:YES];

  [self.window makeKeyAndOrderFront:nil];
  
  self.isPanelVisible = YES;
}

- (NSRect)statusBarRectForWindow:(NSWindow *)window
{
  NSRect screenFrame = [[[NSScreen screens] objectAtIndex:0] frame];
  NSRect statusBarFrame = NSZeroRect;
  
  GLUStatusItemView *statusItemView = [self.delegate statusItemViewForMainPanelWindowController:self];
  
  
  if (statusItemView)
  {
    statusBarFrame = statusItemView.screenBasedFrame;
    statusBarFrame.origin.y = NSMinY(statusBarFrame) - NSHeight(statusBarFrame);
  }
  else
  {
    statusBarFrame.size = NSMakeSize(24.0, [[NSStatusBar systemStatusBar] thickness]);
    statusBarFrame.origin.x = roundf((NSWidth(screenFrame) - NSWidth(statusBarFrame)) / 2);
    statusBarFrame.origin.y = NSHeight(screenFrame) - NSHeight(statusBarFrame) * 2;
  }
  return statusBarFrame;
}

- (void)cancelOperation:(id)sender {

  self.isPanelVisible = NO;
}

- (void)closeWindow {

  [self.window orderOut:nil];
}

- (void)toggleViews {

  if (self.isFlipped) {

    self.topView = self.backView;
    self.bottomView = self.frontView;
  }
  else {

    self.topView = self.frontView;
    self.bottomView = self.backView;
  }
  
  CAAnimation *topAnimation = [CAAnimation flipAnimationWithDuration:0.3 forLayerBeginningOnTop:YES scaleFactor:1.3f];
  CAAnimation *bottomAnimation = [CAAnimation flipAnimationWithDuration:0.3 forLayerBeginningOnTop:NO scaleFactor:1.3f];

  self.bottomView.frame = self.topView.frame;
  self.topLayer = [self.topView layerFromContents];
  self.bottomLayer = [self.bottomView layerFromContents];
  
  CGFloat zDistance = 1500.0f;
  CATransform3D perspective = CATransform3DIdentity;
  perspective.m34 = -1. / zDistance;
  self.topLayer.transform = perspective;
  self.bottomLayer.transform = perspective;
  
  self.bottomLayer.frame = self.topView.frame;
  self.bottomLayer.doubleSided = NO;
  [self.hostView.layer addSublayer:self.bottomLayer];
  
  self.topLayer.doubleSided = NO;
  self.topLayer.frame = self.topView.frame;
  [self.hostView.layer addSublayer:self.topLayer];
  
  [CATransaction begin];
  [CATransaction setValue:[NSNumber numberWithBool:YES] forKey:kCATransactionDisableActions];
  [self.topView removeFromSuperview];
  [CATransaction commit];
  
  topAnimation.delegate = self;
  [CATransaction begin];
  [self.topLayer addAnimation:topAnimation forKey:@"flip"];
  [self.bottomLayer addAnimation:bottomAnimation forKey:@"flip"];
  [CATransaction commit];
}

-(void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {

  self.isFlipped = !self.isFlipped;
  [CATransaction begin];
  [CATransaction setValue:[NSNumber numberWithBool:YES] forKey:kCATransactionDisableActions];
  [self.hostView addSubview:self.bottomView];
  [self.topLayer removeFromSuperlayer];
  [self.bottomLayer removeFromSuperlayer];
  self.topLayer = nil;
  self.bottomLayer = nil;

  [CATransaction commit];
}

@end
