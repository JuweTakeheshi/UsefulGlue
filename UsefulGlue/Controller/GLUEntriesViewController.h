//
//  GLUEntriesViewController.h
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 2/4/13.
//  Copyright (c) 2013 Juwe Takeheshi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GLUEntriesViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, weak) IBOutlet NSTableView *tableView;
@property (nonatomic, assign) BOOL isUpdatedInternally;
@property (nonatomic, weak) id delegate;

- (IBAction)getClipboard:(id)sender;
- (IBAction)flipToSettings:(id)sender;
- (void)bindWithModel;


@end
