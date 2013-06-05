//
//  GLUAppDelegate.h
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 10/25/12.
//  Copyright (c) 2012 Juwe Takeheshi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GLUAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;
- (void)saveContext;

@end
