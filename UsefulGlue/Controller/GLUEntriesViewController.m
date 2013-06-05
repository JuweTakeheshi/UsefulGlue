//
//  GLUEntriesViewController.m
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 2/4/13.
//  Copyright (c) 2013 Juwe Takeheshi. All rights reserved.
//

#import "GLUEntriesViewController.h"
#import "GLUStore.h"
#import "GLUEntry.h"
#import "GLUPasteboardWatcher.h"


@interface GLUEntriesViewController ()

@property (nonatomic, strong) GLUStore *pasteStore;
@property (nonatomic, strong) GLUPasteboardWatcher *pasteBoardWatcher;

- (void)bindTableView;
- (void)configurePasteboardWatcher;

@end

@implementation GLUEntriesViewController

@synthesize tableView = _tableView;
@synthesize isUpdatedInternally = _isUpdatedInternally;
@synthesize pasteStore = _pasteStore;
@synthesize pasteBoardWatcher = _pasteBoardWatcher;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  if (self) {

    self.pasteStore = [[GLUStore alloc] init];
    self.pasteBoardWatcher = [[GLUPasteboardWatcher alloc] init];
  }

  return self;
}

- (void)bindWithModel {

  [self bindTableView];
  [self configurePasteboardWatcher];
}

- (IBAction)getClipboard:(id)sender {
  
  NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
  
  NSString *content = [pasteBoard stringForType:NSPasteboardTypeString];
  
  [self.pasteStore saveGlueEntryWithString:content];
  
  [self.tableView reloadData];
}

- (void)bindTableView {

  [self.tableView setDataSource:self];
  [self.tableView setDelegate:self];
}

- (void)configurePasteboardWatcher {
  
  [self.pasteBoardWatcher setDelegate:self];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
  
  return [self.pasteStore numberOfEntries];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  
  NSView *view = [[NSView alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0, 0, 400, 50))];
  
  NSTextField *textField = [[NSTextField alloc] initWithFrame:NSRectFromCGRect(CGRectMake(50, 0, 390, 40))];
  [textField setStringValue:[self.pasteStore entryForIndex:row]];
  [textField setBordered:NO];
  [textField setBackgroundColor:[NSColor clearColor]];
  
  NSTextField *numberOfRowTextField = [[NSTextField alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0, 0, 40, 40))];
  [numberOfRowTextField setStringValue:[NSString stringWithFormat:@"%li", (row + 1)]];
  [numberOfRowTextField setBordered:NO];
  [numberOfRowTextField setAlignment:NSCenterTextAlignment];
  [numberOfRowTextField setBackgroundColor:[NSColor clearColor]];
  
  [view addSubview:textField];
  [view addSubview:numberOfRowTextField];
  
  return view;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
  return 50.0f;
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification {
  
  [self setIsUpdatedInternally:YES];
  
  if ([self.delegate respondsToSelector:@selector(closeWindow)]) {

    [self.delegate performSelector:@selector(closeWindow)];
  }

  NSInteger selectedRow = [[notification object] selectedRow];
  
  [self.pasteStore setNewValueWithIndex:selectedRow];
  [self executePasteScript];
}

-(void)executePasteScript {
  
  NSString *scriptSource = @"set name_ to name of (info for (path to frontmost application))\ntell application name_ to activate\ntell application \"System Events\"\nkeystroke \"v\" using {command down}\nend tell";
  
  NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:scriptSource];
  NSDictionary *scriptError = [[NSDictionary alloc] init];
  
  [appleScript executeAndReturnError:&scriptError];
}

- (IBAction)flipToSettings:(id)sender {

  if ([self.delegate respondsToSelector:@selector(toggleViews)]) {

    [self.delegate performSelector:@selector(toggleViews)];
  }
}

@end
