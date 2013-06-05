//
//  NSManagedObject+ActiveRecord.h
//  SugarFish
//
//  Created by Erick Camacho on 25/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ActiveRecord)

+ (NSManagedObjectContext *)managedObjectContext;

- (void)save;

- (void)remove;

- (void)refresh;

+ (id)create;

+ (id)findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue;

+ (NSArray *)findAllByAttribute:(NSString *)attribute withValue:(id)searchValue;

+ (NSArray *)findAll;

+ (NSArray *)executeQueryWithPredicate:(NSPredicate *)predicate;


@end
