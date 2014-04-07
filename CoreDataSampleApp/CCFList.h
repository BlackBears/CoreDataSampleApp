//
//  CCFList.h
//  CoreDataSampleApp
//
//  Created by Cocoa Factory on 4/6/14.
//  Copyright (c) 2014 Cocoa Factory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CCFItem;

@interface CCFList : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *items;
@end

@interface CCFList (CoreDataGeneratedAccessors)

- (void)addItemsObject:(CCFItem *)value;
- (void)removeItemsObject:(CCFItem *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
