//
//  GLUStore.m
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 10/25/12.
//  Copyright (c) 2012 Juwe Takeheshi. All rights reserved.
//

#import "GLUStore.h"
#import "GLUEntry.h"
#import "NSManagedObject+ActiveRecord.h"

@implementation GLUStore

- (void)saveGlueEntryWithImage:(NSImage *)imageValue {

  GLUEntry *entry = [GLUEntry create];

  NSData *data = [imageValue TIFFRepresentation];
  [entry setImageValue:data];

  [entry save];
}

- (void)saveGlueEntryWithString:(NSString *)stringValue {

  if (stringValue != nil) {

    GLUEntry *entry = [GLUEntry create];
    
    [entry setStringValue:stringValue];
    [entry setDate:[NSDate date]];
    
    [entry save];
  }
}

- (id)lastEntry {

  NSArray *entries = [GLUEntry findAll];

  GLUEntry *entry = [entries objectAtIndex:1];

  return entry;
}

- (NSInteger)numberOfEntries {

  NSArray *allEntries = [GLUEntry findAll];

  return [allEntries count];
}

- (NSString *)entryForIndex:(NSInteger)index {

  NSArray *allEntries = [GLUEntry findAll];
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];

  NSArray *sortedArray = [NSArray arrayWithObject:sortDescriptor];
  NSArray *orderedArray = [allEntries sortedArrayUsingDescriptors:sortedArray];

  NSString *text = [((GLUEntry *)[orderedArray objectAtIndex:index]) stringValue];

  if (text == nil) {

    text = @"";
  }

  return text;
}

- (void)setNewValueWithIndex:(NSInteger)index {

  NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];

  NSArray *types = [NSArray arrayWithObjects:NSStringPboardType, nil];
  [pasteboard declareTypes:types owner:nil];

  NSString *value = [self entryForIndex:index];
  NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];

  [pasteboard setData:data forType:NSStringPboardType];
}

@end
