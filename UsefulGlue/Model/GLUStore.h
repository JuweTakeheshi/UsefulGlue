//
//  GLUStore.h
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 10/25/12.
//  Copyright (c) 2012 Juwe Takeheshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLUStore : NSObject

- (void)saveGlueEntryWithString:(NSString *)stringValue;
- (void)saveGlueEntryWithImage:(NSImage *)imageValue;
- (void)setNewValueWithIndex:(NSInteger)index;

- (id)lastEntry;

- (NSInteger)numberOfEntries;
- (NSString *)entryForIndex:(NSInteger)index;

@end
