//
//  SwimmerDataStore.h
//  FlipTurnstile
//
//  Created by Chris Gonzales on 1/18/15.
//  Copyright (c) 2015 GNZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SwimmerDataStore : NSObject

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) NSManagedObjectModel *managedObjectModel;

+ (instancetype)sharedStore;
@end
