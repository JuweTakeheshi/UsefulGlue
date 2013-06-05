//
//  GLUSettingsViewController.m
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 2/4/13.
//  Copyright (c) 2013 Juwe Takeheshi. All rights reserved.
//

#import "GLUSettingsViewController.h"

@interface GLUSettingsViewController ()

@end

@implementation GLUSettingsViewController

@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (IBAction)flipToEntries:(id)sender {

  if ([self.delegate respondsToSelector:@selector(toggleViews)]) {
    
    [self.delegate performSelector:@selector(toggleViews)];
  }
}

@end
