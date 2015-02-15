//
//  SwimmerDataStore.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class GNZRoster;

@interface GNZSwimmerDataStore : NSObject

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, readonly, nonatomic) GNZRoster *roster;

+ (instancetype)sharedStore;
- (void)loadData;
- (NSURL *)applicationDocumentsDirectory;
@end
