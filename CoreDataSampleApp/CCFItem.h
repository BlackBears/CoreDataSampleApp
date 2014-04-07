//
//  CCFItem.h
//  CoreDataSampleApp
//
//  Created by Cocoa Factory on 4/6/14.
//  Copyright (c) 2014 Cocoa Factory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CCFList;

@interface CCFItem : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) CCFList *list;

@end
