//
//  GLUSettingsViewController.h
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 2/4/13.
//  Copyright (c) 2013 Juwe Takeheshi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GLUSettingsViewController : NSViewController

@property (nonatomic, weak) id delegate;

- (IBAction)flipToEntries:(id)sender;

@end
