//
//  CCFAppDelegate.h
//  CoreDataSampleApp
//
//  Created by Cocoa Factory on 4/6/14.
//  Copyright (c) 2014 Cocoa Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
