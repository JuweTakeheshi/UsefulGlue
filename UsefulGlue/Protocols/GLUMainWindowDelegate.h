//
//  GLUMainWindowDelegate.h
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 1/20/13.
//  Copyright (c) 2013 Juwe Takeheshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLUStatusItemView;
@class GLUClipboardWindowController;

@protocol GLUMainWindowDelegate <NSObject>

- (GLUStatusItemView *)statusItemViewForMainPanelWindowController:(GLUClipboardWindowController *)mainPanelWindowController;
- (void)mainPanelWillDissapear;

@end
