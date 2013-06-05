//
//  NSManagedObject+ActiveRecord.m
//  SugarFish
//
//  Created by Erick Camacho on 25/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSManagedObject+ActiveRecord.h"

#import "GLUAppDelegate.h"
//#import "INKCoreDataContextManager.h"

@implementation NSManagedObject (ActiveRecord)

+ (NSManagedObjectContext *)managedObjectContext
{
  
  NSManagedObjectContext *managedObjectContext = [((GLUAppDelegate *) [NSApplication sharedApplication].delegate) managedObjectContext];
  return managedObjectContext;
}

- (void)save
{
  
  [((GLUAppDelegate *) [NSApplication sharedApplication].delegate) saveContext];
}

- (void)remove
{
  NSManagedObjectContext *context = [self managedObjectContext];
  [context deleteObject:self];
}

- (void)refresh
{
  NSManagedObjectContext *context = [self managedObjectContext];
  [context refreshObject:self mergeChanges:YES];
}

+ (id)create
{
  NSString *entityName = NSStringFromClass([self class]);
  NSManagedObjectContext *context = [self managedObjectContext];
  
  return [NSEntityDescription insertNewObjectForEntityForName:entityName 
                                       inManagedObjectContext:context];
}

+ (id)findFirstByAttribute:(NSString *)attribute withValue:(id)searchValue
{	
  
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSManagedObjectContext *context = [self managedObjectContext];
  NSString *entityName = NSStringFromClass([self class]);  
  NSEntityDescription *anEntity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
	[request setEntity:anEntity];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", attribute, searchValue];
  
  [request setPredicate:predicate];
  //[request setPropertiesToFetch:[NSArray arrayWithObject:attribute]];
  [request setFetchLimit:1];
  NSError *error;
	NSArray *results = [context executeFetchRequest:request error:&error];
  if (!results) {
    NSLog(@"error in findFirstByAttribute %@", error);
    return nil;
  }
	if (![results count])
	{
		return nil;
	}
	return [results objectAtIndex:0];
  
}

+ (NSArray *)findAllByAttribute:(NSString *)attribute withValue:(id)searchValue
{
  NSLog(@"%s Class:%@ and attr:%@", __FUNCTION__, [self class], attribute);
  if (!searchValue)
  {
    NSLog(@"error, searchValue is nil");
    return nil;
  }
  
  if (!attribute)
  {
    NSLog(@"error, attribute is nil");
  }
  
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSManagedObjectContext *context = [self managedObjectContext];
  NSString *entityName = NSStringFromClass([self class]);  
	[request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
  [request setPropertiesToFetch:[NSArray arrayWithObject:attribute]];
  [request setPredicate:[NSPredicate predicateWithFormat:@"%K = %@", attribute, searchValue]];
  [request setPropertiesToFetch:[NSArray arrayWithObject:attribute]];
  
  NSError *error;
	NSArray *results = [context executeFetchRequest:request error:&error];
  if (!results) {
    NSLog(@"error in findFirstByAttribute %@", error);
    return nil;
  }
	return results;
  
}



+ (NSArray *)findAll
{
  NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
  NSManagedObjectContext *context = [self managedObjectContext];
  NSString *entityName = NSStringFromClass([self class]);  
	[request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
  NSError *error = nil;
  
	NSArray *results = [context executeFetchRequest:request error:&error];
	if (!results) {
    NSLog(@"error in findAll %@", error);
  }
	return results;	
}

+ (NSArray *)executeQueryWithPredicate:(NSPredicate *)predicate
{
  NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
  NSManagedObjectContext *context = [self managedObjectContext];
  NSString *entityName = NSStringFromClass([self class]);  
	[request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
  [request setPredicate:predicate];
  NSError *error = nil;
  
	NSArray *results = [context executeFetchRequest:request error:&error];
	if (!results) {
    NSLog(@"error in executeQueryWithPredicate %@", error);
  }
	return results;	
}


@end
