//
//  GLUClipboardWindowController.h
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 10/30/12.
//  Copyright (c) 2012 Juwe Takeheshi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GLUMainWindowDelegate.h"

@interface GLUClipboardWindowController : NSWindowController

@property (nonatomic, weak) id<GLUMainWindowDelegate> delegate;

- (void)togglePanelVisibility;
- (void)toggleViews;

@end
