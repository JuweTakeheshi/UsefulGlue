//
//  GLUPasteBoardWatcher.m
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 10/30/12.
//  Copyright (c) 2012 Juwe Takeheshi. All rights reserved.
//

#import "GLUPasteBoardWatcher.h"
//#import "GLUClipboardWindowController.h"
#import "GLUEntriesViewController.h"

@interface GLUPasteboardWatcher ()

@property (nonatomic, strong) NSPasteboard *pasteboard;
@property (nonatomic, assign) NSInteger changeCount;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation GLUPasteboardWatcher

@synthesize pasteboard = _pasteboard;
@synthesize changeCount = _changeCount;
@synthesize timer = _timer;
@synthesize delegate = _delegate;

- (id)init {
  
  if ((self = [super init])) {
    
    self.pasteboard = [NSPasteboard generalPasteboard];
    self.changeCount = [self.pasteboard changeCount];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0)
                                                  target:self
                                                selector:@selector(update:)
                                                userInfo:nil
                                                 repeats:YES];
  }

  return self;
}

- (void)update:(NSTimer *)theTimer {
  
  if ([self.pasteboard changeCount] != self.changeCount) {
    
    NSLog(@"Pasteboard has been updated!");
    self.changeCount = [self.pasteboard changeCount];

    if (![(GLUEntriesViewController *)self.delegate isUpdatedInternally]) {

      if ([self.delegate respondsToSelector:@selector(getClipboard:)]) {
        
        [self.delegate performSelector:@selector(getClipboard:) withObject:self];
      }
    }

    [(GLUEntriesViewController *)self.delegate setIsUpdatedInternally:NO];
  }
}

- (void)dealloc {
  
  [self.timer invalidate];
}

@end