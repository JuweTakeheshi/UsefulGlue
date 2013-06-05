//
//  GLUEntry.h
//  UsefulGlue
//
//  Created by Juwe Takeheshi on 10/31/12.
//  Copyright (c) 2012 Juwe Takeheshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GLUEntry : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * stringValue;
@property (nonatomic, retain) NSData * imageValue;

@end
