//
//  GLUStatusItemController.m
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 1/20/13.
//  Copyright (c) 2013 Juwe Takeheshi. All rights reserved.
//

#import "GLUStatusItemController.h"
#import "GLUStatusItemView.h"
#import "GLUClipboardWindowController.h"

@interface GLUStatusItemController ()

@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) GLUStatusItemView *statusItemView;
@property (nonatomic, strong) GLUClipboardWindowController *clipboardWindowController;

@end

@implementation GLUStatusItemController

@synthesize statusItem;
@synthesize statusItemView;
@synthesize clipboardWindowController;

- (id)init {

  self = [super init];

  if (self) {

    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:22];
    self.statusItemView = [[GLUStatusItemView alloc] initWithStatusItem:self.statusItem];
    [self.statusItemView setTarget:self action:@selector(toggleMainPanelWindow)];
    self.clipboardWindowController.delegate = self;

    self.clipboardWindowController = [[GLUClipboardWindowController alloc] initWithWindowNibName:@"GLUClipboardWindow"];
  }

  return self;
}

- (GLUStatusItemView *)statusItemViewForMainPanelWindowController:(GLUClipboardWindowController *)mainPanelWindowController {

  return self.statusItemView;
}

- (void)toggleMainPanelWindow {

  [self.clipboardWindowController togglePanelVisibility];
}

- (void)toggleStatusItemSelection {

  [self.statusItemView toggleIconSelection];
}

- (void)mainPanelWillDissapear {

  [self toggleStatusItemSelection];
}

- (void)presentMainPanelWindow {

  [self toggleMainPanelWindow];
  [self toggleStatusItemSelection];
}

- (void)dealloc {

  [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
}

@end
